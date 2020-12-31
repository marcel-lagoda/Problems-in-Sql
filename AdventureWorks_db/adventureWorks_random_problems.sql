----------------------------------------------------------------------------------------------
-- 1. Return the bottom sales results. Provide number of total orders & the last order date.
----------------------------------------------------------------------------------------------
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
order by NumberOfOrders;

-- 3. over
select distinct SalesPersonID
              , P.FirstName
              , P.LastName
              , count(SalesOrderID) over (partition by SalesPersonID) as Totals
from Sales.SalesOrderHeader
         join Person.Person P on SalesPersonID = P.BusinessEntityID
order by Totals;
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
-- 2. Data comparison with CTE
------------------------------------------------------------------------------------

with cte_1
         as
         (
             select SalesPersonID,
                    count(*)       as NumberOfOrders,
                    max(OrderDate) as MaxDate
             from Sales.SalesOrderHeader
             group by SalesPersonID
         ),
     cte_2
         as
         (
             select SalesPersonID, NumberOfOrders, MaxDate
             from cte_1
             where NumberOfOrders < 200
         )
SELECT top 10 cte_1.*, cte_2.*
from cte_1
         left join cte_2
                   on cte_1.SalesPersonID = cte_2.SalesPersonID