-- 2. Intermediate Problems

-- 20. For this problem, we’d like to see the total number of
-- products in each category. Sort the results by the total
-- number of products, in descending order

-- Total Cost: 0.019445
select count(ProductID) as ProductsCount,
       CategoryName
from Products
         join Categories C on Products.CategoryID = C.CategoryID
group by CategoryName
order by count(ProductID) desc;

SELECT distinct COUNT(*) OVER (PARTITION BY Cat.CategoryName) AS TotalProducts, 
       Cat.CategoryName
FROM Products Pr
JOIN Categories Cat ON Pr.CategoryID = Cat.CategoryID
ORDER BY count(ProductID) desc;

--
WITH ProductCounts AS (SELECT P.CategoryID
                            , COUNT(ProductID) AS totalNumOfProducts
                       FROM Products P
                       GROUP BY CategoryID)
SELECT C.CategoryName,
       PC.totalNumOfProducts
FROM Categories C
         JOIN ProductCounts PC ON C.CategoryID = PC.CategoryID
ORDER BY totalNumOfProducts DESC;


-- Total cost 0.019445
select C.CategoryName
     , count(ProductID) as NoOfProducts
from Categories C
         join Products P on C.CategoryID = P.CategoryID
group by C.CategoryName
order by NoOfProducts desc;

-- Total cost: 0.00928402
-- non-dedu
select C.CategoryName
     , count(ProductID) over (partition by C.CategoryName) as NoOfProducts
from Categories C
         join Products P on C.CategoryID = P.CategoryID;

-- Total cost: 0.0212145
select distinct C.CategoryName
              , count(ProductID) over (partition by C.CategoryName) as NoOfProducts
from Categories C
         join Products P on C.CategoryID = P.CategoryID
order by NoOfProducts desc;

-- Total cost: 0.0212145
select T.CategoryName
     , T.NoOfProducts
from (
         select C.CategoryName
              , count(ProductID) over (partition by C.CategoryName) as NoOfProducts
         from Categories C
                  join Products P on C.CategoryID = P.CategoryID) as T
group by T.CategoryName, T.NoOfProducts
order by NoOfProducts desc;

-- Total cost: 0.0327374
select *
from (
         select C.CategoryName
              , count(ProductID) over (partition by C.CategoryName)                 as NoOfProducts
              , row_number() over (partition by C.CategoryID order by CategoryName) as Rank
         from Categories C
                  join Products P on C.CategoryID = P.CategoryID) as T
where T.Rank < 2
order by NoOfProducts desc;

-- 21. In the Customers table, show the total number of
-- customers per Country and City.

select count(CustomerID)
from Customers;

-- Total cost: 0.029534
select Country,
       City,
       count(CustomerID) as Count
from Customers
group by Country, City
order by count(CustomerID) desc;

-- Total cost: 0.04453344
select City
     , count(CustomerID) over (partition by City)    as CityCount
     , Country
     , count(CustomerID) over (partition by Country) as CountryCount
from Customers
order by CountryCount desc;


-- 22.What products do we have in our inventory that
-- should be reordered? For now, just use the fields
-- UnitsInStock and ReorderLevel, where UnitsInStock
-- is less than the ReorderLevel, ignoring the fields
-- UnitsOnOrder and Discontinued.
-- Order the results by ProductID.

-- Total cost: 0.0033667
select ProductID
     , ProductName
     , UnitsInStock
--      , ReorderLevel
from Products
where UnitsInStock < ReorderLevel
order by ProductID;

-- 23. Now we need to incorporate these fields:
-- UnitsInStock, UnitsOnOrder, ReorderLevel,
-- Discontinued—into our calculation. We’ll define
-- “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than
-- or equal to ReorderLevel.
-- The Discontinued flag is false (0).

select ProductID,
       ProductName,
       UnitsInStock,
       UnitsOnOrder,
       ReorderLevel,
       Discontinued
from Products
where (UnitsInStock + UnitsOnOrder) <= ReorderLevel
  and Discontinued = 0
order by ProductID;

-- 24. A salesperson for Northwind is going on a business
-- trip to visit customers, and would like to see a list of
-- all customers, sorted by region, alphabetically.
-- However, he wants the customers with no region
-- (null in the Region field) to be at the end, instead of
-- at the top, where you’d normally find the null values.
-- Within the same region, companies should be sorted
-- by CustomerID.

-- Total cost: 0.0171581
select *
from Customers
order by IIF(Region is null, 1, 0), Region, CustomerID;

select *
from Customers
order by (case
              when Region is null then 1
              else 0 end), Region, CustomerID;


-- 25. Some of the countries we ship to have very high
-- freight charges. We'd like to investigate some more
-- shipping options for our customers, to be able to
-- offer them lower freight charges. Return the three
-- ship countries with the highest average freight
-- overall, in descending order by average freight.

select top 3 format(avg(Freight), 'N2') as Freight,
             ShipCountry
from Orders
group by ShipCountry
order by avg(Freight) desc;


-- No of Orders per ShipCountry
select ShipCountry
     , count(*)
from Orders
group by ShipCountry;

-- All stats
select distinct ShipCountry
              , count(Freight) over (partition by ShipCountry) as CountOfFrights
              , avg(Freight) over (partition by ShipCountry)   as AVG_Country
              , max(Freight) over (partition by ShipCountry)   as MAX_Country
              , min(Freight) over (partition by ShipCountry)   as MIN_Country
              , sum(Freight) over (partition by ShipCountry)   as SUM_Country
from Orders
order by MAX_Country desc;


-- 26. We're continuing on the question above on high
-- freight charges. Now, instead of using all the orders
-- we have, we only want to see orders from the year
-- 2015.

select top 3 format(avg(Freight), 'N2') as AvgFreight,
             ShipCountry
from Orders
where OrderDate between '2015-01-01' and '2016-01-01'
group by ShipCountry
order by avg(Freight) desc;

-- 28. We're continuing to work on high freight charges.
-- We now want to get the three ship countries with the
-- highest average freight charges. But instead of
-- filtering for a particular year, we want to use the last
-- 12 months of order data, using as the end date the last
-- OrderDate in Orders.

select top 3 Dateadd(yy, -1, (Select Max(OrderDate) from Orders)),
             format(avg(Freight), 'N2') as AvgFreight,
             ShipCountry
from Orders
group by ShipCountry
order by AvgFreight;

-- 29. We're doing inventory, and need to show information
-- like the below, for all orders. Sort by OrderID and
-- Product ID.

select Employees.EmployeeID,
       Employees.LastName,
       O.OrderID,
       ProductName,
       Quantity
from Employees
         join Orders O on Employees.EmployeeID = O.EmployeeID
         join OrderDetails OD on O.OrderID = OD.OrderID
         join Products P on OD.ProductID = P.ProductID
order by OrderID, P.ProductID;

-- 30. There are some customers who have never actually
-- placed an order. Show these customers.

select Customers.CustomerID,
       CompanyName,
       ContactName,
       ContactTitle
from Customers
         full outer join Orders O on Customers.CustomerID = O.CustomerID
where OrderID is null;

-- 31. One employee (Margaret Peacock, EmployeeID 4)
-- has placed the most orders. However, there are some
-- customers who've never placed an order with her.
-- Show only those customers who have never placed
-- an order with her.

select Employees.EmployeeID,
       FirstName,
       LastName,
       C.CustomerID,
       CompanyName,
       ContactName
from Employees
         left join Orders O on Employees.EmployeeID = O.EmployeeID
    and Employees.EmployeeID = 4
         left join Customers C on O.CustomerID = C.CustomerID
where C.CustomerID is null;

-- The end of Intermediate Problems.
