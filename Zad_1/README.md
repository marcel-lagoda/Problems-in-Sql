# SQL Zadanie

## Opis


Opierając się na poniższych danych stwórz tabele i napisz zapytania SQL realizujące poniższe zagadnienia.

1. Wypisz wszystkich ludzi wraz z imieniem przełożonego, posortuj po imieniu przeożonego.
Ludzi, ktorych przełożony jest nieznany, wypisz na koncu.
2. Wypisz osoby które nie mają przełożonego, posortuj po dacie zatrudnienia.
3. Jak ma na imię przełożony przełożonego Mateusza?
4. Wskaż imię najmłodszego z obecnych pracowników Barbary, który rozpoczął pracę po 2017 roku.
5. Dla każdej osoby mającej bezpośrednich pracowników wypisz średni wiek jej pracowników.
6. Wskaż numery telefonów osób zatrudnionych w firmie od 2019 roku.
7. Wskaż najczęściej wybieraną markę telefonów wraz z liczbą osób, które ją wybrały. Wpisz po przecinku
imiona tych osób
---

```employees table```

| id | name    |contract_from| contract_to | manager_id  | birth_year  |   
|----|---------|-------------|-------------|-------------|-------------|
| 1  | Jan     | 2016-08-21  | null        | null        | 1983        |   
| 2  | Barbara | 2017-06-02  | null        | 1           | 1990        |   
| 3  | Mateusz | 2018-06-06  | null        | 2           | 1992        |   
| 4  | Michał  | 2017-09-21  | null        | 2           | 1994        |   
| 5  | Ola     | 2019-05-01  | null        | 2           | 1993        |   
| 6  | Błażej  | 2018-09-01  | 2020-01-01  | 2           | 1992        |   
| 7  | Bogdan  | 2016-06-01  | null        | null        | 1974        |   
| 8  | Konrad  | 2018-02-01  | null        | 7           | 1984        |
| 9  | Kamila  | 2020-02-01  | null        | 7           | 1988        |
| 10 | Ewelina | 2016-02-04  | null        | 2           | 1985        |
| 11 | Kamil   | 2016-09-01  | null        | 7           | 1990        |
| 12 | Karolina| 2020-01-01  | null        | 1           | 1994        |
| 13 | Marcin  | 2018-07-01  | null        | 8           | 1989        |
| 14 | Kacper  | 2018-09-20  | null        | 8           | 1988        |
| 15 | Mariusz | 2016-09-01  | null        | 11          | 1991        |


```employees' phones table```

| id | employee_id | phone_number | phone_brand |
|----|-------------|--------------|-------------|
| 1  |  2          |  66936598    |  Samsung    |
| 2  |  4          |  65988874    |  Xiaomi     |
| 3  |  11         |  79155966    |  Huawei     |
| 4  |  3          |  50289632    |  Xiaomi     |
| 5  |  10         |  60266832    |  Huawei     |
| 6  |  12         |  60025699    |  Huawei     |
| 7  |  9          |  50156488    |  Sony       |
| 8  |  6          |  66396589    |  Xiaomi     |
| 9  |  13         |  69133665    |  Samsung    |
| 10 |  8          |  50969875    |  Xiaomi     |
| 11 |  7          |  66325698    |  Samsung    |
| 12 | 14          |  66452132    |  Huawei     |
| 13 | 5           |  70125698    |  Samsung    |
| 14 | 15          |  60696155    |  Sony       |
| 15 | 1           |  73189655    |  Xiaomi     |

---

## Schemat

![database schema](images/baza.png)

## Technologia
MySQL

