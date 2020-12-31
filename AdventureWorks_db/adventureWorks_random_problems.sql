
----------------------------------------------------------------------------------------------
-- Return the bottom SalesPerson results. Provide number of total orders & the last order date.
-- 1. CTE
with Sales_CTE (SalesPersonID, NumberOfOrders, MaxDate)
         as
         (
             select top 4 SalesPersonID  as SalesPersonID
                        , count(*)       as NumberOfOrders
                        , max(OrderDate) as MaxDate
             from Sales.SalesOrderHeader
             group by SalesPersonID
             order by NumberOfOrders asc
         )
select P.FirstName
     , P.LastName
     , c.NumberOfOrders
     , c.MaxDate
from Sales_CTE c
         left join Person.Person AS P
                   ON c.SalesPersonID = P.BusinessEntityID;

-- 2. Group by
select top 4 SalesPersonID  as SalesPersonID
           , P.FirstName
           , P.LastName
           , count(*)       as NumberOfOrders
           , max(OrderDate) as MaxDate
from Sales.SalesOrderHeader
         join Person.Person P on P.BusinessEntityID = SalesPersonID
group by SalesPersonID, P.FirstName, P.LastName
order by NumberOfOrders asc

-- 3. over
select distinct SalesPersonID
              , P.FirstName
              , P.LastName
              , count(SalesOrderID) over (partition by SalesPersonID) as Totals
from Sales.SalesOrderHeader
         join Person.Person P on SalesPersonID = P.BusinessEntityID
order by Totals asc;
------------------------------------------------------------------------------------