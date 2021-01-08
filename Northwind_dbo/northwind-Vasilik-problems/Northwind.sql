use Northwind;

select *
from INFORMATION_SCHEMA.TABLES;

select distinct CompanyName
              , City
              , O.OrderID
              , OD.Quantity
              , ProductName
from Customers
         left join Orders O on Customers.CustomerID = O.CustomerID
         left join OrderDetails OD on O.OrderID = OD.OrderID
         left join OrderDetails D on O.OrderID = D.OrderID
         left join Products P on OD.ProductID = P.ProductID
where City = 'Madrid';
-- and OrderDate between '1996-09-01' and '1996-09-30';

select CompanyName
     , City
from Customers

where City = 'Madrid';

SELECT c.CompanyName, o.OrderID, od.Quantity, p.ProductName
FROM dbo.Customers c
         left join
     (
         dbo.Orders o
             INNER JOIN dbo.[OrderDetails] od on od.OrderID = o.OrderID
             JOIN dbo.Products p on od.ProductID = p.ProductID
         )
     on c.CustomerID = o.CustomerID
WHERE c.City = 'Madrid';
-- AND o.OrderDate BETWEEN '1996-09-01' AND '1996-09-30';

select c.CompanyName
     , o.OrderID
     , od.Quantity
     , p.ProductName
from dbo.Orders o
         join dbo.OrderDetails od on o.OrderID = od.OrderID
         join Products p on od.ProductID = p.ProductID
         right join Customers c on o.CustomerID = c.CustomerID
where c.City = 'Madrid';

select c.CompanyName
     , o.OrderID
     , od.Quantity
     , p.ProductName
from dbo.Orders o
         right join dbo.OrderDetails od on o.OrderID = od.OrderID
         right join dbo.Products p on od.ProductID = p.ProductID
         right join dbo.Customers c on o.CustomerID = c.CustomerID
where c.City = 'Madrid';

select c.CompanyName
     , o.OrderID
     , o.OrderDate
     , od.Quantity
     , p.ProductName
from dbo.Customers c
         left join
     ( dbo.Orders o
         join dbo.OrderDetails od on od.OrderID = o.OrderID
         join dbo.Products p on od.ProductID = p.ProductID
         )
     on c.CustomerID = o.CustomerID
--          and o.OrderDate between '1996-09-01' and '1996-09-30'
where c.City = 'Madrid';

select distinct year(OrderDate)
from Orders;

select distinct month(OrderDate) as Month
from Orders
order by Month;

select distinct day(OrderDate) as Day
from Orders
order by Day;

select distinct datename(weekday, OrderDate)
from Orders;

-- Pierwszą tabelą do której odwołujemy się jest dbo.Customers
SELECT c.CompanyName, o.OrderID, o.OrderDate, ProductName
FROM dbo.Customers c
         inner join dbo.Orders o on c.CustomerID = o.CustomerID
         inner join dbo.[OrderDetails] od on od.OrderID = o.OrderID
         inner join dbo.Products p on od.ProductID = p.ProductID
WHERE c.City = 'Madrid'
  AND o.OrderDate BETWEEN '2013-09-01' AND '2017-09-30'
ORDER BY CompanyName, OrderDate DESC

-- Pierwszą tabelą do której odwołujemy się jest dbo.Orders
SELECT c.CompanyName, o.OrderID, o.OrderDate, ProductName
FROM dbo.Orders o
         inner join dbo.[OrderDetails] od on od.OrderID = o.OrderID
         inner join dbo.Products p on od.ProductID = p.ProductID
         inner join dbo.Customers c on c.CustomerID = o.CustomerID
WHERE c.City = 'Madrid'
  AND o.OrderDate BETWEEN '2013-09-01' AND '2017-09-30'
ORDER BY CompanyName, OrderDate DESC

-- Pierwszą tabelą do której odwołujemy się jest dbo.Products
SELECT c.CompanyName, o.OrderID, o.OrderDate, ProductName
FROM dbo.Products p
         inner join dbo.[OrderDetails] od on od.ProductID = p.ProductID
         inner join dbo.Orders o on od.OrderID = o.OrderID
         inner join dbo.Customers c on c.CustomerID = o.CustomerID
WHERE c.City = 'Madrid'
  AND o.OrderDate BETWEEN '2013-09-01' AND '2017-09-30'
ORDER BY CompanyName, OrderDate DESC


select CompanyName
     , O.OrderID
from Customers
         left join Orders O on Customers.CustomerID = O.CustomerID;
where City = 'Madrid'

SELECT c.CompanyName, o.OrderID
FROM dbo.Customers c
         LEFT OUTER JOIN dbo.Orders o ON c.CustomerID = o.CustomerID

select CompanyName
from Customers;


begin
    declare @val_a int, @val_b int
    select case
               when @val_a = @val_b then 'equal'
               when not (@val_a = @val_b) then 'not equal'
               when @val_a != @val_b then 'various'
               else 'unknown' end as NULLScomparisonResult;
end


select 1              as Poziom
     , null           as Rok
     , null           as Kwartal
     , count(OrderId) as Ilosc
from Orders
union
select 2               as Poziom
     , Year(OrderDate) as Rok
     , null
     , count(OrderID)  as Ilosc
from Orders
group by Year(orderDate)
union
select 3
     , Year(OrderDate)
     , DatePart(q, OrderDate)
     , count(OrderID)
from Orders
group by Year(OrderDate), DatePart(q, OrderDate)
order by 2;


select Year(OrderDate)        as Rok
     , DATEPART(q, OrderDate) as Kwartal
     , count(OrderID)         as Ilosc
from Orders
group by rollup (Year(OrderDate), DATEPART(q, OrderDate));


select Year(OrderDate)        as Rok
     , DATEPART(q, OrderDate) as Kwartal
     , count(OrderID)         as Ilosc
from Orders
group by cube (Year(OrderDate), DATEPART(q, OrderDate))
order by 1, 2;


select Year(OrderDate)        as Rok
     , DATEPART(q, OrderDate) as Kwartal
     , count(OrderDate)       as Ilosc
from Orders
group by grouping sets
    (
--     (),
--     (YEAR(OrderDate)),
(YEAR(OrderDate), DatePart(q, OrderDate))
    );

-- Podzapytania

select CompanyName
     , City
     , Country
from Customers
where City = 'London'
  and CompanyName like '[A-C]%';

-- Podzapytanie niezależne
-- Podzapytanie niezależne może zostać utworzone w dowolnym bloku logicznym kwerendy
-- select (wartość skalarna, czyli zbiór jednoelementowy opisany jednym atrybutem)
-- from (dowolny zbiór, jednoelementowy, wieloelementowy)
-- where (wektor (in, any, all), skalar)
-- group by
-- having
-- order
-- Ważne jest to czy będzie to wartość wektorowa, czy też wartość skalarna.
-- czyli ważny jest rodzaj zwracanego zbioru.
-- Można powiedzieć, że taki zbiór musi pasować do miejsca, w którym chcemy go użyć.
-- skalar może zostać użyty jako podzapytanie w każdym miejscu bloku logicznego kwerendy

-- to podzapytanie oczywiście nie ma specjalnie zastosowania, bo można je bez problemu napisać prostym zapytaniem
--
select *
from (
         -- tutaj dokonujemy wstępnej selekcji
         -- stopień skomplikowania nie ma znaczenia
         -- poniższe zapytanie może wywołane samodzielnie
         select CompanyName
              , City
              , Country
         from Customers
         where City = 'London'
     ) London -- tu musi być nazwa w mssql nie ma znaczenia, czy z as London, czy tylko London
-- kolejny etap selekcji
where CompanyName like '[A-C]%';

-- Pokaż średnią warość zamówień oraz wyświetl zamówienia >= średniej.


-- PODZAPYTANIA SKOLEROWANE

-- Pokaż informacje o liczbie zleceń dla każdego z klientów.

select Customers.CustomerID,
       CompanyName,
       OrderID,
       OrderDate
from Customers
         join Orders O on Customers.CustomerID = O.CustomerID


-- Zwróć liczbę zamówień dla każdego klienta
-- pojedyńcze zapytanie
-- czy to działa ze względu na rodzaj danych?
select Customers.CustomerID,
       CompanyName,
       count(OrderID) as NoOrders
from Customers
         left join Orders O on Customers.CustomerID = O.CustomerID
group by Customers.CustomerID, Customers.CompanyName
order by NoOrders desc;

-- podzapytanie
-- to podzapytanie musi zwracać wartość skalarną:
-- zauważ, że jeśli usunę where (korelację) to zwróci liczbę wszystkich zamówień
select Customers.CustomerID
     , CompanyName
     , (
    select count(OrderID)
    from Orders as Orders
         -- faktyczna korelacja:
    where Orders.CustomerID = Customers.CustomerID
) as Totals
from Customers as Customers
order by Totals desc;

SELECT C1.Country,
       STUFF((
                 SELECT ',' + C2.City
                 FROM dbo.Customers C2
                 WHERE C2.Country = C1.Country
                 FOR XML PATH('')
             ), 1, 1, '') as Cities
FROM dbo.Customers C1
WHERE Country LIKE 'S%'
GROUP BY C1.Country;

SELECT CustomerId, OrderId
FROM dbo.Orders as o1
WHERE OrderID = (
    SELECT MAX(OrderID)
    FROM dbo.Orders as O2
    WHERE CustomerID = o1.CustomerID


select (datediff(dd, '2014-03-01', '2014-03-31') + 1)
select (datediff(wk, '2014-03-01', '2014-03-31')) -- kalkulacja wszystkich sobót i niedziel, zwraca ilość tygodni * 2

select (case when datename(dw, '2014-03-01') = DATENAME(dw, 6) then 1 else 0 end)
select (case when datename(dw, '2014-03-01') = DATENAME(dw, 5) then 1 else 0 end)

select datename(dw,)

select (datediff(dd, '2014-03-01', '2014-03-31') + 1)
           - (datediff(wk, '2014-03-01', '2014-03-31') * 2)

-- Zwróć zamówienia, które były realizowane 20 dni lub więcej.
select OrderId,
       OrderDate,
       ShippedDate,
       (datediff(dd, OrderDate, ShippedDate) + 1)
           - (datediff(wk, OrderDate, ShippedDate) * 2)
           - (case when datename(dw, OrderDate) = datename(dw, 6) then 1 else 0 end)
           - (case when datename(dw, ShippedDate) = datename(dw, 5) then 1 else 0 end) as WorkingDays
from dbo.Orders
where (datediff(dd, OrderDate, ShippedDate) + 1)
          - (datediff(wk, OrderDate, ShippedDate) * 2)
          - (case when datename(dw, OrderDate) = datename(dw, 6) then 1 else 0 end)
          - (case when datename(dw, ShippedDate) = datename(dw, 5) then 1 else 0 end) > 20
order by WorkingDays desc;

CREATE FUNCTION dbo.LiczbaDniRoboczych(-- Funkcja nie uwzględnia świąt, innych dni wolnych poza sobotą i niedzielą
-- określenie parametrów wejściowych – są opcjonalne
-- u nas konieczne są dwa, określające zakres dat
    @StartDate datetime,
    @EndDate datetime)
    -- określenie typu zwracanej wartości (to obowiązkowo)
    RETURNS int
AS
    -- ciało funkcji
BEGIN

    RETURN (DATEDIFF(dd, @StartDate, @EndDate) + 1)
        - (DATEDIFF(wk, @StartDate, @EndDate) * 2)
        - (CASE WHEN DATENAME(dw, @StartDate) = DATENAME(dw, 6) THEN 1 ELSE 0 END)
        - (CASE WHEN DATENAME(dw, @EndDate) = DATENAME(dw, 5) THEN 1 ELSE 0 END)

END;


---

USE Northwind;

--Tradycyjne używanie funkcji agregujących z GROUP BY
select OrderID
     , SUM(UnitPrice * Quantity) as TotalValue
from dbo.[OrderDetails]
Group by OrderID;

--używanie funkcji agregującej razem z OVER() – nie musimy stosować GROUP BY,
--zatem mamy dostęp do wszystkich kolumn, nie tylko do atrybutów grupujących

select OrderID,
       ProductID,
       SUM(UnitPrice * Quantity) over (partition by OrderID order by ProductID)   as RunningTotal,
       count(UnitPrice * Quantity) over (partition by OrderID order by ProductID) as Ranking
from dbo.[OrderDetails];


select *
from OrderDetails;

select year(getdate()) as [Year]
go
select month(getdate()) as [Month]
select day(getdate()) as [Day]
select datepart(ms, getdate())

select year(OrderDate)        as [Year]
     , month(OrderDate)       as [Month]
     , datepart(q, OrderDate) as [Q]
     , count(OrderID)         as OrdersTotals
from Orders
group by cube (year(OrderDate), month(OrderDate), datepart(q, OrderDate))
order by 1;


