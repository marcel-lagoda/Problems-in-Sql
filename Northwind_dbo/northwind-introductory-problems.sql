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

