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
       TotalValue = sum(UnitPrice * Quantity)
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName, O.OrderID
having sum(UnitPrice * Quantity) >= 10000
order by TotalValue desc;

select Customers.CustomerID,
       Customers.CompanyName,
       O.OrderID,
       sum(Quantity * UnitPrice) as TotalValue
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName, O.OrderID
having sum(Quantity * UnitPrice) > 10000
order by TotalValue desc;

--  TotalValue = (UnitPrice * Quantity)
-- Czy mogę coś takiego zrobić w mysqlu?

-- 33. The manager has changed his mind. Instead of
-- requiring that customers have at least one individual
-- orders totaling $10,000 or more, he wants to define
-- high-value customers as those who have orders
-- totaling $15,000 or more in 2016. How would you
-- change the answer to the problem above?

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

-- 34. Change the above query to use the discount when
-- calculating high-value customers. Order by the total
-- amount which includes the discount.

select Customers.CustomerID,
       Customers.CompanyName,
       sum(OD.UnitPrice * OD.Quantity)                            as TotalValue,
       OD.Discount,
       (IIF(OD.Discount = 0, sum(OD.Quantity * OD.UnitPrice),
            sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)))) as TotalValueDiscounted
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
         join OrderDetails OD on O.OrderID = OD.OrderID
where OrderDate >= '2016-01-01'
  and OrderDate < '2017-01-01'
group by Customers.CustomerID, Customers.CompanyName, OD.Discount
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

-- 39. Based on the previous question, we now want to
-- show details of the order, for orders that match the
-- above criteria.
















