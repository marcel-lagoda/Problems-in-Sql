---------------------------------------------------------------------------
-- 1 Categorize customers into groups, based on the number of their orders.
---------------------------------------------------------------------------
-- 1.1.
select distinct Customers.CustomerID
              , CompanyName
              , NumberOfOrders   = count(OrderID) over (partition by O.CustomerID)
              , OrdersTreshholds = (
    case
        when count(OrderID) over (partition by O.CustomerID) >= 15 then 'High'
        when count(OrderID) over (partition by O.CustomerID) < 15
            and count(OrderID) over (partition by O.CustomerID) >= 10 then 'Medium'
        when count(OrderID) over (partition by O.CustomerID) < 10 then 'Low'
        end
    )
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID
order by NumberOfOrders desc;

-- 1.2.
select distinct Customers.CustomerID
              , CompanyName
              , NumberOfOrders =
    (case
         when count(OrderID) >= 15 then 'High'
         when count(OrderID) < 15 then 'Low'
        end)
from Customers
         join Orders on Customers.CustomerID = Orders.CustomerID
group by Customers.CustomerID, CompanyName
order by NumberOfOrders;


-- 1.3.
with CTE as (
    select Customers.CustomerID
         , CompanyName
         , NumberOfOrders = count(OrderID)
    from Customers
             join Orders O on Customers.CustomerID = O.CustomerID
)
select CTE.CompanyName
     , CTE.CompanyName
     , CTE.NumberOfOrders =
       (case end)


---------------------------------------------
-- 2. Assign a sequential number to each row.
---------------------------------------------
-- 2.1. Very high overhead (using subquery).
select o1.CustomerID
     , o1.OrderID
     , (
    select count(*)
    from Orders o2
    where o2.OrderID <= o1.OrderID
      and o2.CustomerID = o1.CustomerID
) as RowNum
from Orders o1
order by CustomerID, RowNum;

-- 2.2. using row_number() function
select CustomerID
     , OrderID
     , row_number() over (partition by CustomerID order by OrderID) as RowNum
from Orders;


-----------------------------------------------------------------------------
-- 3. Create collections
-----------------------------------------------------------------------------
select C1.Country
     , stuff((
                 select distinct ',' + C2.City
                 from dbo.Customers C2
                 where C2.Country = C1.Country
                 for xml path('')
             ), 1, 1, '') as Cities
from dbo.Customers C1
group by C1.Country;


---------------------------------------------------
-- 4. Select the very last order for each customer.
---------------------------------------------------
-- 4.1. Correlated where sub-query.
select *
--        [CustomerID]
--      , [OrderID]
from Orders o1
where [OrderID] = (
    select max([OrderID])
    from Orders o2
    where o1.[CustomerID] = o2.[CustomerID]
)
order by [CustomerID];

-- 4.2. max() + group by (limited data)
select CustomerID
     , max(OrderID)
from Orders
group by CustomerID;

-- 4.3. Correlated select sub-query.
select *
--        CustomerID
--      , OrderID
     , (
    select distinct max(OrderID)
    from Orders o2
    where o2.CustomerID = o1.CustomerID
) as LastOrderID
from Orders o1

-- 4.4. Independent joined sub-query.
select
--        *
    Orders.CustomerID
     , OrderID
from Orders
         join
     (
         select CustomerID
              , max(OrderID) as LastOrderID
         from Orders
         group by CustomerID
     ) as LastOrders
     on OrderID = LastOrders.LastOrderID;

-- 4.5. Window function (high overhead).
select distinct CustomerID
              , max(OrderID) over (partition by CustomerID order by OrderID desc) as LastOrderID
from Orders;
------------------------------------------------------------------------------------------------

--------------------------------------------------------------------
-- 5. # of Orders by different dimensions (totals, years, quarters).
--------------------------------------------------------------------

-- group by + grouping/grouping_id
select year(OrderDate)                                              as [year]
     , datepart(q, OrderDate)                                       as [Q]
     , count(OrderID)                                               as [total orders]
     , grouping(year(OrderDate))                                    as [year-wise]
     , grouping(datepart(q, OrderDate))                             as [Q-wise]
     , grouping(year(OrderDate)) + grouping(datepart(q, OrderDate)) as [level]
from [dbo].[Orders]
group by cube (year(OrderDate), datepart(q, OrderDate))
order by 1, 2
go

select year(OrderDate)                                        as [year]
     , datepart(q, OrderDate)                                 as [Q]
     , count(OrderID)                                         as [total orders]
     , grouping(year(OrderDate))                              as [year-wise]
     , grouping(datepart(q, OrderDate))                       as [Q-wise]
     , grouping_id(year(OrderDate), (datepart(q, OrderDate))) as [binary-level]
from [dbo].[Orders]
group by cube (year(OrderDate), datepart(q, OrderDate))
order by 1, 2
go


-- group by grouping sets
select year(OrderDate)        as [Year]
     , datepart(q, OrderDate) as [Q]
     , count(OrderID)         as [Total Orders]
from [dbo].[Orders]
group by grouping sets
       (()
       , (year(OrderDate))
       , (year(OrderDate), datepart(q, OrderDate)))
order by 1, 2
go


-- Cube
select year(OrderDate)        as [Year]
     , datepart(q, OrderDate) as [Q]
     , count(OrderID)         as [Total Orders]
from [dbo].[Orders]
group by cube (year(OrderDate), datepart(q, OrderDate))
order by 1, 2;


-- Rollup
-- Total cost: 0.0443392
select year(OrderDate)        as [Year]
     , datepart(q, OrderDate) as [Q]
     , count(OrderID)         as [Order Totals]
from [dbo].[Orders]
group by rollup (year(OrderDate), datepart(q, OrderDate))
order by 1, 2;


-- Union & group by
-- Total cost: 0.0744286
select 1              as [Level]
     , null           as [Year]
     , null           as [Q]
     , count(OrderID) as [OrdersTotals]
from [dbo].[Orders]
-- where Year(OrderDate) in (2015, 2016)
union
select 2
     , Year(OrderDate)
     , null
     , count(OrderID)
from [dbo].[Orders]
-- where year(OrderDate) in (2015, 2016)
group by Year(OrderDate)
union
select 3
     , Year(OrderDate)
     , datepart(q, OrderDate)
     , count(OrderID)
from [dbo].[Orders]
-- where year(OrderDate) in (2015, 2016)
group by year(OrderDate), datepart(q, OrderDate)
order by 2, 1;
