-- 1. Show me the names of all vendors.

select VendName
from Vendors;

-- 2. What are the names and prices of all the products we carry?

select ProductName
     , RetailPrice
from Products;

-- 3. Which states do our customers come from?

select distinct CustState
from Customers;

-- 4. Show me all the information on our employees.

select *
from Employees;

-- 5. Show me a list of cities, in alphabetical order,
-- where our vendors are located, and include the names of the vendors we work with in each city.


select VendCity
     , VendName
from Vendors
order by VendCity;

-- 6. What is the inventory value of each product?

select ProductName
     , RetailPrice * QuantityOnHand as Inventory
from Products;

-- 7. How many days elapsed between the order date and the ship date for each order?

select OrderNumber
     , cast(OrderDate as date)               as OrderDate
     , cast(ShipDate as date)                as ShipDate
     , cast(ShipDate - OrderDate as INTEGER) as TimeElapsed
from Orders;

-- 8. What if we adjusted each product price by reducing it 5 percent?

select ProductName
     , RetailPrice
     , (RetailPrice - (RetailPrice * 0.05)) as ReducedPrice
from Products;

-- 9. Show me a list of orders made by each customer in descending date order.

select OrderNumber
     , CustomerID
from Orders
order by OrderDate desc;

-- 10. Compile a complete list of vendor names and addresses in vendor name order.

select VendName
     , VendStreetAddress
     , VendCity
     , VendState
     , VendZipCode
from Vendors
order by VendName;

-- 11. Show me all the orders for customer number 1001.

select *
from Orders
where CustomerID = 1001;

-- 12. Show me an alphabetized list of products with names that begin with 'Dog'.

select ProductName
from Products
where ProductName like 'Dog%'
order by ProductName;

-- 13. Give me the names of all vendors based in Ballard, Bellevue, and Redmond.

select VendName
     , VendCity
from Vendors
where VendCity in ('Ballard', 'Bellevue', 'Redmond');

-- 14. Show me an alphabetized list of products with a retail price of $125.00 or more.

select ProductName
     , RetailPrice
from Products
where RetailPrice >= 125.00;

-- 15. Which vendors do we work with that don't have a Web site?

select VendName
from Vendors
where VendWebPage is NULL;

-- 16. Display all products and their categories.

select ProductNumber
     , ProductName
     , ProductDescription
     , RetailPrice
     , QuantityOnHand
     , C.CategoryID
     , C.CategoryDescription
from Products
         join Categories C on Products.CategoryID = C.CategoryID;

-- 17. Find all the customers who ever ordered a bicycle helmet.

select distinct CustFirstName
              , CustLastName
--      , OD.OrderNumber
--      , P.ProductName
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Order_Details OD on O.OrderNumber = OD.OrderNumber
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%helmet%';

-- 18. Find all the customers who ordered a bicycle, then find all the customers
-- who ordered a helmet, and finally list the common customers
-- so that we know who ordered both a bicycle and a helmet.

-- [Only assuming that helmet & bike are last names words.]

select Bike.CustomerID
     , Bike.CustFirstName
     , Bike.CustLastName
--      , Bike.ProductName
from (select distinct Customers.CustomerID
                    , CustFirstName
                    , CustLastName
--                     , P.ProductName
      from Customers
               join Orders O on Customers.CustomerID = O.CustomerID
               join Order_Details OD on O.OrderNumber = OD.OrderNumber
               join Products P on P.ProductNumber = OD.ProductNumber
      where P.ProductName like '%bike') as Bike
         inner join
     (select distinct Customers.CustomerID
      from Customers
               join Orders O2 on Customers.CustomerID = O2.CustomerID
               join Order_Details D on O2.OrderNumber = D.OrderNumber
               join Products P2 on D.ProductNumber = P2.ProductNumber
      where P2.ProductName like '%helmet') as Helmet
     on Bike.CustomerID = Helmet.CustomerID;

-- 19. List customers and the dates they placed and order, sorted in order date sequence.

select Customers.CustomerID
     , CustLastName
     , CustFirstName
     , cast(OrderDate as date)
     , OrderNumber
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
order by OrderDate desc;

-- 20. List employees and the customers from whom they booked an order.

select distinct concat_ws(' ', EmpFirstName, EmpLastName)   as Employee
              , concat_ws(' ', CustFirstName, CustLastName) as Customer
--               , O.OrderNumber
from Employees
         join Orders O on Employees.EmployeeID = O.EmployeeID
         join Customers C on O.CustomerID = C.CustomerID;

SELECT DISTINCT Employees.EmployeeID,
                Customers.CustomerID
FROM ((Employees
    JOIN Orders ON (Employees.EmployeeID = Orders.EmployeeID))
         JOIN Customers ON (Customers.CustomerID = Orders.CustomerID));

-- 21. Display all orders, the products in each order,
-- and the amount owed for each product, in order number sequence.

select OrderNumber
     , ProductName
     , QuantityOrdered
from Order_Details
         join Products P on Order_Details.ProductNumber = P.ProductNumber;

-- ------------------------
select distinct OrderNumber
              , count(ProductNumber)   QuantityOfProducts
              , count(QuantityOrdered) QuantityOrdered
from Order_Details
group by OrderNumber;

-- 22. Show me the vendors and the products they supply to us for products that cost less than $100.

select VendName
     , PV.ProductNumber
     , ProductName
     , RetailPrice
from Vendors
         join Product_Vendors PV on Vendors.VendorID = PV.VendorID
         join Products P on PV.ProductNumber = P.ProductNumber
where RetailPrice < 100;

-- 23. Show me customers and employees who have the same last name.

select CustomerID
     , CustLastName
     , EmployeeID
     , EmpLastName
from Customers
         cross join Employees
where EmpLastName = CustLastName;

select distinct Customers.CustomerID
              , CustLastName
              , E.EmployeeID
              , EmpLastName
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Employees E on O.EmployeeID = E.EmployeeID
where EmpLastName = CustLastName;


-- 24. Show me customers and employees who live in the same city.

select CustomerID
     , concat_ws(' ', CustFirstName, CustLastName) as Customer
     , EmployeeID
     , concat_ws(' ', EmpFirstName, EmpLastName)   as Employee
from Customers
         cross join Employees
where EmpCity = CustCity;


-- 24. Which products have never been ordered?

select Products.ProductNumber
     , ProductName
from Products
         left join Order_Details OD on Products.ProductNumber = OD.ProductNumber
where OrderNumber is NULL;

-- 25. Display all customers and any orders for bicycles.

select Customers.CustomerID
     , concat_ws(' ', CustFirstName, CustLastName) as Customer
     , Bikes.OrderDate
     , Bikes.ProductName
     , Bikes.QuantityOrdered
     , Bikes.QuotedPrice
from Customers
         left join (select CustomerID
                         , OrderDate
                         , ProductName
                         , QuantityOrdered
                         , QuotedPrice
                    from Orders
                             join Order_Details OD on Orders.OrderNumber = OD.OrderNumber
                             join Products P on OD.ProductNumber = P.ProductNumber
                             join Categories C on P.CategoryID = C.CategoryID
                    where CategoryDescription = 'Bikes') as Bikes
                   on Bikes.CustomerID = Customers.CustomerID;

-- 26. Show me customers who have never ordered a helmet.

select C.CustomerID
     , concat_ws(' ', C.CustFirstName, C.CustLastName) as Customer
from Customers C
         left join (select Customers.CustomerID
                    from Customers
                             join Orders O on Customers.CustomerID = O.CustomerID
                             join Order_Details OD on O.OrderNumber = OD.OrderNumber
                             join Products P on OD.ProductNumber = P.ProductNumber
                    where ProductName like '%helmet') as Helmets
                   on Helmets.CustomerID = C.CustomerID
where Helmets.CustomerID is NULL;

-- 27. Display customers who have no sales rep in the same Zip code.

select CustomerID
     , CustZipCode
     , CustFirstName
     , CustLastName
     , EmpZipCode
     , EmployeeID
from Customers
         left join Employees
                   on Employees.EmpZipCode = Customers.CustZipCode
where Employees.EmployeeID is NULL;

-- ---------------------------------------------------------------
select CustomerID
     , CustZipCode
     , CustFirstName
     , CustLastName
     , EmpZipCode
     , EmployeeID
from Customers
         full join Employees
                   on Employees.EmpZipCode = Customers.CustZipCode;


-- 28. List all products and the dates for any orders.

-- All orders & all days.
select Products.ProductNumber
     , ProductName
     , O.OrderNumber
     , cast(O.OrderDate as date) as OrderDate
from Products
         join Order_Details OD on Products.ProductNumber = OD.ProductNumber
         join Orders O on OD.OrderNumber = O.OrderNumber
order by ProductNumber;

-- All products & theirs orders' dates.
select Products.ProductNumber
     , ProductName
     , cast(Orders.OrderDate as date) as OrderDate
--      , Orders.OrderNumber
from Products
         left join
     (select distinct Order_Details.ProductNumber
                    , O.Orderdate
--                     , O.OrderNumber
      from Order_Details
               join Orders O on Order_Details.OrderNumber = O.OrderNumber) as Orders
     on Products.ProductNumber = Orders.ProductNumber;

-- 29. Build a single mailing list that consists of the name, address, city,
-- state, and ZIP Code for customers & vendors.

select concat_ws(' ', CustFirstName, CustLastName) as Customer,
       CustStreetAddress,
       CustCity,
       CustState,
       CustZipCode
from Customers
union
select VendName,
       VendStreetAddress,
       VendCity,
       VendState,
       VendZipCode
from Vendors;

-- 30. List customers and the bikes they ordered combined with vendors and the bikes they sell.

select Customers.CustomerID
     , concat_ws(' ', CustFirstName, CustLastName)
     , P.ProductName
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Order_Details OD on O.OrderNumber = OD.OrderNumber
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%bike'
union
select Vendors.VendorID
     , VendName
     , P.ProductName
from Vendors
         join Product_Vendors PV on Vendors.VendorID = PV.VendorID
         join Products P on PV.ProductNumber = P.ProductNumber
where ProductName like '%bike';

-- 31. Create a single mailing list for customers, employees, and vendors.

select CustomerID
     , concat_ws(' ', CustFirstName, CustLastName)
     , CustStreetAddress
     , CustCity
     , CustState
     , CustZipCode
from Customers
union
select VendorID
     , VendName
     , VendStreetAddress
     , VendCity
     , VendState
     , VendZipCode
from Vendors
union
select EmployeeID
     , concat_ws(' ', EmpFirstName, EmpLastName) as Employee
     , EmpStreetAddress
     , EmpCity
     , EmpState
     , EmpZipCode
from Employees

-- 32. Show me all the customers and employee names and addresses,
-- including any duplicates, sorted by ZIP code

select CustomerID,
       CustFirstName,
       CustLastName,
       CustStreetAddress,
       CustCity,
       CustState,
       CustZipCode,
       CustAreaCode,
       CustPhoneNumber
from Customers
union all
select EmployeeID,
       EmpFirstName,
       EmpLastName,
       EmpStreetAddress,
       EmpCity,
       EmpState,
       EmpZipCode,
       EmpAreaCode,
       EmpPhoneNumber
from Employees
order by CustZipCode;

-- 33. List all the customers who ordered a bicycle combined
-- with all the customers who ordered a helmet.


-- 33a. # of total Customers
select Customers.CustomerID
     , CustFirstName
     , CustLastName
from ((Customers
    join Orders O on Customers.CustomerID = O.CustomerID)
    join Order_Details OD on O.OrderNumber = OD.OrderNumber)
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%bike%'
union
select Customers.CustomerID
     , CustFirstName
     , CustLastName
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Order_Details OD on O.OrderNumber = OD.OrderNumber
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%helmet%'
order by CustomerID;

-- 33b. (Product Type info included)
select Customers.CustomerID
     , CustFirstName
     , CustLastName
     , 'Bike' as ProdType -- ProdType = 'Bike'
from ((Customers
    join Orders O on Customers.CustomerID = O.CustomerID)
    join Order_Details OD on O.OrderNumber = OD.OrderNumber)
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%bike'
union
select Customers.CustomerID
     , CustFirstName
     , CustLastName
     , 'Helmet' as ProdType
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Order_Details OD on O.OrderNumber = OD.OrderNumber
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%helmet'
order by ProdType;


-- 34. List the customers who ordered a helmet together with the vendors who provide helmets.

select Customers.CustomerID
     , concat_ws(' ', Customers.CustFirstName, Customers.CustLastName) as Customer
--      , P.ProductName
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join Order_Details OD on O.OrderNumber = OD.OrderNumber
         join Products P on OD.ProductNumber = P.ProductNumber
where P.ProductName like '%helmet'
union
select Vendors.VendorID
     , VendName
--      , ProductName
from Vendors
         join Product_Vendors PV on Vendors.VendorID = PV.VendorID
         join Products P2 on PV.ProductNumber = P2.ProductNumber
where P2.ProductName like '%helmet'

-- 35. Show me all the orders shipped on October 3, 2012,
-- and each order's related customer last name.

-- 35a. join
select OrderNumber
     , cast(OrderDate as date) as                  OrderDate
     , cast(ShipDate as date)  as                  ShipDate
     , C.CustomerID
     , concat_ws(' ', CustFirstName, CustLastName) CustomerFullName
from Orders
         join Customers C on Orders.CustomerID = C.CustomerID
where ShipDate = '2012-10-03';

-- 35b. sub-query
select OrderNumber
     , cast(OrderDate as date)                          as OrderDate
     , cast(ShipDate as date)                           as ShipDate
     , (select concat_ws(' ', Customers.CustLastName, Customers.CustFirstName)
        from Customers
        where Customers.CustomerID = Orders.CustomerID) as Customer
from Orders
where ShipDate = '2012-10-03';

-- 36. List vendors and a count of the products they sell to us.

select VendorID
     , VendName
     , (select count(*)
        from Product_Vendors
        where Vendors.VendorID = Product_Vendors.VendorID) as CountOfProducts
from Vendors
order by CountOfProducts desc;
