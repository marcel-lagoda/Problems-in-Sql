-- Zadanie 1. Rozwiązanie w MySql'u.

create database baza;

use baza;

create table employees
(
    id            int(11) primary key auto_increment,
    name          varchar(10) not null,
    contract_from date        not null,
    contract_to   date,
    manager_id    int(11),
    birth_year    date        not null
);

alter table employees
    modify birth_year year not null;

select *
from employees;

alter table employees
    add foreign key (manager_id) references employees (id);

create table phones
(
    id          int(11) auto_increment,
    employee_id int(11),
    phone       int unsigned,
    phone_brand varchar(64) not null,
    primary key (id),
    foreign key (employee_id) references employees (id)
);

insert into employees (id, name, contract_from, contract_to, manager_id, birth_year)
values (1, 'Jan', '2016-08-21', null, null, 1983),
       (2, 'Barbara', '2017-06-02', null, 1, 1990),
       (3, 'Mateusz', '2018-06-06', null, 2, 1992),
       (4, 'Michał', '2017-09-21', null, 2, 1994),
       (5, 'Ola', '2019-05-01', null, 2, 1993),
       (6, 'Błażej', '2018-09-01', '2020-01-01', 2, 1992),
       (7, 'Bogdan', '2016-06-01', null, null, 1974),
       (8, 'Konrad', '2018-02-01', null, 7, 1984),
       (9, 'Kamila', '2020-02-01', null, 7, 1988),
       (10, 'Ewelina', '2016-02-04', null, 2, 1985),
       (11, 'Kamil', '2016-09-01', null, 7, 1990),
       (12, 'Karolina', '2020-01-01', null, 1, 1994),
       (13, 'Marcin', '2018-07-01', null, 8, 1989),
       (14, 'Kacper', '2018-09-20', null, 8, 1988),
       (15, 'Mariusz', '2016-09-01', null, 11, 1991);

insert into phones (id, employee_id, phone, phone_brand)
values (1, 2, 66936598, 'Samsung'),
       (2, 4, 65988874, 'Xiomi'),
       (3, 11, 79155966, 'Huawei'),
       (4, 3, 50289632, 'Xiomi'),
       (5, 10, 60266832, 'Huawei'),
       (6, 12, 60025699, 'Huawei'),
       (7, 9, 50156488, 'Sony'),
       (8, 6, 66396589, 'Xiomi'),
       (9, 13, 69133654, 'Samsung'),
       (10, 8, 50969875, 'Xiomi'),
       (11, 7, 66325698, 'Samsung'),
       (12, 14, 66452132, 'Huawei'),
       (13, 5, 70125698, 'Samsung'),
       (14, 15, 606961155, 'Sony'),
       (15, 1, 73189655, 'Xiomi');

update phones
set phone_brand = 'Samsung'
where id = 9;


-- 1. Wypisz wszystkich ludzi wraz z imieniem przełożonego, posortuj po imieniu przeożonego.
--    Ludzi, ktorych przełożony jest nieznany, wypisz na koncu.


-- Wersja 1a.

select e.name as employee,
       m.name as manager
from employees e
         join employees m on m.id = e.manager_id
order by case
             when m.manager_id is null then 1
             else 0
             end, m.manager_id, m.name;


-- 1b.

select e.name as employee,
       e.manager_id,
       m.name as manager,
       m.manager_id,
       e.name as employee_
from employees e
         join employees m on m.id = e.manager_id
order by IF(m.manager_id is null, 1, 0), m.manager_id, m.name;


-- Wersja 2. (Widok hierarchiczny na 3 tabele.)

select e.name  as employee,
       m.name  as manager,
       mm.name as topmanager
from employees e
         join employees m on m.id = e.manager_id
         left join employees mm on mm.id = m.manager_id
order by IF(m.manager_id is null, 1, 0), m.manager_id, m.name;


-- ----------------------------------------------
/*
create view Company_structure as

select e.name       as employee,
       e.manager_id as managerID,
       m.name       as manager,
       m.manager_id as topmanagerID,
       mm.name      as topmanager
from employees e
         join employees m on m.id = e.manager_id
         left join employees mm on mm.id = m.manager_id
order by IF(m.manager_id is null, 1, 0), m.manager_id, m.name;
 */
-- drop view Company_structure;

select *
from Company_structure;


-- 2. Wypisz osoby które nie mają przełożonego, posortuj po dacie zatrudnienia.

-- select *
select employees.name
from employees
where manager_id is null
order by contract_from;

-- 3. Jak ma na imię przełożony przełożonego Mateusza?

select mm.name as Przelozony_Przelozonego_Mateusza
from employees e
         join employees m on m.id = e.manager_id
         join employees mm on mm.id = m.manager_id
where e.name = 'Mateusz';



-- 4. wskaż imię najmłodszego z obecnych pracowników barbary,
--    który rozpoczął pracę po 2017 roku.

select employees.name
from employees
where birth_year in (select max(barbara.birth_year)
                     from (select e.birth_year
                           from employees e
                                    join employees m on m.id = e.manager_id
                           where m.name = 'Barbara'
                             and e.contract_from >= '2018-01-01') as barbara);



-- 5. Dla każdej osoby mającej bezpośrednich pracowników
--    wypisz średni wiek jej pracowników.


select m.name                                        as manager,
       --      count(e.name)                          as prac,
       round(avg(year(current_date) - e.birth_year)) as SredniWiekPracownikow
from employees e
         join employees m on m.id = e.manager_id
         left join employees mm on mm.id = m.manager_id
group by m.name;

/*
create view AllData as
select e.id as employeeID,
       e.name as employeeName,
       e.contract_from employeeContractFrom,
       e.manager_id employeeContractTo,
       e.birth_year emplyeBirthYear,
       year(current_date) - e.birth_year as age,
       m.id as managerID,
       m.name as managerName,
       m.contract_from managerContractFrom,
       m.manager_id tomManagerID,
       m.birth_year managerBirthYear,
       year(current_date) - m.birth_year as age2
from employees e
         join employees m on m.id = e.manager_id
         left join employees mm on mm.id = m.manager_id;
*/

-- select *
-- from AllData;


-- 6. Wskaż numery telefonów osób zatrudnionych w firmie od 2019 roku

select phone
--       e.name,
--       e.contract_from
from phones
         join employees e on phones.employee_id = e.id
where contract_from >= '2019-01-01';



-- 7. Wskaż najczęściej wybieraną markę telefonów wraz z liczbą osób, które ją wybrały.
--    Wpisz po przecinku imiona tych osób.


select group_concat(employees.name) as Users,
       p.phone_brand                as Brand,
       count(p.phone_brand)         as 'No'
from employees
         join phones p on employees.id = p.employee_id
where p.phone_brand =
      (select max(phone_brand)
       from phones)
group by p.phone_brand;



