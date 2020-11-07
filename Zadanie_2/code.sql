-----------------------------------------------------------
-- DDL for table_A
-----------------------------------------------------------

CREATE TABLE table_A
(
    table_A_ID INT IDENTITY
        CONSTRAINT PK_table_A PRIMARY KEY,
    date       DATETIME DEFAULT GETDATE() NOT NULL,
    pub_date   DATETIME                   NOT NULL,
    lu         INT                        NOT NULL,
    pu         INT
        CONSTRAINT FK_pu_pu_id FOREIGN KEY REFERENCES table_B (pu_id),
    title      VARCHAR(45)
);

-----------------------------------------------------------
-- DDL for table_B
-----------------------------------------------------------

CREATE TABLE table_B
(
--     table_B_ID INT IDENTITY
--         CONSTRAINT PK_table_B PRIMARY KEY,
    date     DATETIME DEFAULT GETDATE() NOT NULL,
    pub_date DATETIME                   NOT NULL,
    pu_id    INT IDENTITY
        CONSTRAINT PK_pu_id PRIMARY KEY,
    url      NVARCHAR(2083),
    author   VARCHAR(60)
);


----------------------------------------------------------
--- Query
----------------------------------------------------------


select count(distinct table_A.lu) as UsersCounts
     , table_A.pu                 as PublicationID
     , table_A.title
     , table_B.url
     , table_B.author
from table_A
         left join table_B on table_A.pu = table_B.pu_id
where table_B.pub_date >= '2020-10-01'
  and table_B.pub_date <= '2020-10-25'
group by table_A.pu
       , table_A.title
       , table_B.url
       , table_B.author
order by count(distinct table_A.lu) desc;
