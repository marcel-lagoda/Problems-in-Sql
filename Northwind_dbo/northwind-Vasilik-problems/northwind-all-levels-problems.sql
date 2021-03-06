-- 1. Introductory problems

-- 1. Which shippers do we have? Return all the fields from all the shippers.

select *
from Shippers;

-- 2. Return CategoryName & Description from Categories.

select CategoryName,
       Description
from Categories;

-- 3. We’d like to see just the FirstName, LastName, and
-- HireDate of all the employees with the Title of Sales
-- Representative. Write a SQL statement that returns
-- only those employees.

select FirstName,
       LastName,
       HireDate
from Employees
where Title = 'Sales Representative';

-- 4. Now we’d like to see the same columns as above, but
-- only for those employees that both have the title of
-- Sales Representative, and also are in the United
-- States.

select FirstName,
       LastName,
       HireDate
from Employees
where Title = 'Sales Representative'
  and Country = 'USA';

select Country
from Employees;

-- 5. Show all the orders placed by a specific employee.
-- The EmployeeID for this Employee (Steven
-- Buchanan) is 5.

select *
from Orders
         join Employees E on Orders.EmployeeID = E.EmployeeID
where E.EmployeeID = 5;

select OrderID,
       OrderDate
from Orders
         join Employees E on Orders.EmployeeID = E.EmployeeID
where E.EmployeeID = 5;

-- 6. In the Suppliers table, show the SupplierID,
-- ContactName, and ContactTitle for those Suppliers
-- whose ContactTitle is not Marketing Manager.

select SupplierID,
       ContactName,
       ContactTitle
from Suppliers
where ContactTitle <> 'Marketing Manager';

-- 7. In the products table, we’d like to see the ProductID
-- and ProductName for those products where the
-- ProductName includes the string “queso”.

select ProductID,
       ProductName
from Products
where ProductName like '%queso%';

-- 8. Looking at the Orders table, there’s a field called
-- ShipCountry. Write a query that shows the OrderID,
-- CustomerID, and ShipCountry for the orders where
-- the ShipCountry is either France or Belgium.

select OrderID,
       CustomerID,
       ShipCountry
from Orders
where ShipCountry in ('France', 'Belgium');

-- 9. We want to show all the
-- orders from any Latin American country.

select *
from Orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

-- 10. For all the employees in the Employees table, show
-- the FirstName, LastName, Title, and BirthDate.
-- Order the results by BirthDate, so we have the oldest
-- employees first.

select FirstName,
       LastName,
       Title,
       BirthDate
from Employees
order by BirthDate;

-- 11. Show only the date portion of the BirthDate field.

select FirstName,
       LastName,
       Title,
       cast(BirthDate as DATE)
from Employees
order by BirthDate;

-- 12. Show the FirstName and LastName columns from
-- the Employees table, and then create a new column
-- called FullName, showing FirstName and LastName
-- joined together in one column, with a space in-
-- between.

select FirstName,
       LastName,
       concat_ws(' ', FirstName, LastName) as FullName
from Employees;

-- 13. In the OrderDetails table, we have the fields
-- UnitPrice and Quantity. Create a new field,
-- TotalPrice, that multiplies these two together. We’ll
-- ignore the Discount field for now.
-- In addition, show the OrderID, ProductID, UnitPrice,
-- and Quantity. Order by OrderID and ProductID.

select OrderID,
       ProductID,
       UnitPrice,
       Quantity,
       format(UnitPrice + Quantity, 'N2') as TotalPrice
from OrderDetails;

-- 14. How many customers do we have in Customers table?

select count(CustomerID)
from Customers;

-- 15. Show the date of the first order ever made in the Orders table.

select min(cast(OrderDate as date)) as TheOldest
from Orders;

-- 16. Show a list of countries where the Northwind company has customers.

select distinct Country
from Customers;

select Country
from Customers
group by Country;

-- 17. Show a list of all the different values in the
-- Customers table for ContactTitles. Also include a
-- count for each ContactTitle

select ContactTitle,
       count(ContactTitle) as Count
from Customers
group by ContactTitle
order by Count(ContactTitle) desc;

-- 18. We’d like to show, for each product, the associated
-- Supplier. Show the ProductID, ProductName, and the
-- CompanyName of the Supplier. Sort by ProductID.

select ProductID,
       ProductName,
       CompanyName
from Products
         join Suppliers S on Products.SupplierID = S.SupplierID
order by ProductID;

-- 19. We’d like to show a list of the Orders that were
-- made, including the Shipper that was used. Show the
-- OrderID, OrderDate (date only), and CompanyName
-- of the Shipper, and sort by OrderID.

select OrderID,
       cast(OrderDate as DATE),
       CompanyName
from Orders natural
         join Shippers S on S.ShipperID = natural.ShipVia
order by OrderID;

-- The end of Introductory Problems.

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


-- 3. Advanced Problems

-- 32. High-value customers
-- We want to send all of our high-value customers a
-- special VIP gift. We're defining high-value
-- customers as those who've made at least 1 order with
-- a total value (not including the discount) equal to
-- $10,000 or more. We only want to consider orders
-- made in the year 2016.

select Customers.CustomerID,
       Customers.CompanyName,
       O.OrderID,
       TotalValue = sum(UnitPrice * Quantity),
       O.OrderDate
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName, O.OrderID, O.OrderDate
having sum(UnitPrice * Quantity) >= 10000
order by TotalValue desc;

-- window function
select *
from (
         select distinct Customers.CustomerID,
                         Customers.CompanyName,
                         O.OrderID,
                         sum(Quantity * UnitPrice) over (partition by O.OrderID) as TotalValue
         from Customers
                  join Orders O on Customers.CustomerID = O.CustomerID
                  join OrderDetails OD on O.OrderID = OD.OrderID
         where OrderDate >= '2016-01-01'
           and OrderDate < '2017-01-01'
     ) as t
where TotalValue >= 10000
order by TotalValue desc;


-- 33. The manager has changed his mind. Instead of
-- requiring that customers have at least one individual
-- orders totaling $10,000 or more, he wants to define
-- high-value customers as those who have orders
-- totaling $15,000 or more in 2016. How would you
-- change the answer to the problem above?

-- Total cost: 0.125612
select Customers.CustomerID,
       Customers.CompanyName,
       sum(OD.Quantity * OD.UnitPrice) as TotalValue
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName
having sum(Quantity * UnitPrice) > 15000
order by TotalValue desc;


-- Total cost: 0.14045
select *
from (
         select distinct CompanyName
                       , sum(UnitPrice * OD.Quantity) over (partition by O.CustomerID) as Totals
         from Customers
                  join Orders O on Customers.CustomerID = O.CustomerID
                  join OrderDetails OD on O.OrderID = OD.OrderID
         where OrderDate between '2016-01-01' and '2017-01-01') as T
where Totals >= 15000
order by Totals desc;


-- 34. Change the above query to use the discount when
-- calculating high-value customers. Order by the total
-- amount which includes the discount.

select Customers.CustomerID,
       Customers.CompanyName,
       sum(OD.UnitPrice * OD.Quantity)                     as TotalValue,
       sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) as TotalValueDiscounted
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName
having sum(Quantity * UnitPrice * (1 - Discount)) > 10000
order by TotalValueDiscounted desc;


-- 35. At the end of the month, salespeople are likely to try
-- much harder to get orders, to meet their month-end
-- quotas. Show all orders made on the last day of the
-- month. Order by EmployeeID and OrderID


select OrderID,
       EmployeeID,
       cast(OrderDate as date) as OrderDate
from Orders
where OrderDate = eomonth(OrderDate)
order by OrderID, EmployeeID;

-- 36. The Northwind mobile app developers are testing an
-- app that customers will use to show orders. In order
-- to make sure that even the largest orders will show
-- up correctly on the app, they'd like some samples of
-- orders that have lots of individual line items. Show
-- the 10 orders with the most line items, in order of
-- total line items.

select top 10 OrderDetails.OrderID,
              count(P.ProductID) as ProductsCaunt
--        ProductName
from OrderDetails
         join Products P on OrderDetails.ProductID = P.ProductID
group by OrderDetails.OrderID
order by ProductsCaunt desc;

-- 37. The Northwind mobile app developers would now
-- like to just get a random assortment of orders for beta
-- testing on their app. Show a random set of 2% of all
-- orders.

select top 2 percent OrderID
from Orders
order by newid();

-- 38. Janet Leverling, one of the salespeople, has come to
-- you with a request. She thinks that she accidentally
-- double-entered a line item on an order, with a
-- different ProductID, but the same quantity. She
-- remembers that the quantity was 60 or more. Show
-- all the OrderIDs with line items that match this, in
-- order of OrderID.

select OrderID
from OrderDetails
where Quantity >= 60
group by OrderID, Quantity
having count(*) > 1;


select *
from OrderDetails
where OrderID in (10263, 10990, 10658, 11030);

-- 39. Based on the previous question, we now want to
-- show details of the order, for orders that match the
-- above criteria.

-- CTE solution
with Doubles as
         (
             select OrderID
             from OrderDetails
             where Quantity >= 60
             group by OrderID, Quantity
             having count(*) > 1
         )
select OrderID
     , ProductID
     , UnitPrice
     , Quantity
     , Discount
from OrderDetails
where OrderID in
      (
          select OrderID
          from Doubles
      )
order by OrderID;


-- 40.

select OrderDetails.OrderID
     , ProductID
     , UnitPrice
     , Quantity
     , Discount
from OrderDetails
         join (select distinct OrderID
               from OrderDetails
               where Quantity >= 60
               group by OrderID, Quantity
               having count(*) > 1) as Doubles
              on Doubles.OrderID = OrderDetails.OrderID
order by OrderID, ProductID;

-- 41. Some customers are complaining about their orders arriving late.
-- Which orders are late?

select OrderID
     , cast(OrderDate as date)    as OrderDate
     , cast(RequiredDate as date) as RequiredDate
     , cast(ShippedDate as date)  as ShippedDate
from Orders
where RequiredDate <= ShippedDate;

-- 42. Some salespeople have more orders arriving late than others.
-- Maybe they're not following up on the order process, and need more training.
-- Which salespeople have the most orders arriving late?

select E.EmployeeID
     , count(E.EmployeeID) as Employees
from Orders
         join Employees E on Orders.EmployeeID = E.EmployeeID
where RequiredDate <= ShippedDate
group by E.EmployeeID
order by Employees desc;

-- window function (with order's details)
select OrderID
     , cast(OrderDate as date)                              as OrderDate
     , cast(RequiredDate as date)                           as RequiredDate
     , cast(ShippedDate as date)                            as ShippedDate
     , E.EmployeeID
     , count(E.EmployeeID) over (partition by E.EmployeeID) as LateEmp
from Orders
         join Employees E on Orders.EmployeeID = E.EmployeeID
where RequiredDate <= ShippedDate
order by LateEmp desc;


-- 43. Andrew, the VP of sales, has been doing some more thinking
-- about the problems of late orders.
-- He realized that just looking at the number of of orders arriving late
-- for each salesperson isn't a good idea. It needs to be compared against
-- the total number of orders per salesperson.

with LateOrders as
    (
        select EmployeeID
             , count(*) as LOrders
        from Orders
        where RequiredDate <= ShippedDate
        group by EmployeeID
    )
   , AllOrders as
    (
        select EmployeeID
             , count(*) as AOrders
        from Orders
        group by EmployeeID
    )
select              Employees.EmployeeID
     ,              LastName
     , AllOrders  = AllOrders.AOrders
     , LateOrders = LateOrders.LOrders
     ,              format(100.00 * sum(LateOrders.LOrders) over (partition by Employees.EmployeeID) /
                           sum(AllOrders.AOrders) over (partition by Employees.EmployeeID), 'N2') as PercentOfLateOrders
from Employees
         join LateOrders
              on LateOrders.EmployeeID = Employees.EmployeeID
         join AllOrders
              on AllOrders.EmployeeID = Employees.EmployeeID
order by EmployeeID;

-- 44. There's an employee missing in the answer from the problem above.
-- Fix the SQL to show all employees who have taken orders.

with AllOrders as
    (
        select EmployeeID
             , count(*) as TotalOrders
        from Orders
        group by EmployeeID
    )
   , LateOrders as
    (
        select EmployeeID
             , count(*) as TotalOrders
        from Orders
        where RequiredDate <= ShippedDate
        group by EmployeeID
    )
select Employees.EmployeeID
     , LastName
     , FirstName
     , AllOrders  = AllOrders.TotalOrders
     , LateOrders = LateOrders.TotalOrders
from Employees
         join AllOrders
              on AllOrders.EmployeeID = Employees.EmployeeID
         left join LateOrders
                   on LateOrders.EmployeeID = Employees.EmployeeID;


-- 45. Counting on the answer for above query, let's fix the results for row 5 - Buchanan.
-- He should have a 0 instead of a Null in LateOrders.

with AllOrders as (select EmployeeID
                        , count(*) as TotalOrders
                   from Orders
                   group by EmployeeID)
   , LateOrders as (select EmployeeID
                         , count(*) as TotalOrders
                    from Orders
                    where RequiredDate <= ShippedDate
                    group by EmployeeID)
select Employees.EmployeeID
     , LastName
     , AllOrders  = AllOrders.TotalOrders
     , LateOrders = isNull(LateOrders.TotalOrders, 0)
from Employees
         join AllOrders
              on AllOrders.EmployeeID = Employees.EmployeeID
         left join LateOrders
                   on LateOrders.EmployeeID = Employees.EmployeeID;


-- 46. Now we want to get the percentage of late orders over total orders.

with AllOrders as (select EmployeeID
                        , count(*) as TotalOrders
                   from Orders
                   group by EmployeeID)
   , LateOrders as (select EmployeeID
                         , count(*) as TotalOrders
                    from Orders
                    where RequiredDate <= ShippedDate
                    group by EmployeeID)
select              Employees.EmployeeID
     ,              LastName
     , AllOrders  = AllOrders.TotalOrders
     , LateOrders = isNull(LateOrders.TotalOrders, 0)
     ,              isNull(format(100.00 * sum(LateOrders.TotalOrders) over (partition by Employees.EmployeeID) /
                                  sum(AllOrders.TotalOrders) over ( partition by Employees.EmployeeID), 'N2'),
                           0) as prct
from Employees
         join AllOrders
              on AllOrders.EmployeeID = Employees.EmployeeID
         left join LateOrders
                   on LateOrders.EmployeeID = Employees.EmployeeID

-- % of Not Late Orders

with AllOrders as
    (
        select EmployeeID
             , count(*) TotalOrders
        from Orders
        group by EmployeeID
    )
   , NotLateOrders as
    (
        select EmployeeID
             , count(*) as TotalOrders
        from Orders
        where RequiredDate >= ShippedDate
        group by EmployeeID
    )
select                 Employees.EmployeeID
     ,                 LastName
     , AllOrders     = AllOrders.TotalOrders
     , NotLateOrders = NotLateOrders.TotalOrders
     ,                 format(100.00 * sum(NotLateOrders.TotalOrders) over (partition by Employees.EmployeeID) /
                              sum(AllOrders.TotalOrders) over (partition by Employees.EmployeeID), 'N2') +
                       '%' as NotLatePrc
--      ,                 AllOrders.TotalOrders - NotLateOrders.TotalOrders
from Employees
         join AllOrders
              on AllOrders.EmployeeID = Employees.EmployeeID
         left join NotLateOrders
                   on NotLateOrders.EmployeeID = Employees.EmployeeID;


-- select count(*) as TotalOrders
-- from Orders
-- where ShippedDate is Null;


-- 48. Categorize customers into groups, based how much they ordered in 2016.
-- Then, depending on which group the customer is in, he will target the customer
-- with different sales materials.
-- The customers grouping categories are:
-- 0 to 1000
-- 1000 to 5000
-- 5000 to 10000
-- 10000 +
-- Order the results by customerID.


-- windows functions (with no of orders)
select distinct Customers.CustomerID
              , TotalOrdersAmount = sum(OD.UnitPrice * OD.Quantity) over (partition by Customers.CustomerID)
              , CustomerGroupName = (
    case
        when sum(OD.UnitPrice * OD.Quantity)
                 over (partition by Customers.CustomerID) between 0 and 1000
            then 'low'
        when sum(OD.UnitPrice * OD.Quantity)
                 over (partition by Customers.CustomerID) between 1001 and 5000
            then 'medium'
        when sum(OD.UnitPrice * OD.Quantity)
                 over (partition by Customers.CustomerID) between 5001 and 10000
            then 'high'
        when sum(OD.UnitPrice * OD.Quantity)
                 over (partition by Customers.CustomerID) > 10000
            then 'very high'
        end
    )
              , CustomersOrders   = count(O.OrderID) over (partition by Customers.CustomerID)
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate between '2015-12-31' and '2017-01-01'
-- order by CustomerID;
order by CustomersOrders desc;

-- CTE
with CTE as
         (
             select Customers.CustomerID
                  , Customers.CompanyName
                  , sum(Quantity * UnitPrice) as OrdersAmount
             from Customers
                      join Orders O on Customers.CustomerID = O.CustomerID
                      join OrderDetails OD on O.OrderID = OD.OrderID
             where O.OrderDate between '2015-12-31' and '2017-01-01'
             group by Customers.CustomerID, Customers.CompanyName
         )
select CustomerID
     , CompanyName
     , format(CTE.OrdersAmount, 'N2') as Amount
     , CustomerGroups =
       case
           when CTE.OrdersAmount between 0 and 1000 then 'Low'
           when CTE.OrdersAmount between 1001 and 5000 then 'Medium'
           when CTE.OrdersAmount between 5001 and 10000 then 'High'
           when CTE.OrdersAmount >= 10001 then 'Very High'
           end
from CTE
order by CustomerID;

-- 49. There's a bug with the answer for the previous question.
-- The CustomerGroup Value for one of the rows is null. Fix it.

select distinct Orders.CustomerID
              , OrdersValue             = sum(OD.Quantity * OD.UnitPrice) over (partition by Orders.CustomerID)
              , CustomerGroupThresholds =
    (
        case
            when sum(OD.Quantity * OD.UnitPrice) over (partition by Orders.CustomerID) between 0.00 and 999.99
                then 'low'
            when sum(OD.Quantity * OD.UnitPrice) over (partition by Orders.CustomerID) between 1000.00 and 4999.99
                then 'medium'
            when sum(OD.Quantity * OD.UnitPrice) over (partition by Orders.CustomerID) between 5000 and 9999.99
                then 'high'
            when sum(OD.Quantity * OD.UnitPrice) over (partition by Orders.CustomerID) >= 10000
                then 'very high'
            end
        )
from Orders
         join OrderDetails OD on Orders.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate <= '2017-01-01'
order by CustomerID;

-- 50. Based on the above query, show all the defined CustomersGroups
-- and the percentage in each. Sort by the total in each group, in descending order.

with Orders2016 as (
    select Customers.CustomerID
         , Customers.CompanyName
         , TotalOrderAmount = sum(OD.Quantity * OD.UnitPrice)
    from Customers
             join Orders O on Customers.CustomerID = O.CustomerID
             join OrderDetails OD on O.OrderID = OD.OrderID
    where OrderDate >= '2016-01-01'
      and OrderDate < '2017-01-01'
    group by Customers.CustomerID, Customers.CompanyName
)
   , CustomersGroups as
    (
        select CustomerID
             , CompanyName
             , TotalOrderAmount
             , CustomerGroup =
            (
                case
                    when
                        TotalOrderAmount >= 0 and TotalOrderAmount < 1000
                        then 'low'
                    when TotalOrderAmount >= 1000 and TotalOrderAmount < 5000
                        then 'Medium'
                    when TotalOrderAmount >= 5000 and TotalOrderAmount < 10000
                        then 'High'
                    when TotalOrderAmount >= 10000 then 'VeryHigh'
                    end
                )
        from Orders2016
    )
select CustomerGroup
     , TotalInGroup      = Count(*)
     , PercentageInGroup = Count(*) * 1.0 / (select count(*) from CustomersGroups)
from CustomersGroups
group by CustomerGroup
order by TotalInGroup desc;


-----

;
with CustomerGroupsTresholds as
         (
             select Orders.OrderID
                  , CustomerGroups = (
                 case
                     when sum(O.Quantity * O.UnitPrice) over (partition by Orders.CustomerID) between 0 and 999.99
                         then 'low'
                     when sum(O.Quantity * O.UnitPrice) over (partition by Orders.CustomerID) between 1000 and 4999.99
                         then 'medium'
                     when sum(O.Quantity * O.UnitPrice) over (partition by Orders.CustomerID) between 5000 and 9999.99
                         then 'high'
                     when sum(O.Quantity * O.UnitPrice) over (partition by Orders.CustomerID) > 10000
                         then 'very high'
                     end
                 )
             from Orders
                      join OrderDetails O on Orders.OrderID = O.OrderID
             where Orders.OrderDate > '2016-01-01'
               and Orders.OrderDate < '2017-01-01'
         )
select Orders.CustomerID
     , CustomerGroupsTresholds.CustomerGroups
from Orders
         join OrderDetails on Orders.OrderID = OrderDetails.OrderID
         join CustomerGroupThresholds on OrderDetails.OrderID = CustomerGroupsTresholds.OrderID;

-- 52. List all countries where suppliers and/or customers are based.

select Country
from Customers
union
select Country
from Suppliers;

-- 53. The employees going on the business trip don't want just a raw list of countries,
-- they want more details. We'd like to see output like the below, in the Expected Results.
-- (Customer/ Supplier country profile).

-- cte
with SuppliersCountries as
    (
        select distinct Country
        from Suppliers
    )
   , CustomersCountries as
    (
        select distinct Country
        from Customers
    )
select SupplierCountry  = SuppliersCountries.Country
     , CustomersCountry = CustomersCountries.Country
from SuppliersCountries
         full join CustomersCountries
                   on SuppliersCountries.Country = CustomersCountries.Country;

-- full join
select distinct S.Country as SupplierCountry
              , C.Country as CustomerCountry
from Suppliers S
         full join Customers C on C.Country = S.Country;


-- 54. The output of the above is improved, but it's still not ideal.
-- What we'd really like to see is the country name, the total supplies, and the total customers.

-- 1 (2 x Country) CTEs
with Customers_CTE (Country, TotalCustomers) as
    (
        select Country  as Country
             , count(*) as TotalCustomers
        from Customers
        group by Country
    )
   , Suppliers_CTE (Country, TotalCustomers) as
    (
        select Country  as Country
             , count(*) as TotalSuppliers
        from Suppliers
        group by Country
    )
select Customers_CTE.Country        as CustomerCountry
     , Customers_CTE.TotalCustomers as Customers
     , Suppliers_CTE.Country        as SupplierCountry
     , Suppliers_CTE.TotalCustomers as Supplier
from Suppliers_CTE
         full join Customers_CTE on Customers_CTE.Country = Suppliers_CTE.Country;

-- (1 X Country)
with Customers_CTE (Country, TotalCustomers) as
    (
        select Country  as Country
             , count(*) as TotalCustomers
        from Customers
        group by Country
    )
   , Suppliers_CTE (Country, TotalCustomers) as
    (
        select Country  as Country
             , count(*) as TotalSuppliers
        from Suppliers
        group by Country
    )
select isnull(Customers_CTE.Country, Suppliers_CTE.Country) as Country
     , isnull(Customers_CTE.TotalCustomers, 0)              as Customers
     , isnull(Suppliers_CTE.TotalCustomers, 0)              as Supplier
from Suppliers_CTE
         full join Customers_CTE on Customers_CTE.Country = Suppliers_CTE.Country;


select distinct Country,
                count(*) over (partition by Country) as T
from Customers;

select distinct Country,
                count(*) over (partition by Country) as T
from Suppliers;


-- 55. First order in each country.
-- 1.
with CTE (OrderID, CustomerID, OrderDate, ShipCountry, FirstOrder) as
         (
             select OrderID                                                                    as OrderID
                  , CustomerID                                                                 as CustomerID
                  , OrderDate                                                                  as OrderDate
                  , ShipCountry                                                                as ShipCountry
                  , row_number() over (partition by ShipCountry order by ShipCountry, OrderID) as FirstOrder
             from Orders
         )
select *
from CTE
where FirstOrder = 1;


-- 2.
select *
from (
         select OrderID
              , CustomerID
              , OrderDate
              , ShipCountry
              , row_number() over (partition by ShipCountry order by ShipCountry, OrderID) as Rows
         from Orders
     ) as T1
where T1.Rows = 1;

-- 56. Customers with multiple orders in 5 day period.
-- Show those customers who have made more than 1 order in 5 day period.


select InitialOrder.CustomerID
     , InitialOrder.OrderID                                     as InitialOrderID
     , cast(InitialOrder.OrderDate as date)                     as InitialOrderDate
     , NextOrder.OrderID                                        as NextOrderID
     , cast(NextOrder.OrderDate as date)                        as NextOrderDateID
     , datediff(d, InitialOrder.OrderDate, NextOrder.OrderDate) as DaysInBetween
from Orders as InitialOrder
         join Orders as NextOrder on InitialOrder.CustomerID = NextOrder.CustomerID
where NextOrder.OrderID > InitialOrder.OrderID
  and datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
order by datediff(d, InitialOrder.OrderDate, NextOrder.OrderDate);


-- 57. Customers with multiple order in 5 days period (window functions).

with NextOrderDate as (
    select CustomerID
         , OrderDate     = convert(date, OrderDate)
         , NextOrderDate = convert(date,
            Lead(OrderDate, 1) over (partition by CustomerID order by CustomerID, OrderDate))
    from Orders
)
select CustomerID
     , OrderDate
     , NextOrderDate
     , DaysInBetween = datediff(d, OrderDate, NextOrderDate)
from NextOrderDate
where datediff(d, OrderDate, NextOrderDate) <= 5;

-- End of advanced problems.
