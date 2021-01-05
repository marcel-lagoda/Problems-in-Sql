
/* Rozdział 4. Tworzenie prostego zapytania  ************************************* */

-- W jakich miastach mieszkają nasi klienci?

SELECT DISTINCT MiastoKlienta
FROM Klienci;

-- Potrzebuję imion, nazwisk i adresów wszystkich naszych pracowników.

SELECT ImiePracownika,
       NazwiskoPracownika,
       AdresPracownika,
       MiastoPracownika,
       KodPocztowyPracownika
FROM Pracownicy;

-- Jak nazywają się produkty, które sprzedajemy i do jakiej kategorii należy każdy z nich?

-- WHERE
SELECT Produkty.NazwaProduktu,
       Kategorie.OpisKategorii
FROM Kategorie,
     Produkty
WHERE Kategorie.IDKategorii = Produkty.IDKategorii;


-- INNER JOIN
SELECT Produkty.NazwaProduktu,
       Kategorie.OpisKategorii
FROM Kategorie
         JOIN Produkty
              ON Kategorie.IDKategorii = Produkty.IDKategorii;


-- Wyświetl listę nazw dostawców uporządkowaną według numeru kodu pocztowego.

SELECT NazwaDostawcy
FROM Dostawcy
ORDER BY Dostawcy.KodPocztowyDostawcy;

-- Wyświetl imiona i nazwiska pracowników, ich numery telefonów oraz identyfikatory
-- i uporządkuj listę alfabetycznie wdług imienia i nazwiska.

SELECT ImiePracownika,
       NazwiskoPracownika,
       TelefonPracownika,
       IDPracownika
FROM Pracownicy
ORDER BY NazwiskoPracownika, ImiePracownika;

-- Podaj mi nazwy wszystkich naszych dostawców.

SELECT NazwaDostawcy
FROM Dostawcy;

-- Jakie są nazwy i ceny wszystkich produktów, jakie sprzedajemy?

SELECT NazwaProduktu,
       CenaDetaliczna
FROM Produkty;

-- Z jakich stanów pochodzą nasi klienci?

SELECT DISTINCT StanZamKlienta
FROM Klienci;

-- Jakiego rodzaju zajęcia obecnie oferujemy?

SELECT NazwaPrzedmiotu
FROM Przedmioty;

-- Zrób aktualną listę pracowników wraz z ich numerami telefonów.

SELECT CONCAT(ImiePracownika, ' ', NazwiskoPracownika) AS Pracownik,
       TelefonPracownika
FROM Pracownicy;


SELECT CONCAT_WS(', ', ImiePracownika, NazwiskoPracownika) AS Pracownik,
       TelefonPracownika
FROM Pracownicy;

-- Podaj tematykę zajęć, jakie oferujemy, i wymień je w kolejności alfabetycznej.

SELECT OpisDziedziny
FROM Dziedziny
ORDER BY OpisDziedziny;


-- Czy możemy otrzymać kompletną informację o zajęciach?

SELECT D.OpisDziedziny,
       Zajecia.IDPrzedmiotu,
       P.NazwaPrzedmiotu,
       Zajecia.PunktyEdukacyjne,
       Zajecia.NumerSemestru,
       Zajecia.DataRozpoczecia,
       Zajecia.GodzinaRozpoczecia,
       Zajecia.CzasTrwania
FROM Zajecia
         JOIN Przedmioty P on Zajecia.IDPrzedmiotu = P.IDPrzedmiotu
         JOIN Dziedziny D on P.IDDziedziny = D.IDDziedziny;

SELECT *
FROM Zajecia;

-- Podaj mi listę budynków kampusu oraz liczbę pięter w każdym budynku.
-- Posortuj listę według budynków, rosnąco.

SELECT *
FROM Budynki
ORDER BY Budynki.NazwaBudynku;



-- Jakie mamy kategorie przepisów i jak nazywają się przepisy znajdujące się w każdej z kategorii?

SELECT Kategorie_przepisow.OpisKategoriiPrzepisu,
       Przepisy.NazwaPrzepisu
FROM Przepisy,
     Kategorie_przepisow
WHERE Przepisy.IDKategoriiPrzepisu = Kategorie_przepisow.IDKategoriiPrzepisu;

-- Z jakich miast pochodzą członkowie naszej ligii kręglarskiej?

SELECT DISTINCT MiastoKreglarza,
                StanZamKreglarza
FROM Kreglarze
ORDER BY Kreglarze.MiastoKreglarza;

-- Gdzie odbywają się nasze turnieje?

SELECT DISTINCT LokalizacjaTurnieju
FROM Turnieje;

-- Zrób listę wszystkich dat i lokalizacji turniejów.
-- Daty uporządkuj malejaco, lokalizacje rosnąco.

SELECT DISTINCT DataTurnieju,
                LokalizacjaTurnieju
FROM Turnieje
ORDER BY DataTurnieju DESC, LokalizacjaTurnieju;


-- Podaj wszystkich wykonawców oraz miasta, w których znajduje się ich siedziba.
-- Posortuj rezultaty rosnąco wg miasta i nazwy wykonawcy.

SELECT NazwaScenicznaWykonawcy,
       MiastoWykonawcy
FROM Wykonawcy
ORDER BY MiastoWykonawcy, NazwaScenicznaWykonawcy;

-- Podaj mi daty występów, ale tak, żeby się nie powtarzały.
-- (To zapytanie jest trochę bez sensu. Pokazuje daty i nie uwzględnia ilości imprez danego dnia)

SELECT DISTINCT Imprezy.DzienRozpoczecia
FROM Imprezy;


-- Podaj mi wszystkie informacje na temat naszych pracowników.

SELECT *
FROM Pracownicy;

-- Wymień w kolejności alfabetycznej wszystkie miasta, w których znajdują się nasi dostawcy.
-- Dołącz nazwy dostawców, z którymi w danym mieście współpracujemy.

SELECT Dostawcy.MiastoDostawcy,
       Dostawcy.NazwaDostawcy
FROM Dostawcy;


-- Daj mi listę wszystkich naszych agentów wraz z ich numerami telefonów.
-- Lista powinna być uporządkowana alfabetycznie względem nazwisk i imion.

SELECT ImieAgenta,
       NazwiskoAgenta,
       TelefonAgenta
FROM Agenci
ORDER BY NazwiskoAgenta, ImieAgenta;

-- Podaj mi informację o wszystkich organizwanych przez nas imprezach.

SELECT *
FROM Imprezy;

-- Potrzebuję listy wszystkich występów wraz z datami ich rozpoczęcia.
-- Posortuj rekordy wg. daty w porządku malejącym.

SELECT NumerImprezy,
       DzienRozpoczecia
FROM Imprezy
ORDER BY DzienRozpoczecia ASC;

/* Rozdział 5

1.Jaka jest łączna wartość poszczególnych pozycji w magazynie?
2.Sporządź listę mailingową wszystkich pracowników; nazwiska umieść w pierwszej kolumnie.
3.Podaj godziny rozpoczęcia, zakończenia i czas trwania poszczególnych zajęć.
4.Wylicz dla każdego kręglarza różnicę między wynikiem za handicapem a wynikiem bez handicapu.
5.Ile szacunkowo wynosi stawka godzinowa za każdy występ?
6.Co by się stało, jeśli podnieślibyśmy ceny naszych produktów o 5%?

*/


-- 1.Jaka jest łączna wartość poszczególnych pozycji w magazynie?

USE ZamowieniaPrzyklad;

SELECT NazwaProduktu,
       CenaDetaliczna,
       StanMagazynowy,
       (CenaDetaliczna * StanMagazynowy) AS LacznaWartosc
FROM Produkty
ORDER BY LacznaWartosc DESC;

-- 2.Sporządź listę mailingową wszystkich pracowników; nazwiska umieść w pierwszej kolumnie.

SELECT NazwiskoPracownika,
       ImiePracownika,
       CONCAT('tel: ', TelefonPracownika)
FROM Pracownicy;

-- 3.Podaj godziny rozpoczęcia, zakończenia i czas trwania poszczególnych zajęć.

USE GrafikUczelniPrzyklad;

SELECT GodzinaRozpoczecia,
       ADDTIME(GodzinaRozpoczecia, SEC_TO_TIME(CzasTrwania * 60)) AS GodzinaZakonczenia,
       CzasTrwania
FROM Zajecia;

-- Gdybym chciał odjąć czas.

SELECT GodzinaRozpoczecia,
       TIMEDIFF(GodzinaRozpoczecia, SEC_TO_TIME(CzasTrwania * 60)) AS GodzinaPoOdjęciuCzasu,
       CzasTrwania
FROM Zajecia;

SELECT GodzinaRozpoczecia,
       CzasTrwania,
       GodzinaRozpoczecia + INTERVAL CzasTrwania MINUTE AS GodzinaZakonczenia
FROM Zajecia;

SELECT GodzinaRozpoczecia,
       CzasTrwania,
       GodzinaRozpoczecia - INTERVAL CzasTrwania MINUTE AS Wczesniej
FROM Zajecia;

-- 4.Wylicz dla każdego kręglarza różnicę między wynikiem za handicapem a wynikiem bez handicapu.

USE LigaKreglarskaPrzyklad;

SELECT concat(ImieKreglarza, " ", NazwiskoKreglarza) AS Kreglarz,
       WynikHandicap,
       WynikCzysty,
       WynikHandicap - WynikCzysty                   AS ROZNICA
FROM Wyniki_kreglarzy
         NATURAL JOIN Kreglarze;


-- 5.Ile szacunkowo wynosi stawka godzinowa za każdy występ?


-- 6.Co by się stało, jeśli podnieślibyśmy ceny naszych produktów o 5%?

SELECT NazwaProduktu,
       CenaDetaliczna,
       CenaDetaliczna + (CenaDetaliczna * 0.05) AS NowaCena
FROM Produkty
ORDER BY NowaCena DESC;

-- Podaj mi aktualną listę wszystkich naszych pracowników wraz z ich numerami telefonów.

SELECT CONCAT(ImiePracownika, " ", NazwiskoPracownika) AS Pracownik,
       CONCAT('tel: ', TelefonPracownika)
FROM Pracownicy
ORDER BY NazwiskoPracownika, ImiePracownika;

-- Podaj mi listę wszystkich naszych dostawców wraz z ich numerami identyfikacyjnymi.

SELECT IDDostawcy AS ID,
       NazwaDostawcy
FROM Dostawcy;


-- Zrób listę naszych pracowników wraz z datami urodzenia
-- Dodaj przepracowane lata

SELECT ImiePracownika,
       NazwiskoPracownika,
       DataUrodzPracownika,
       timestampdiff(year, DataUrodzPracownika, NOW())
FROM Pracownicy;


-- Dla każdego agenta wyświetl imię i nazwisko oraz szacunkowy przychód
-- (pensja plus premia) przy założeniu, że każdy agent sprzeda rezerwacji za $50K.

SELECT CONCAT(ImieAgenta, " ", NazwiskoAgenta) as Agent,
       Wynagrodzenie,
       Premia,
       ROUND(Wynagrodzenie + (50000 * Premia)) AS Przychod
FROM Agenci;

-- Ile dni minęło między złożeniem a wysłaniem poszczególnych zamowień
-- Zwróć uwagę na kolejność kolumn w funkcjach

SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki,
       TIMESTAMPDIFF(DAY, DataZamowienia, DataWysylki) AS CzasWyslania,
       DATEDIFF(DataWysylki, DataZamowienia)
FROM Zamowienia;


-- Jakie byłyby godziny rozpoczęcia poszczególnych zajęc,
-- gdybyśmy zaczynali je o 10 minut później.

SELECT GodzinaRozpoczecia,
       GodzinaRozpoczecia + INTERVAL '00:10' HOUR_MINUTE AS NowaGodzina
FROM Zajecia;

SELECT GodzinaRozpoczecia,
       ADDTIME(GodzinaRozpoczecia, '00:10') AS NowaGodzina
FROM Zajecia;

-- Ile dni uplynęło między złożeniem a wysłaniem zamówienia

SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki,
       TIMESTAMPDIFF(DAY, DataZamowienia, DataWysylki) AS CzasRealizacji
FROM Zamowienia
ORDER BY CzasRealizacji DESC;


SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki,
       CAST(DataWysylki - DataZamowienia AS SIGNED) AS CzasRealizacji
FROM Zamowienia;

-- Jak długo mają trwać poszczególne imprezy?

SELECT NumerImprezy,
       DzienRozpoczecia,
       DzienZakonczenia,
       CONCAT(CAST(CAST(DzienZakonczenia - DzienRozpoczecia AS SIGNED) + 1 AS CHAR), ' dni') AS CzasTrwania
FROM Imprezy;


-- Jaka jest wartość netto każdego z kontraktów przy założeniu naszego udziału w wysokości 12%
-- całkowitej wartośći?

SELECT NumerImprezy,
       WartoscKontraktu,
       ROUND(WartoscKontraktu - (WartoscKontraktu * 0.12), 2) AS WartoscNetto,
       ROUND(WartoscKontraktu * 0.12, 2)                      AS NaszUdzial
FROM Imprezy;


-- Przygotuj liste członków załogi obejmującą wysokość ich wynagrodzenia
-- oraz proponowaną 7-procentową premię dla każdego z nich

SELECT ImieAgenta,
       NazwiskoAgenta,
       Wynagrodzenie,
       ROUND((Wynagrodzenie * 0.07), 2) AS 'Premia (7%)',
       ROUND(Wynagrodzenie + (Wynagrodzenie * 0.07), 2) AS WynagrodzeniePremia
FROM Agenci;


-- Baza danych Zamówienia

-- 1. Jaki efekt miałoby wynegocjowanie niższej o 5% hurtowej ceny zakupu poszczególnych produktów?


CREATE VIEW Zad_1
AS
SELECT CenaHurtowa,
       CenaDetaliczna,
       ROUND(CenaDetaliczna - CenaHurtowa, 2)                        AS ObecnyZysk,
       ROUND(CenaHurtowa - (CenaHurtowa * 0.05), 2)                  AS NowaCenaHurtowa,
       ROUND(CenaDetaliczna - (CenaHurtowa - CenaHurtowa * 0.05), 2) AS NowyZysk
FROM Dostawcy_produktow
         NATURAL JOIN Produkty;


-- Przygotuj listę produktów zamówionych przez poszczególnych klientów

CREATE VIEW LIST_OF_PRODUCTS_ORDERED_BY_CUSTOMERS
AS
SELECT Produkty.NazwaProduktu,
       Dane_zamowien.NumerProduktu,
       CONCAT(ImieKlienta, " ",
              NazwiskoKlienta) AS Klient,
       DataZamowienia,
       Zamowienia.NumerZamowienia
FROM (((Produkty
    JOIN Dane_zamowien
    ON Produkty.NumerProduktu = Dane_zamowien.NumerProduktu)
    JOIN Zamowienia
    ON Zamowienia.NumerZamowienia = Dane_zamowien.NumerZamowienia)
         JOIN Klienci
              ON Klienci.IDKlienta = Zamowienia.IDKlienta)
ORDER BY DataZamowienia;


-- Przygotuj listę zamówień złożonych przez poszczególnych klientów w kolejności chronologicznej od najstarszych.


SELECT Zamowienia.IDKlienta,
       CONCAT(ImieKlienta, " ",
              NazwiskoKlienta) AS Klient,
       NumerZamowienia,
       DataZamowienia
FROM Zamowienia
         NATURAL JOIN Klienci
ORDER BY DataZamowienia ASC;


-- Przygotuj kompletną listę nazw dostawców i ichadresów i posortuj wdług nazwy dostawcy

SELECT NazwaDostawcy,
       AdresDostawcy
FROM Dostawcy
ORDER BY NazwaDostawcy;


-- Zrób zestawienie wszystkich naszych klientów wg miasta.

SELECT CONCAT(ImieKlienta, " ",
              NazwiskoKlienta) AS Klient,
       MiastoKlienta
FROM Klienci
ORDER BY MiastoKlienta;


-- Potrzebuję listy wszystkich wykonawców i ich stron WWW

SELECT NazwaScenicznaWykonawcy,
       StronaInterWykonawcy
FROM Wykonawcy;


-- Podaj mi daty pierwszych półrocznych sprawdzianów wyników dla agentów.

SELECT CONCAT(ImieAgenta, " ",
              NazwiskoAgenta)     AS Agent,
       DataZatrudnienia,
       date_add(DataZatrudnienia,
                interval 180 day) AS PierwszaOcena
FROM Agenci
ORDER BY Agent;

-- Potrzebuję listy pracowników uporządkowanej względem kwoty wynagrodzenia (malejąco)

SELECT CONCAT(ImiePracownika, " ",
              NazwiskoPracownika) AS Pracownik,
       Wynagrodzenie
FROM Pracownicy
ORDER BY Wynagrodzenie DESC, NazwiskoPracownika;


-- Czy możesz przygotować listę telefonów naszych pracownników

SELECT CONCAT(ImiePracownika, " ",
              NazwiskoPracownika)         AS Pracownik,
       CONCAT('tel: ', TelefonPracownika) AS Telefon
FROM Pracownicy
ORDER BY NazwiskoPracownika;


-- Potrzebuję zestawienia naszych uczniów, względem miasta

SELECT ImieStudenta,
       NazwiskoStudenta,
       MiastoStudenta
FROM Studenci
ORDER BY MiastoStudenta, NazwiskoStudenta;


-- Podaj mi datyc przyszłorocznych turniejów w poszczególnych kręgielniach (założenie jest 2012)

SELECT DataTurnieju,
       LokalizacjaTurnieju
FROM Turnieje
WHERE DataTurnieju > '2012-12-31'
ORDER BY DataTurnieju ASC;

-- LUB: Można dodać rok do obecnych dat

SELECT LokalizacjaTurnieju,
       DataTurnieju,
       DataTurnieju + Interval 364 Day AS PrzyszlorocznaDataTurnieju
FROM Turnieje
ORDER BY LokalizacjaTurnieju;


-- Stwórz listę wszystkich członków ligi wraz z numerami telefonów

SELECT IDKreglarza,
       ImieKreglarza,
       NazwiskoKreglarza
FROM Kreglarze;


-- Podaj skład poszczególnych drużyn

SELECT Kreglarze.ImieKreglarza,
       Kreglarze.NazwiskoKreglarza,
       NazwaDruzyny
FROM Kreglarze
         NATURAL JOIN Druzyny
ORDER BY NazwaDruzyny;


/*

Rodział 6. Filtrowanie danych

*/
-- Podaj mi imiona & nazwiska wszystkich agentów, których zatrudniliśmy 14 marca 1977.

SELECT ImieAgenta,
       NazwiskoAgenta
FROM Agenci
WHERE DataZatrudnienia = '1977-03-14';

-- Podaj mi imiona & nazwiska wszystkich agentów, których nie zatrudniliśmy 14 marca 1977.

SELECT ImieAgenta,
       NazwiskoAgenta,
       DataZatrudnienia
FROM Agenci
WHERE DataZatrudnienia <> '1977-03-14';


-- Podaj mi listę nazw oraz numerów telefonów wszystkich naszych dostawców,
-- z wyjątkiem przedsiębiorstw z siedzibą w Bellevue

SELECT NazwaDostawcy,
       TelefonDostawcy,
       MiastoDostawcy
FROM Dostawcy
WHERE MiastoDostawcy != 'Bellevue';


-- Czy istnieją zamówienia, którym omyłkowo została przypisana data wysyłki
-- wcześniejsza niż data zamówienia?

SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki
FROM Zamowienia
WHERE DataWysylki < DataZamowienia;

-- Czy któreś z naszych zajęć pozwalają uzyskać więcej niż 4 punkty edu?

SELECT IDZajec,
       PunktyEdukacyjne
FROM Zajecia
WHERE PunktyEdukacyjne > 4;

SELECT IDZajec,
       NazwaPrzedmiotu,
       PunktyEdukacyjne
FROM Zajecia
         NATURAL JOIN Przedmioty
WHERE PunktyEdukacyjne > 4;


-- Potrzebuję zestawienia wszystkich zatrudnionych do 1 stycznia 1989 włącznie.

SELECT ImiePracownika,
       NazwiskoPracownika,
       DataZatrudnienia
FROM Pracownicy
WHERE DataZatrudnienia <= '1989-01-01'

-- Potrzebuję zestawienia wszystkich zatrudnionych OD 1 stycznia 1989 włącznie.

SELECT ImiePracownika,
       NazwiskoPracownika,
       DataZatrudnienia
FROM Pracownicy
WHERE DataZatrudnienia >= '1989-01-01'


-- Podaj mi listę produktów, których cena detaliczna wynosi poniżej 50 pln.

SELECT NazwaProduktu,
       CenaDetaliczna
FROM Produkty
WHERE CenaDetaliczna < 50.00;


-- Którzy pracownicy zostali zatrudnieni w lipcu 1986 roku?

SELECT ImiePracownika,
       NazwiskoPracownika,
       DataZatrudnienia
FROM Pracownicy
WHERE DataZatrudnienia BETWEEN '1986-07-01' AND '1986-07-31';


-- Podaj listę uczniów, których nazwiska zaczynają się na literę B.

SELECT NazwiskoStudenta,
       ImieStudenta
FROM Studenci
WHERE NazwiskoStudenta LIKE 'B%'


-- Podaj mi zestawienie wszystkich imprez zaplanowanych na 10.10.2012.

SELECT NumerImprezy,
       DzienRozpoczecia,
       DzienZakonczenia
FROM Imprezy
WHERE '2012-10-10' BETWEEN DzienRozpoczecia AND DzienZakonczenia;


-- Chcę wiedzieć, które kręgielnie sponsorowały turnieje w następujących dniach
-- 2012 r: 18.09, 9.10, 6.11

SELECT LokalizacjaTurnieju
FROM Turnieje
WHERE DataTurnieju IN ('2012-09-18', '2012-10-09', '2012-11-06');


-- Których wykonawców z Seattle, Redmond and Bothell reprezentujemy?

SELECT NazwaScenicznaWykonawcy,
       MiastoWykonawcy
FROM Wykonawcy
WHERE MiastoWykonawcy IN ('Seattle', 'Redmond', 'Bothell');


-- Podaj imiona i nazwiska klientow, którzy mieszkają w Seattle,
-- a ich nazwiska zaczynają się na 'H'

SELECT ImieKlienta,
       NazwiskoKlienta,
       MiastoKlienta
FROM Klienci
WHERE MiastoKlienta = 'Seattle'
  AND NazwiskoKlienta LIKE 'H%';


-- Potrzebuję zestawienia zawierającego imion, nazwiska, miasta i stany zamieszkania
-- wszystkich pracowników, którzy mieszkają w Seattle albo pochodzą ze stanu Oregon.

SELECT ImiePracownika,
       NazwiskoPracownika,
       MiastoPracownika,
       StanZamPracownika
FROM Pracownicy
WHERE MiastoPracownika = 'Seattle'
   OR StanZamPracownika = 'OR';


-- Potrzebuję zestawienia wszystkich pracowników, których numer kierunkowy to 425,
-- a numer telefonu zaczyna się od 555, a także wszystkich tych, których data urodzenia wypada:
-- między 1.10.1950 a 31.12.1975

SELECT ImiePracownika,
       NazwiskoPracownika,
       NumKierunkPracownika,
       TelefonPracownika,
       DataUrodzPracownika
FROM Pracownicy
WHERE NumKierunkPracownika = 425
    AND TelefonPracownika LIKE '555%'
   OR TelefonPracownika LIKE '(555%'
   OR DataUrodzPracownika BETWEEN '1950-10-01' AND '1975-12-31';



-- Potrzebuję imion nazwisk i tytułów wszystkich profesorów
-- lub adiunktów, którzy zostali zatrudnieni 16 maja 1989

SELECT ImiePracownika,
       NazwiskoPracownika,
       Tytul,
       DataZatrudnienia
FROM Wykladowcy
         JOIN Pracownicy
              USING (IDPracownika)
WHERE (Tytul = 'Profesor'
    OR Tytul = 'Adiunkt')
  AND DataZatrudnienia = '1989-05-16';

-- Podaj mi miejsca i daty dowolnych turniejów, które nie odbywają się w kręgielniach
-- Bolero Lanes, Imperial Lanes albo Thunderbird Lanes

SELECT DataTurnieju,
       LokalizacjaTurnieju
FROM Turnieje
WHERE LokalizacjaTurnieju NOT IN ('Bolero Lanes', 'Imperial Lanes', 'Thunderbird Lanes');

SELECT DataTurnieju,
       LokalizacjaTurnieju
FROM Turnieje
WHERE NOT LokalizacjaTurnieju IN ('Bolero Lanes', 'Imperial Lanes', 'Thunderbird Lanes');


-- Kręglarze, którzy mieszkają poza 'Bellevue'

SELECT ImieKreglarza,
       NazwiskoKreglarza,
       MiastoKreglarza
FROM Kreglarze
WHERE MiastoKreglarza NOT LIKE 'Bellevue';
# WHERE NOT MiastoKreglarza  LIKE 'Bellevue';
#  WHERE MiastoKreglarza <> 'Bellevue';



-- Którzy pracownicy nie są nauczycielami albo asystentami nauczycieli?

SELECT ImiePracownika,
       NazwiskoPracownika,
       Stanowisko,
FROM Pracownicy
WHERE NOT Stanowisko LIKE 'Wykladowcy';


-- Zrób zestawienie imprez, które odbywają się w tygodniu od 2012-11-12 do 2012-11-18

SELECT NumerImprezy,
       DzienRozpoczecia,
       DzienZakonczenia
FROM Imprezy
WHERE (DzienRozpoczecia <= '2012-11-18')
  AND DzienZakonczenia >= '2012-11-12';


SELECT NumerImprezy,
       DzienRozpoczecia,
       DzienZakonczenia
FROM Imprezy
WHERE DzienRozpoczecia BETWEEN '2012-11-12' AND '2012-11-18'
   OR (DzienZakonczenia BETWEEN '2012-11-12' AND '2012-11-18');


-- Podaj mi wszystkie zamówienia dla klienta o idnetyfikatorze 1001.

SELECT NumerZamowienia,
       IDKlienta
FROM Zamowienia
WHERE IDKlienta = 1001;


-- Podaj mi alfabetyczną listę produktów, których nazwy zawierają słowo Dog

SELECT NazwaProduktu
FROM Produkty
WHERE NazwaProduktu LIKE '%Dog%'
ORDER BY NazwaProduktu ASC;


-- Sporządź alfabetyczną listę wszystkich wykonawców, którzy
-- mają siedzibę w Bellevue, Redmond albo Woodinville

SELECT NazwaScenicznaWykonawcy,
       MiastoWykonawcy
FROM Wykonawcy
WHERE MiastoWykonawcy IN ('Bellevue', 'Redmond', 'Woodinville')
ORDER BY NazwaScenicznaWykonawcy;

-- Podaj mi wszystkie 4-dniowe imprezy

SELECT NumerImprezy,
       DzienRozpoczecia,
       DzienZakonczenia
FROM Imprezy
WHERE CAST(DzienZakonczenia - DzienRozpoczecia AS SIGNED) + 1 = 4;

-- Opracuj alfabetyczną listę wszystkich pracowników oraz ich wynagrodzeń
-- 40.000 - 50.000

SELECT ImiePracownika,
       NazwiskoPracownika,
       Wynagrodzenie
FROM Pracownicy
WHERE Wynagrodzenie >= 40000
  AND Wynagrodzenie <= 50000
ORDER BY NazwiskoPracownika, ImiePracownika;


-- Zrób listę studentów, którzy noszą nazwisko Kennedy albo mieszkają w Seattle

SELECT ImieStudenta,
       NazwiskoStudenta,
       MiastoStudenta
FROM Studenci
WHERE NazwiskoStudenta = 'Kennedy'
   OR MiastoStudenta = 'Seattle';


-- Podaj mi identyfikatory zespołów, które wygrały jeden lub większą liczbę
-- pośród pierwszych dziesięciu meczów w grze nr 3

SELECT IDWygranejDruzyny,
       NumerGry,
       IDMeczu
FROM Gry_meczowe
WHERE NumerGry = 3
  AND IDMeczu <= 10;


-- Potrzebuję listy kręglarzy z zespołów 3, 4, 5, których nazwiska zaczynają się na 'H%'

SELECT ImieKreglarza,
       NazwiskoKreglarza,
       IDDruzyny
FROM Kreglarze
WHERE IDDruzyny IN (3, 4, 5)
  AND NazwiskoKreglarza LIKE 'H%';


-- Zróbb listę przepisów, do których nie dodano żadnych uwag.

SELECT NazwaPrzepisu,
       Uwagi
FROM Przepisy
WHERE Uwagi IS NULL;


-- Podaj składniki należące do mięs (kategoria składnika to 2), ale oprócz kurczaka.

SELECT NazwaSkladnika,
       IDKategoriiSkladnika
FROM Skladniki
WHERE IDKategoriiSkladnika = 2
  AND NOT NazwaSkladnika LIKE '%kurczak%';



/* Rozdział 7. Myślenie zbiorami **************************************************** */

-- Znajdowanie wartości wspólnych

-- Wyświetl zamówienia, które zawierają rower oraz kask.
-- Wyswietl zamówienia, które zawierają rower lub kask.

SELECT DISTINCT NumerZamowienia,
                NumerProduktu
FROM Dane_zamowien
WHERE NumerProduktu IN (1, 2, 6, 10, 11, 25, 26);


-- Wyświetl zamówienia, które zawierają rower oraz kask.
-- Wyświetl zamówienia, które zawierają zarówno rower, jak i kask.

/* SQL ogólnie
SELECT DISTINCT NumerZamowienia,
                NumerProduktu
FROM Dane_zamowien
WHERE NumerProduktu IN (1, 2, 6, 11)
INTERSECT ALL
SELECT DISTINCT NumerZamowienia,
                NumerProduktu
FROM Dane_zamowien
WHERE NumerProduktu IN (10, 25, 26);
*/

-- INNER JOIN


-- Znajdowanie wartości brakujących.

-- Wyświetl zamówienia, które zawierają rower ale nie kask.

/*
SELECT DISTINCT NumerZamowienia
FROM Dane_zamowien
WHERE NumerProduktu IN (10, 25, 26)
EXCEPT
SELECT NumerZamowienia
FROM Dane_zamowien
WHERE NumerProduktu IN (1, 2, 6, 11)
*/

-- OUTER JOIN

-- Łączenie zbiorów.

-- Wyświetl zamówienia, które zawierają rower lub kask.

SELECT DISTINCT NumerZamowienia
FROM Dane_zamowien
WHERE NumerProduktu IN (1, 2, 6, 10, 11, 25, 26);

SELECT DISTINCT NumerZamowienia
FROM Dane_zamowien
WHERE NumerProduktu IN (1, 2, 6, 11)
UNION
SELECT DISTINCT NumerZamowienia
FROM Dane_zamowien
WHERE NumerProduktu IN (10, 25, 26);



/* Rozdział 8. Złączenie INNER Join. ************************************************************************ */

-- Podaj mi nazwy przepisów, sposób ich wykonania oraz nazwy kategorii wszystkich
-- przepisów znajdujących się w mojej bazie danych.

SELECT NazwaPrzepisu,
       SposobPrzyrzadzania,
       OpisKategoriiPrzepisu
FROM Przepisy
         NATURAL JOIN Kategorie_przepisow;

SELECT Kategorie_przepisow.OpisKategoriiPrzepisu,
       Przepisy.NazwaPrzepisu,
       Przepisy.SposobPrzyrzadzania
FROM Przepisy
         JOIN Kategorie_przepisow
              ON Przepisy.IDKategoriiPrzepisu = Kategorie_przepisow.IDKategoriiPrzepisu;

SELECT NazwaPrzepisu,
       SposobPrzyrzadzania,
       OpisKategoriiPrzepisu
FROM Przepisy
         JOIN Kategorie_przepisow
              USING (IDKategoriiPrzepisu);


SELECT NazwaPrzepisu,
       SposobPrzyrzadzania,
       OpisKategoriiPrzepisu
FROM Przepisy,
     Kategorie_przepisow
WHERE Przepisy.IDKategoriiPrzepisu = Kategorie_przepisow.IDKategoriiPrzepisu;


SELECT Przepisy.NazwaPrzepisu,
       Przepisy.SposobPrzyrzadzania,
       Kp.OpisKategoriiPrzepisu
FROM Przepisy
         JOIN Kategorie_przepisow Kp on Przepisy.IDKategoriiPrzepisu = Kp.IDKategoriiPrzepisu;



-- Potrzebuję z bazy przepisów następujących informacji:
-- kategorii przepisu, nazwy przepisu, sposobu przyrządzania, nazw składników,
-- numerów poszczególnych kroków, ilości składników
-- i jednostek miar składników posortowanych według kolejności kroków.

SELECT Kategorie_przepisow.OpisKategoriiPrzepisu,
       P.NazwaPrzepisu,
       P.SposobPrzyrzadzania,
       S.NazwaSkladnika,
       Sp.NumerKrokuPrzepisu,
       M.OpisMiary
FROM Kategorie_przepisow
         JOIN Przepisy P on Kategorie_przepisow.IDKategoriiPrzepisu = P.IDKategoriiPrzepisu
         JOIN Skladniki_przepisow Sp on P.IDPrzepisu = Sp.IDPrzepisu
         JOIN Miary M on Sp.IDMiaryIlosci = M.IDMiaryIlosci
         JOIN Skladniki S on M.IDMiaryIlosci = S.IDMiaryIlosci
ORDER BY NazwaPrzepisu, NumerKrokuPrzepisu;

-- Podaj mi nazwy wszystkich moich przepisów i nazw wszystkich składników potrzebnych do tych przepisów

SELECT NazwaPrzepisu,
       NazwaSkladnika
FROM Przepisy
         JOIN (Skladniki_przepisow
    JOIN Skladniki
    ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika)
              ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu;

SELECT NazwaSkladnika,
       NazwaPrzepisu
FROM (Skladniki
    JOIN Skladniki_przepisow
    ON Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika)
         JOIN Przepisy
              ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu;

-- Wymień dostawców i produkty, w które się u nich zaopatrujemy

SELECT NazwaProduktu
FROM Produkty
WHERE NazwaProduktu LIKE '%Dog%'
ORDER BY NazwaProduktu ASC;

SELECT NazwaProduktu,
       NazwaDostawcy
FROM (Produkty
    INNER JOIN Dostawcy_produktow
    ON Dostawcy_produktow.NumerProduktu = Produkty.NumerProduktu)
         INNER JOIN Dostawcy
                    ON Dostawcy_produktow.IDDostawcy = Dostawcy.IDDostawcy;


-- Potrzebuję listy klientów i pracowników, u których złożyli oni zamówienia

SELECT CONCAT(ImieKlienta, " ",
              NazwiskoKlienta)    AS Klient,
       CONCAT(ImiePracownika, " ",
              NazwiskoPracownika) AS Pracownik
FROM Klienci
         JOIN Zamowienia
              ON Klienci.IDKlienta = Zamowienia.IDKlienta
         JOIN Pracownicy
              ON Zamowienia.IDPracownika = Pracownicy.IDPracownika;


-- WYmień agentów i daty imprez, które zorganizowali

SELECT CONCAT(ImieAgenta,
              " ", NazwiskoAgenta)   AS Agent,
       NumerImprezy,
       CONCAT(DzienRozpoczecia,
              " ", DzienZakonczenia) AS Impreza,
       NazwaScenicznaWykonawcy
FROM Agenci
         NATURAL JOIN Imprezy
         NATURAL JOIN Wykonawcy;

SELECT CONCAT(ImieAgenta,
              " ", NazwiskoAgenta)   AS Agent,
       NumerImprezy,
       CONCAT(DzienRozpoczecia,
              " ", DzienZakonczenia) AS Impreza,
       NazwaScenicznaWykonawcy
FROM Agenci
         INNER JOIN Imprezy
                    ON Agenci.IDAgenta = Imprezy.IDAgenta
         INNER JOIN Wykonawcy
                    ON Imprezy.IDWykonawcy = Wykonawcy.IDWykonawcy;


-- Sporządź listę klientów i zamówionych przez nich występów wykonawców

SELECT ImieKlienta,
       NazwiskoKlienta,
       NazwaScenicznaWykonawcy
FROM ((Klienci
    JOIN Imprezy
    ON Klienci.IDKlienta = Imprezy.IDKlienta)
         JOIN Wykonawcy
              ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy);

-- Wyszukaj wykonawców, którzy występowali dla klientów o nazwiskach Berg albo Hallmark

SELECT ImieKlienta,
       NazwiskoKlienta,
       NazwaScenicznaWykonawcy
FROM Klienci
         NATURAL JOIN Imprezy
         NATURAL JOIN Wykonawcy
WHERE NazwiskoKlienta IN ('Berg', 'Hallmark');

SELECT ImieKlienta,
       NazwiskoKlienta,
       NazwaScenicznaWykonawcy
FROM ((Klienci
    INNER JOIN Imprezy
    ON Klienci.IDKlienta = Imprezy.IDKlienta)
         INNER JOIN Wykonawcy
                    ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy)
WHERE NazwiskoKlienta IN ('Berg', 'Hallmark');


-- WYświetl zestawienie budynkow liste sal w każdym z budynkow

SELECT KodBudynku,
       NazwaBudynku,
       IDSali,
       LiczbaMiejsc
FROM Budynki
         NATURAL JOIN Sale;


-- Potrzebuję zestawienia wykładowców i przedmiotów, jakich nauczają

SELECT CONCAT(ImiePracownika, " ",
              NazwiskoPracownika) AS Wykladowca,
       KodPrzedmiotu,
       NazwaPrzedmiotu
FROM (((Pracownicy
    INNER JOIN Zajecia_wykladowcow
    ON Pracownicy.IDPracownika = Zajecia_wykladowcow.IDPracownika)
    INNER JOIN Zajecia
    ON Zajecia.IDZajec = Zajecia_wykladowcow.IDZajec)
         INNER JOIN Przedmioty
                    ON Przedmioty.IDPrzedmiotu = Zajecia.IDPrzedmiotu);

-- wymień wszystkie drużyny kręglarskie i ich kapitanów

SELECT Druzyny.IDDruzyny,
       Druzyny.NazwaDruzyny,
       CONCAT(Kreglarze.ImieKreglarza, " ",
              Kreglarze.NazwiskoKreglarza) AS Kapitan
FROM Druzyny
         JOIN Kreglarze
              ON Druzyny.IDKapitana = Kreglarze.IDKreglarza;
-- Znajdź przepisy zawierające wołowinę lub czosnek.

SELECT Przepisy.IDPrzepisu,
       Przepisy.NazwaPrzepisu,
       Skladniki.NazwaSkladnika
FROM ((Przepisy
    INNER JOIN Skladniki_przepisow
    ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu)
         INNER JOIN Skladniki
                    ON Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika)
WHERE NazwaSkladnika LIKE '%wołowina%'
   OR NazwaSkladnika LIKE '%czosnek%';


-- Wyswietl wszystkie składniki w przepisach, do których jest potrzebna marchew

SELECT NazwaPrzepisu,
       NazwaSkladnika
FROM ((Przepisy
    JOIN Skladniki_przepisow
    ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu)
         JOIN Skladniki
              ON Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika)
WHERE NazwaSkladnika LIKE '%marche%';

USE PrzepisyPrzyklad;

-- Podaj mi nazwy przepisów, sposób ich wykonania oraz nazwy kategorii
-- wszystkich przepisów znajdujących się w mojej bazie danych.

SELECT Przepisy.NazwaPrzepisu,
       Przepisy.SposobPrzyrzadzania,
       Kp.OpisKategoriiPrzepisu
FROM Przepisy
         JOIN Kategorie_przepisow Kp on Przepisy.IDKategoriiPrzepisu = Kp.IDKategoriiPrzepisu;

-- Potrzebuję z bazy przepisów następujących informacji:
-- kategorii przepisu, nazwy przepisu, sposobu przyrządzania, nazw składników,
-- numerów poszczególnych kroków, ilości składników
-- i jednostek miar składników posortowanych według kolejności kroków.

SELECT Kategorie_przepisow.OpisKategoriiPrzepisu,
       P.NazwaPrzepisu,
       P.SposobPrzyrzadzania,
       S.NazwaSkladnika,
       Sp.NumerKrokuPrzepisu,
       M.OpisMiary
FROM Kategorie_przepisow
         JOIN Przepisy P on Kategorie_przepisow.IDKategoriiPrzepisu = P.IDKategoriiPrzepisu
         JOIN Skladniki_przepisow Sp on P.IDPrzepisu = Sp.IDPrzepisu
         JOIN Miary M on Sp.IDMiaryIlosci = M.IDMiaryIlosci
         JOIN Skladniki S on M.IDMiaryIlosci = S.IDMiaryIlosci
ORDER BY NazwaPrzepisu, NumerKrokuPrzepisu;

-- Podaj nazwy wszystkich moich przepisów i nazwy wszystkich składników potrzebnych do tych przepisów.

SELECT P.NazwaPrzepisu,
       S.NazwaSkladnika
FROM Przepisy P
         JOIN Skladniki_przepisow Sp on P.IDPrzepisu = Sp.IDPrzepisu
         JOIN Skladniki S on Sp.IDSkladnika = S.IDSkladnika;

USE ZamowieniaPrzyklad;

-- Wymień klientów i pracowników, którzy noszą to samo nazwisko.

SELECT DISTINCT Klienci.NazwiskoKlienta,
                P.NazwiskoPracownika
FROM Klienci
         JOIN Zamowienia Z on Klienci.IDKlienta = Z.IDKlienta
         JOIN Pracownicy P on Z.IDPracownika = P.IDPracownika
WHERE Klienci.NazwiskoKlienta = P.NazwiskoPracownika;

-- Wymień klientów i pracowników, którzy mieszkają w tym samym mieście.

SELECT DISTINCT K.NazwiskoKlienta,
                P.NazwiskoPracownika
FROM Klienci K
         JOIN Zamowienia Z on K.IDKlienta = Z.IDKlienta
         JOIN Pracownicy P on Z.IDPracownika = P.IDPracownika
WHERE P.MiastoPracownika = K.MiastoKlienta;

-- Wyszukaj wszystkich klientów, którzy zamówili rower, a oprócz tego zamówili też kask.

SELECT Rower.ImieKlienta,
       Rower.NazwiskoKlienta
FROM (SELECT DISTINCT K.IDKlienta,
                      K.NazwiskoKlienta,
                      K.ImieKlienta
      FROM Klienci K
               JOIN Zamowienia Z on K.IDKlienta = Z.IDKlienta
               JOIN Dane_zamowien Dz on Z.NumerZamowienia = Dz.NumerZamowienia
               JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
      WHERE NazwaProduktu LIKE 'Rower%') AS Rower
         INNER JOIN
     (SELECT DISTINCT K.IDKlienta
      FROM Klienci K
               JOIN Zamowienia Z on K.IDKlienta = Z.IDKlienta
               JOIN Dane_zamowien Dz on Z.NumerZamowienia = Dz.NumerZamowienia
               JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
      WHERE NazwaProduktu LIKE 'Kask%') AS Kask
     ON Rower.IDKlienta = Kask.IDKlienta;

USE AgencjaArtystycznaPrzyklad;

-- Znajdź agentów i wykonawców, którzy mają ten sam kod pocztowy.

/*
SELECT Agenci.IDAgenta,
       Agenci.ImieAgenta,
       Agenci.NazwiskoAgenta,
       W.NazwaScenicznaWykonawcy
FROM Agenci
         JOIN Imprezy I on Agenci.IDAgenta = I.IDAgenta
         JOIN Wykonawcy W on I.IDWykonawcy = I.IDAgenta
WHERE Agenci.KodPocztowyAgenta = W.KodPocztowyWykonawcy;

Takie coś nie zadziała. Agenci.KodPocztowyAgenta = Wykonawcy.KodPocztowyWykonawcy
musi być w ON
*/

SELECT DISTINCT Agenci.IDAgenta,
                Agenci.ImieAgenta,
                Agenci.NazwiskoAgenta,
                Agenci.KodPocztowyAgenta,
                Wykonawcy.KodPocztowyWykonawcy,
                Wykonawcy.IDWykonawcy,
                Wykonawcy.NazwaScenicznaWykonawcy
FROM (Agenci
    JOIN Imprezy I on Agenci.IDAgenta = I.IDAgenta)
         JOIN Wykonawcy
              ON KodPocztowyWykonawcy = Agenci.KodPocztowyAgenta;

SELECT DISTINCT CONCAT_WS(' ', Agenci.ImieAgenta,
                          Agenci.NazwiskoAgenta) AS Agent,
                Agenci.KodPocztowyAgenta,
                Wykonawcy.KodPocztowyWykonawcy,
                Wykonawcy.NazwaScenicznaWykonawcy
FROM Agenci
         JOIN Wykonawcy
              ON Agenci.KodPocztowyAgenta = Wykonawcy.KodPocztowyWykonawcy;

SELECT DISTINCT Agenci.IDAgenta,
                Agenci.ImieAgenta,
                Agenci.NazwiskoAgenta,
                Agenci.KodPocztowyAgenta,
                Wykonawcy.KodPocztowyWykonawcy
FROM Agenci
         JOIN Wykonawcy
              ON KodPocztowyWykonawcy = Agenci.KodPocztowyAgenta;


-- Wymień wykonawców, którzy występowali dla klienta o nazwisku Bonnicksen i klienta o nazwisku Rosales.

SELECT Wykonawcy.NazwaScenicznaWykonawcy
FROM Wykonawcy
         JOIN Imprezy I on Wykonawcy.IDWykonawcy = I.IDWykonawcy
         RIGHT JOIN Klienci K on I.IDKlienta = K.IDKlienta
WHERE K.NazwiskoKlienta IN ('Rosales', 'Bonnicksen');

SELECT NazwaScenicznaWykonawcy
FROM Wykonawcy
         JOIN Imprezy
              ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy
         RIGHT JOIN Klienci
                    ON Imprezy.IDKlienta = Klienci.IDKlienta
WHERE NazwiskoKlienta = 'Rosales'
   OR NazwiskoKlienta = 'Bonnicksen';

USE GrafikUczelniPrzyklad;

-- Przygotuj zestawienie uczniów i ich nauczycieli, którzy mają tak samo na imię.

SELECT Studenci.ImieStudenta,
       Studenci.NazwiskoStudenta,
       Pracownicy.ImiePracownika,
       Pracownicy.NazwiskoPracownika
FROM Studenci
         JOIN Pracownicy
              ON ImieStudenta = ImiePracownika;

-- Sporządź listę uczniów, w zajęciach plastycznych średnią 85 lub wyższą
-- i zarazem uzyskali z informatyki średnią 85 lub wyższą.

SELECT ImieStudenta,
       NazwiskoStudenta
FROM Studenci S
         JOIN Grafik_studenta Gs on S.IDStudenta = Gs.IDStudenta
         JOIN Zajecia Z on Gs.IDZajec = Z.IDZajec
         JOIN Przedmioty P on Z.IDPrzedmiotu = P.IDPrzedmiotu
         JOIN Dziedziny D on P.IDDziedziny = D.IDDziedziny
WHERE OpisDziedziny = 'Sztuka'
  AND Gs.Ocena >= 85;


SELECT Art.ImieStudenta,
       Art.NazwiskoStudenta
FROM (SELECT DISTINCT Studenci.IDStudenta,
                      Studenci.ImieStudenta,
                      Studenci.NazwiskoStudenta
      FROM Studenci
               JOIN Grafik_studenta Gs on Studenci.IDStudenta = Gs.IDStudenta
               JOIN Zajecia Z on Gs.IDZajec = Z.IDZajec
               JOIN Przedmioty P on Z.IDPrzedmiotu = P.IDPrzedmiotu
               JOIN Dziedziny D on P.IDDziedziny = D.IDDziedziny
      WHERE D.OpisDziedziny = 'Sztuka'
        AND Gs.Ocena >= 85) Art
         INNER JOIN
     (SELECT DISTINCT Grafik_studenta.IDStudenta
      FROM Grafik_studenta
               JOIN Zajecia Z2 on Grafik_studenta.IDZajec = Z2.IDZajec
               JOIN Przedmioty P2 on Z2.IDPrzedmiotu = P2.IDPrzedmiotu
               JOIN Dziedziny D2 on P2.IDDziedziny = D2.IDDziedziny
      WHERE D2.OpisDziedziny LIKE '%inform%'
        AND Grafik_studenta.Ocena >= 85) Informatyka
     ON Art.IDStudenta = Informatyka.IDStudenta;

-- Wyszukaj kręglarzy, którzy mają ten sam kod pocztowy.
-- Trzeba użyć self joina.


SELECT Concat(Kreglarze.NazwiskoKreglarza, ', ', Kreglarze.ImieKreglarza)   AS PierwszyKreglarz,
       Kreglarze.KodPocztowyKreglarza,
       Concat(Kreglarze2.NazwiskoKreglarza, ', ', Kreglarze2.ImieKreglarza) AS DrugiKreglarz
FROM Kreglarze
         JOIN Kreglarze Kreglarze2
              ON Kreglarze.IDKreglarza <> Kreglarze2.IDKreglarza
                  AND Kreglarze.KodPocztowyKreglarza = Kreglarze2.KodPocztowyKreglarza;


-- Wyszukaj kręglarzy, którzy w kręgieniach Thunderbird Lanes i Bolero Lanes osiągneli
-- wynik 155 lub lepszy bez handicapu.


SELECT Thunderbird.Kreglarz,
       Thunderbird.WynikCzysty
FROM (SELECT DISTINCT Kreglarze.IDKreglarza,
                      CONCAT_WS(', ', Kreglarze.ImieKreglarza, Kreglarze.NazwiskoKreglarza) AS Kreglarz,
                      T.LokalizacjaTurnieju,
                      Wk.WynikCzysty
      FROM Kreglarze
               JOIN Wyniki_kreglarzy Wk on Kreglarze.IDKreglarza = Wk.IDKreglarza
               JOIN Mecze_turniejowe Mt on Wk.IDMeczu = Mt.IDMeczu
               JOIN Turnieje T on Mt.IDTurnieju = T.IDTurnieju
      WHERE T.LokalizacjaTurnieju = 'Thunderbird Lanes'
        AND Wk.WynikCzysty >= 155) AS Thunderbird
         INNER JOIN
     (SELECT DISTINCT Kreglarze.IDKreglarza
      FROM Kreglarze
               JOIN Wyniki_kreglarzy W on Kreglarze.IDKreglarza = W.IDKreglarza
               JOIN Mecze_turniejowe Mt2 on W.IDMeczu = Mt2.IDMeczu
               JOIN Turnieje T2 on Mt2.IDTurnieju = T2.IDTurnieju
      WHERE T2.LokalizacjaTurnieju = 'Bolero Lanes'
        AND W.WynikCzysty >= 155) AS Bolero
     ON Bolero.IDKreglarza = Thunderbird.IDKreglarza
ORDER BY WynikCzysty DESC;

-- Wyszukaj kręglarzy, którzy bez handicapu uzyskali wynik 170 lub lepszy w kręgielniach
-- Thunderbird Lanes i Bolero Lanes.

SELECT Thunderbird.Kreglarz
FROM (SELECT DISTINCT Kreglarze.IDKreglarza,
                      CONCAT_WS(', ', Kreglarze.ImieKreglarza, Kreglarze.NazwiskoKreglarza) AS Kreglarz
      FROM Kreglarze
               JOIN Wyniki_kreglarzy Wk on Kreglarze.IDKreglarza = Wk.IDKreglarza
               JOIN Mecze_turniejowe Mt on Wk.IDMeczu = Mt.IDMeczu
               JOIN Turnieje T on Mt.IDTurnieju = T.IDTurnieju
      WHERE T.LokalizacjaTurnieju = 'Thunderbird Lanes'
        AND Wk.WynikCzysty >= 170) Thunderbird
         INNER JOIN
     (SELECT DISTINCT Kreglarze.IDKreglarza
      FROM Kreglarze
               JOIN Wyniki_kreglarzy W on Kreglarze.IDKreglarza = W.IDKreglarza
               JOIN Mecze_turniejowe Mt2 on W.IDMeczu = Mt2.IDMeczu
               JOIN Turnieje T2 on Mt2.IDTurnieju = T2.IDTurnieju
      WHERE T2.LokalizacjaTurnieju = 'Bolero Lanes'
        AND W.WynikCzysty >= 170) Bolero
     ON Bolero.IDKreglarza = Thunderbird.IDKreglarza;

USE PrzepisyPrzyklad;

-- Wyszukaj składniki, przy których podaje się tę samą domyślną jednostkę miary.






-- Podaj mi przepisy zawierające wołowinę i cebulę (jednocześnie).

SELECT Wolowina.NazwaPrzepisu
FROM (SELECT DISTINCT Przepisy.IDPrzepisu,
                      Przepisy.NazwaPrzepisu
      FROM Przepisy
               JOIN Skladniki_przepisow Sp on Przepisy.IDPrzepisu = Sp.IDPrzepisu
               JOIN Skladniki S on Sp.IDSkladnika = S.IDSkladnika
      WHERE NazwaSkladnika = 'Wołowina') AS Wolowina
         INNER JOIN
     (SELECT DISTINCT Przepisy.IDPrzepisu
      FROM Przepisy
               JOIN Skladniki_przepisow p on Przepisy.IDPrzepisu = p.IDPrzepisu
               JOIN Skladniki S2 on p.IDSkladnika = S2.IDSkladnika
      WHERE NazwaSkladnika = 'Cebula') AS Cebula
     ON Cebula.IDPrzepisu = Wolowina.IDPrzepisu;

-- Przepisy, które zawierają wołowinę lub cebulę

SELECT DISTINCT Przepisy.NazwaPrzepisu
FROM Przepisy
         INNER JOIN Skladniki_przepisow Sp on Przepisy.IDPrzepisu = Sp.IDPrzepisu
WHERE Sp.IDSkladnika IN (1, 2);

-- Przepisy, które zawierają cebulę.

SELECT Przepisy.NazwaPrzepisu
FROM Przepisy
         JOIN Skladniki_przepisow Sp on Przepisy.IDPrzepisu = Sp.IDPrzepisu
         JOIN Skladniki S on Sp.IDSkladnika = S.IDSkladnika
WHERE NazwaSkladnika = 'Cebula';





/* Rodzdział 9 Outer Join */

-- Podaj mi wszystkie kategorie przepisów i dowolnie pasujące do nich przepisy w mojej bazie danych

SELECT OpisKategoriiPrzepisu,
       NazwaPrzepisu
FROM Kategorie_przepisow
         LEFT OUTER JOIN Przepisy
                         ON Kategorie_przepisow.IDKategoriiPrzepisu = Przepisy.IDKategoriiPrzepisu;

-- Tylko te Kategorie, które mają przepisy

SELECT OpisKategoriiPrzepisu,
       NazwaPrzepisu
FROM Kategorie_przepisow
         JOIN Przepisy
              ON Kategorie_przepisow.IDKategoriiPrzepisu = Przepisy.IDKategoriiPrzepisu;


-- Wymień wszystkie kategorie przepisów, w których na razie nie ma żadnego przepisu

SELECT OpisKategoriiPrzepisu,
       NazwaPrzepisu
FROM Kategorie_przepisow
         NATURAL LEFT OUTER JOIN Przepisy
WHERE NazwaPrzepisu IS NULL;


-- Które produkty nie były nigdy zamawiane

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       Zamowienia.NumerZamowienia
FROM Produkty
         LEFT OUTER JOIN Dane_zamowien
                         ON Produkty.NumerProduktu = Dane_zamowien.NumerProduktu
         LEFT OUTER JOIN Zamowienia
                         ON Dane_zamowien.NumerZamowienia = Zamowienia.NumerZamowienia
WHERE Dane_zamowien.NumerZamowienia IS NULL;


-- Zrób listę wykonawców, których występów nikt nie zamawiał

SELECT NazwaScenicznaWykonawcy,
       NazwiskoKlienta
FROM Wykonawcy
         LEFT JOIN Imprezy
                   ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy
         LEFT JOIN Klienci
                   ON Imprezy.IDKlienta = Klienci.IDKlienta
WHERE Imprezy.IDKlienta IS NULL;

-- Wyświetl wszystkie style muzyczne, nawet jeśli nie ma dla nich klientów

SELECT NazwaStylu,
       ImieKlienta,
       NazwiskoKlienta
FROM Style_muzyczne
         LEFT JOIN Gusty_muzyczne
                   ON Style_muzyczne.IDStylu = Gusty_muzyczne.IDStylu
         LEFT JOIN Klienci
                   ON Gusty_muzyczne.IDKlienta = Klienci.IDKlienta;

SELECT ImieKlienta,
       NazwiskoKlienta,
       NazwaStylu
FROM Klienci
         RIGHT OUTER JOIN Gusty_muzyczne
                          ON Klienci.IDKlienta = Gusty_muzyczne.IDKlienta
         RIGHT OUTER JOIN Style_muzyczne
                          ON Gusty_muzyczne.IDStylu = Style_muzyczne.IDStylu;


SELECT Style_muzyczne.IDStylu,
       NazwaStylu,
       ImieKlienta,
       NazwiskoKlienta
FROM Style_muzyczne
         LEFT JOIN (Gusty_muzyczne
    JOIN Klienci ON Gusty_muzyczne.IDKlienta = Klienci.IDKlienta)
                   ON Style_muzyczne.IDStylu = Gusty_muzyczne.IDStylu;



SELECT Style_muzyczne.IDStylu,
       Style_muzyczne.NazwaStylu,
       Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Style_muzyczne
         LEFT OUTER JOIN (Gusty_muzyczne
    INNER JOIN Klienci
    ON Gusty_muzyczne.IDKlienta = Klienci.IDKlienta)
                         ON Style_muzyczne.IDStylu = Gusty_muzyczne.IDStylu


-- Zrób listę wykładowców, którzy nie prowadzą zajęć


SELECT Pracownicy.NazwiskoPracownika,
       Pracownicy.ImiePracownika,
FROM Pracownicy
         LEFT JOIN Zajecia_wykladowcow
                   ON Pracownicy.IDPracownika = Zajecia_wykladowcow.IDPracownika
WHERE Zajecia_wykladowcow.IDZajec IS NULL



SELECT CONCAT(Pracownicy.ImiePracownika,
              " ", Pracownicy.NazwiskoPracownika) AS Pracownik,
       Przedmioty.NazwaPrzedmiotu
FROM Pracownicy
         LEFT JOIN ((Zajecia_wykladowcow
    INNER JOIN Zajecia
    ON Zajecia_wykladowcow.IDZajec = Zajecia.IDZajec)
    INNER JOIN Przedmioty
    ON Zajecia.IDPrzedmiotu = Przedmioty.IDPrzedmiotu)
                   ON Pracownicy.IDPracownika = Zajecia_wykladowcow.IDPracownika
WHERE Zajecia_wykladowcow.IDZajec IS NULL

/* Rozdział 10 Operacja UNION */

-- Przygotuj prostą listę adresową zawierającą nazwę, adres, miasto, stan i kod pocztowy
-- klientów oraz nazwę, asres, miasto, stan i kod pocztowy dostawców

SELECT CONCAT(ImieKlienta, " ",
              NazwiskoKlienta) AS Dane,
       MiastoKlienta           AS Miasto,
       AdresKlienta            AS Adres,
       StanZamKlienta          AS Stan,
       KodPocztowyKlienta      AS KodPocztowy
FROM Klienci
UNION ALL
SELECT NazwaDostawcy,
       MiastoDostawcy,
       AdresDostawcy,
       StanSiedzDostawcy,
       KodPocztowyDostawcy
FROM Dostawcy;

-- Zrób listę klientów i rowerów, które zamówili, w połączeniu z listą dostawców i rowerów, jakie są w ich ofercie

SELECT CONCAT(ImieKlienta,
              " ", NazwiskoKlienta) AS Dane,
       Produkty.NazwaProduktu
FROM ((Klienci
    INNER JOIN Zamowienia
    ON Klienci.IDKlienta = Zamowienia.IDKlienta)
    INNER JOIN Dane_zamowien
    ON Dane_zamowien.NumerZamowienia = Zamowienia.NumerZamowienia)
         INNER JOIN Produkty
                    ON Produkty.NumerProduktu = Dane_zamowien.NumerProduktu
WHERE NazwaProduktu LIKE '%rower%'
UNION ALL
SELECT NazwaDostawcy AS Dane,
       NazwaProduktu
FROM (Dostawcy
    INNER JOIN Dostawcy_produktow
    ON Dostawcy.IDDostawcy = Dostawcy_produktow.IDDostawcy)
         INNER JOIN Produkty
                    ON Produkty.NumerProduktu = Dostawcy_produktow.NumerProduktu
WHERE NazwaProduktu LIKE '%rower%';

-- Utwórz wspólną listę adresową dla klientów, pracowników i dostawców

SELECT CONCAT(ImieKlienta,
              " ", NazwiskoKlienta) AS DaneOsobowe,
       AdresKlienta                 AS Adres,
       MiastoKlienta                AS Miasto,
       StanZamKlienta               AS Stan,
       KodPocztowyKlienta           AS KodPocztowy
FROM Klienci
UNION
SELECT CONCAT(ImiePracownika,
              " ", NazwiskoPracownika),
       AdresPracownika,
       MiastoPracownika,
       StanZamPracownika,
       KodPocztowyPracownika
FROM Pracownicy
UNION
SELECT NazwaDostawcy,
       AdresDostawcy,
       MiastoDostawcy,
       StanSiedzDostawcy,
       KodPocztowyDostawcy
FROM Dostawcy;


-- Utwórz wspólną listę adresową dla klientów, pracowników i dostawców ZE STANU 'WA'

SELECT CONCAT(ImieKlienta,
              " ", NazwiskoKlienta) AS DaneOsobowe,
       AdresKlienta                 AS Adres,
       MiastoKlienta                AS Miasto,
       StanZamKlienta               AS Stan,
       KodPocztowyKlienta           AS KodPocztowy
FROM Klienci
WHERE StanZamKlienta = 'WA'
UNION
SELECT CONCAT(ImiePracownika,
              " ", NazwiskoPracownika),
       AdresPracownika,
       MiastoPracownika,
       StanZamPracownika,
       KodPocztowyPracownika
FROM Pracownicy
WHERE StanZamPracownika = 'WA'
UNION
SELECT NazwaDostawcy,
       AdresDostawcy,
       MiastoDostawcy,
       StanSiedzDostawcy,
       KodPocztowyDostawcy
FROM Dostawcy
WHERE StanSiedzDostawcy = 'WA';



-- Podaj mi imiona, nazwiska i adresy wszystkich klientów i pracowników, z uwzględnieniem, ewentualnych duplikatów
-- posortowane wg kodu pocztowego


SELECT ImieKlienta        AS Imie,
       NazwiskoKlienta    AS Nazwisko,
       AdresKlienta       AS Adres,
       MiastoKlienta      AS Miasto,
       KodPocztowyKlienta AS KodPocztowy
FROM Klienci
UNION ALL
SELECT ImiePracownika,
       NazwiskoPracownika,
       AdresPracownika,
       MiastoPracownika,
       KodPocztowyPracownika
FROM Pracownicy
ORDER BY 5 DESC;

/* Rozdział 11 Podzapytania *********************************************************************************************** */


-- Wyświetl wszystkie zamówienia wysłane 3 października 2012 roku
-- i nazwiska klientów, ktorzy je złożyli


-- JOIN

SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki,
       NazwaProduktu,
       ImieKlienta,
       NazwiskoKlienta
FROM Zamowienia
         NATURAL JOIN Klienci
         NATURAL JOIN Dane_zamowien
         NATURAL JOIN Produkty
WHERE DataWysylki = '2012-10-03';

SELECT NumerZamowienia,
       DataZamowienia,
       DataWysylki,
       ImieKlienta,
       NazwiskoKlienta
FROM Zamowienia
         NATURAL JOIN Klienci
WHERE DataWysylki = '2012-10-03';

-- SELECT

SELECT Zamowienia.NumerZamowienia,
       Zamowienia.DataZamowienia,
       Zamowienia.DataWysylki,
       (SELECT Klienci.NazwiskoKlienta
        FROM Klienci
        WHERE Klienci.IDKlienta = Zamowienia.IDKlienta)
FROM Zamowienia
WHERE Zamowienia.DataWysylki = '2012-10-03';

-- WHERE

SELECT Zamowienia.NumerZamowienia,
       Zamowienia.DataZamowienia,
       Zamowienia.DataWysylki,
       Klienci.NazwiskoKlienta
FROM Klienci,
     Zamowienia
WHERE Klienci.IDKlienta = Zamowienia.IDKlienta
  AND DataZamowienia = '2012-10-03';


-- Wymień wszystkich klientów i liczbę zamówień złożonych przez każdego z nich

SELECT ImieKlienta,
       NazwiskoKlienta,
       (SELECT COUNT(*)
        FROM Zamowienia
        WHERE Zamowienia.IDKlienta = Klienci.IDKlienta)
           AS LiczbaZamowien
FROM Klienci;

-- Podaj listę klientów i daty ostatniego złożonego przez nich zamówienia

SELECT ImieKlienta,
       NazwiskoKlienta,
       (SELECT MAX(DataZamowienia)
        FROM Zamowienia
        WHERE Zamowienia.IDKlienta = Klienci.IDKlienta)
           AS OstatnieZamowienie
FROM Klienci;


SELECT Produkty.NazwaProduktu,
       (SELECT COUNT(ZamowionaIlosc)
        FROM Dane_zamowien
        WHERE Dane_zamowien.NumerProduktu = Produkty.NumerProduktu
       )
FROM Produkty
WHERE NumerProduktu = 1;

-- wyszło mi, że produkt o no = 1 został zamówiony w ilości 527 sztuk

SELECT NazwaProduktu,
       NumerProduktu,
       (SELECT COUNT(NumerZamowienia)
        FROM Dane_zamowien
        WHERE Dane_zamowien.NumerProduktu = Produkty.NumerProduktu)
FROM Produkty;

-- Zrób listę klientów i wszystkich szczegółów dotyczących ich ostatniego zamówienia

SELECT Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta,
       Zamowienia.NumerZamowienia,
       Zamowienia.DataZamowienia,
       Zamowienia.DataWysylki,
       Produkty.NazwaProduktu,
       Produkty.OpisProduktu,
       Dane_zamowien.CenaZakupu,
       Dane_zamowien.ZamowionaIlosc
FROM ((Klienci
    JOIN Zamowienia
    ON Klienci.IDKlienta = Zamowienia.IDKlienta)
    JOIN Dane_zamowien
    ON Zamowienia.NumerZamowienia = Dane_zamowien.NumerZamowienia)
         JOIN Produkty
              ON Dane_zamowien.NumerProduktu = Produkty.NumerProduktu
WHERE DataZamowienia =
      (SELECT MAX(DataZamowienia)
       FROM Zamowienia AS Z
       WHERE Z.IDKlienta = Klienci.IDKlienta);


-- Wymień wszystkie przepisy zawierające warzywa.

-- JOIN 

SELECT NazwaPrzepisu,
       NazwaSkladnika,
       OpisKategoriiSkladnika
FROM Przepisy
         JOIN Skladniki_przepisow
              ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu
         JOIN Skladniki
              ON Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika
         JOIN Kategorie_skladnikow
              ON Skladniki.IDKategoriiSkladnika = Kategorie_skladnikow.IDKategoriiSkladnika
WHERE OpisKategoriiSkladnika LIKE '%warzywa%';

-- SELECT

SELECT NazwaPrzepisu
FROM Przepisy
WHERE Przepisy.IDPrzepisu IN
      (SELECT IDPrzepisu
       FROM (Skladniki_przepisow
           JOIN Skladniki
           ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika)
                JOIN Kategorie_skladnikow
                     ON Skladniki.IDKategoriiSkladnika = Kategorie_skladnikow.IDKategoriiSkladnika
       WHERE Kategorie_skladnikow.OpisKategoriiSkladnika LIKE '%warzywa%');


/* CZĘŚĆ IV. PODSUMOWYWANIE I GRUPOWANIE DANYCH ****************************************************************************************** */

/* Rodział 12 **************************************************************************************************************************** */

-- Ilu spośród naszych klientów mieszka w Seattle

SELECT COUNT(*) AS KlienciZSeattle
FROM Klienci
WHERE MiastoKlienta = 'Seattle';

SELECT COUNT(*) AS LiczbaKlientów,
       ImieKlienta,
       NazwiskoKlienta
FROM Klienci
WHERE MiastoKlienta = 'Seattle'
GROUP BY ImieKlienta, NazwiskoKlienta;

-- Jaka jest łączna wartość wynagrodzenia wypłacanego pracownikom z 'CA'?

SELECT COUNT(Wynagrodzenie)         AS LiczbaPracownikow,
       SUM(Wynagrodzenie)           AS SumaWynagrodzen,
       MAX(Wynagrodzenie)           AS PensjaMAX,
       MIN(Wynagrodzenie)           AS PensjaMIN,
       ROUND(AVG(Wynagrodzenie), 2) AS Srednio
FROM Pracownicy
WHERE StanZamPracownika = 'CA';

SELECT NazwiskoPracownika,
       Wynagrodzenie
FROM Pracownicy
WHERE StanZamPracownika = 'CA';


-- Jaką wartość mają obecnie produkty na stanie naszego magazynu?

SELECT SUM(CenaDetaliczna * StanMagazynowy) AS WartoscProduktowWMagazynie
FROM Produkty;

-- Oblicz sumę wszystkich niepowtarzających się hurtowych cen zakupu
-- dla naszych produktow

SELECT SUM(DISTINCT CenaHurtowa)
FROM Dostawcy_produktow;


-- Jaka jest średnia wartość poszczególnych pozycji dla zamówienia nr 64

SELECT AVG(CenaZakupu * ZamowionaIlosc)
FROM Dane_zamowien
WHERE NumerZamowienia = 64;

SELECT Dane_zamowien.NumerZamowienia,
       Produkty.NumerProduktu,
       ZamowionaIlosc,
       NazwaProduktu,
       CenaDetaliczna,
       CenaZakupu
FROM Produkty
         JOIN Dane_zamowien
              USING (NumerProduktu)
WHERE NumerZamowienia = 64;


-- Oblicz średnią wszystkich niepowtarzających się cen produktów

SELECT AVG(DISTINCT CenaDetaliczna)
FROM Produkty;


-- Jaka była największa pod względem ceny pozycja w zamówieniu 314?

SELECT MAX(CenaZakupu * ZamowionaIlosc)
FROM Dane_zamowien
WHERE NumerZamowienia = 314;

SELECT DISTINCT NumerZamowienia
FROM Dane_zamowien;



-- Zrób listę numerów wszystkich imprez, dla których wartość kontraktu jest większa
-- lub równa średniej wartości kontraktu

SELECT NumerImprezy,
       WartoscKontraktu
FROM Imprezy
WHERE WartoscKontraktu >=
      (SELECT AVG(WartoscKontraktu)
       FROM Imprezy);

SELECT AVG(WartoscKontraktu)
FROM Imprezy;

-- Zrób listę numerów imprez oraz wartości związanych z nimi kontraktów dla wszystkich imprez
-- dla których wartośc kontraktu jest większa niż suma wszystkich kontraktów zawartych we wrzesniu 2012

SELECT NumerImprezy,
       WartoscKontraktu
FROM Imprezy
WHERE WartoscKontraktu >
      (SELECT SUM(WartoscKontraktu)
       FROM Imprezy
       WHERE DzienRozpoczecia BETWEEN '2012-09-1' AND '2012-09-30')


-- Ilu spośród naszych klientów mieszka w Kalifornii?

SELECT COUNT(IDKlienta)
FROM Klienci
WHERE StanZamKlienta = 'CA';

-- Wybierz nazwy i numery produktów, dla których cena zakupu jest większa lub równa
-- średniej cenie detalicznej towarów z tabeli produkty

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu
FROM Produkty
         JOIN Dane_zamowien
              ON Produkty.NumerProduktu = Dane_zamowien.NumerProduktu
WHERE Dane_zamowien.CenaZakupu >=
      (SELECT AVG(CenaDetaliczna)
       FROM Produkty);



-- Zrób listę numerów imprez oraz wartości związanych z nimi kontraktów dla wszystkich imprez
-- dla których wartośc kontraktu jest większa niż suma wszystkich kontraktów zawartych we wrzesniu 2012

SELECT NumerImprezy,
       WartoscKontraktu
FROM Imprezy
WHERE WartoscKontraktu >
      (SELECT SUM(WartoscKontraktu)
       FROM Imprezy
       WHERE DzienRozpoczecia BETWEEN '2012-09-1' AND '2012-09-30')

-- Podaj numer imprezy oraz wartość związanego z nią kontraktu dla
-- najstarszej imprezy w bazie

SELECT NumerImprezy,
       WartoscKontraktu,
       DzienRozpoczecia
FROM Imprezy
WHERE DzienRozpoczecia =
      (SELECT MIN(DzienRozpoczecia)
       FROM Imprezy);

-- Jaka była całkowita wartość wszystkich imprez zorganizowanych w październiku
-- 2012 r.

SELECT SUM(WartoscKontraktu) AS WartoscCalkowitaImprez
FROM Imprezy
WHERE DzienRozpoczecia BETWEEN '2012-10-01' AND '2012-10-31';


-- Ile wynosi najwyższe roczne wynagrodzenie wśród naszych pracowników?

SELECT MAX(Wynagrodzenie)
FROM Pracownicy;

-- Jaka jest sumaryczna wartość wynagrodzeń wypłacanych naszym pracownikom
-- pochodzącym z Kalifornii?

SELECT SUM(Wynagrodzenie)
FROM Pracownicy
WHERE StanZamPracownika = 'CA';


-- Ilu spośród naszych klientów mieszka w Seattle?

SELECT COUNT(*)
FROM Pracownicy
WHERE MiastoPracownika = 'Seattle';

-- Jaka jest najwyższa i najniższa cena, jaką nadaliśmy naszym produktom?

SELECT MAX(CenaDetaliczna),
       MIN(CenaDetaliczna)
FROM Produkty;

-- Jakie produkty mają najwyższą i najniższą cenę? Wyświetl ich nazwy.

SELECT NazwaProduktu,
       CenaDetaliczna
FROM Produkty
WHERE CenaDetaliczna =
      (SELECT MIN(CenaDetaliczna)
       FROM Produkty)
   OR CenaDetaliczna =
      (SELECT MAX(CenaDetaliczna)
       FROM Produkty);

-- Sprawdź, czy cena maksymalna cena zakupu pokrywa się z maksymalną ceną detaliczną

SELECT NumerProduktu,
       NazwaProduktu,
       CenaDetaliczna,
       (SELECT MAX(CenaZakupu)
        FROM Dane_zamowien
        WHERE Dane_zamowien.NumerProduktu = Produkty.NumerProduktu)
FROM Produkty
WHERE CenaDetaliczna =
      (SELECT MAX(CenaDetaliczna)
       FROM Produkty);


-- Ile zajęć prowadzi Michael Hernandez?

SELECT COUNT(IDPracownika)
FROM Zajecia_wykladowcow
WHERE IDPracownika =
      (SELECT IDPracownika
       FROM Pracownicy
       WHERE NazwiskoPracownika LIKE '%Hernandez%'
         AND ImiePracownika LIKE '%michael%');

-- Pokaż liczbę przedmiotów prowadzonych przez Hernandeza

SELECT ImiePracownika,
       NazwiskoPracownika,
       (SELECT COUNT(IDZajec)
        FROM Zajecia_wykladowcow
        WHERE Zajecia_wykladowcow.IDPracownika = Pracownicy.IDPracownika)
FROM Pracownicy
WHERE NazwiskoPracownika = 'Hernandez';

-- O której godzinie zaczynają się najwcześniejsze zajęcia?
-- Podaj nazwę zajęć, które zaczynają się najwcześniej (z godziną)

SELECT IDZajec,
       GodzinaRozpoczecia,
       (SELECT NazwaPrzedmiotu
        FROM Przedmioty
        WHERE Przedmioty.IDPrzedmiotu = Zajecia.IDPrzedmiotu)
FROM Zajecia
WHERE GodzinaRozpoczecia =
      (SELECT MIN(GodzinaRozpoczecia)
       FROM Zajecia);

-- Jaka jest średnia długość zajęć?

SELECT AVG(CzasTrwania)
FROM Zajecia;


-- Jaka jest całkowita wartość zamówienia nr 12?

SELECT NumerZamowienia,
       SUM(CenaZakupu * ZamowionaIlosc)
FROM Dane_zamowien
WHERE NumerZamowienia = 12;


SELECT Produkty.NazwaProduktu,
       Dane_zamowien.ZamowionaIlosc,
       Dane_zamowien.CenaZakupu,
       ZamowionaIlosc * CenaZakupu AS TOTALS
FROM Produkty
         INNER JOIN Dane_zamowien
                    ON Produkty.NumerProduktu = Dane_zamowien.NumerProduktu
WHERE NumerZamowienia = 12;

-- Dodaj kolumnę Totals.

SELECT COUNT(*),
       SUM(StanMagazynowy) AS 'TOTALS'
FROM Produkty


-- Ile wynosi średnia cena detaliczna roweru górskiego?

         SELECT AVG(CenaDetaliczna)
FROM Produkty
WHERE NazwaProduktu LIKE '%rower górski%';

-- Podaj datę ostatniego złożonego u nas zamówienia.

SELECT MAX(DataZamowienia)
FROM Zamowienia;

SELECT DataZamowienia
FROM Zamowienia
ORDER BY DataZamowienia DESC LIMIT 1;

-- Jaka była sumaryczna wartość zamówienia numer 8.

SELECT SUM(CenaZakupu * ZamowionaIlosc)
FROM Dane_zamowien
WHERE NumerZamowienia = 8;


-- Ile wynosi średnie wynagrodzenie naszych agentów?

SELECT AVG(Wynagrodzenie)
FROM Agenci;

-- Podaj mi nr. wszystkich imprez, dla których wartość kontrraktu jest większa lub
-- równa średniej wartości kontraktu.

SELECT NumerImprezy
FROM Imprezy
WHERE WartoscKontraktu >=
      (SELECT AVG(WartoscKontraktu)
       FROM Imprezy);


SELECT NumerImprezy,
       WartoscKontraktu
FROM Imprezy
WHERE WartoscKontraktu >=
      (SELECT AVG(WartoscKontraktu)
       FROM Imprezy);

-- Ilu spośród naszych wykonawców mieszka w Bellevue?

SELECT COUNT(*)
FROM Wykonawcy
WHERE MiastoWykonawcy = 'Bellevue';


-- Zrób listę drużyn i kapitanów

SELECT Druzyny.IDKapitana,
       (SELECT CONCAT(ImieKreglarza, " ",
                      NazwiskoKreglarza)
        FROM Kreglarze
        WHERE Druzyny.IDKapitana = Kreglarze.IDKreglarza),
       Kreglarze.IDKreglarza,
       ImieKreglarza,
       NazwiskoKreglarza,
       Druzyny.NazwaDruzyny
FROM Kreglarze
         INNER JOIN Druzyny
                    USING (IDDruzyny);

/* Rozdział 13. Grupowanie danych ********************************************************************************************************** */


-- Dla każdego zespołu artystycznego podaj nazwę zespołu, liczbę zawartych kontraktów,
-- całkowitą, najniższą, najwyższą, średnią wartość kontraktów

SELECT NazwaScenicznaWykonawcy,
       COUNT(WartoscKontraktu)         AS LiczbaKontraktow,
       MAX(WartoscKontraktu)           AS MAX,
       MIN(WartoscKontraktu)           AS MIN,
       SUM(WartoscKontraktu)           AS SumaWartosciKontraktow,
       ROUND(AVG(WartoscKontraktu), 2) AS AVG
FROM Wykonawcy
         JOIN Imprezy
              ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy
GROUP BY NazwaScenicznaWykonawcy;


SELECT NazwaScenicznaWykonawcy,
       COUNT(WartoscKontraktu)         AS LiczbaKontraktow,
       MAX(WartoscKontraktu)           AS MAX,
       MIN(WartoscKontraktu)           AS MIN,
       SUM(WartoscKontraktu)           AS SumaWartosciKontraktow,
       ROUND(AVG(WartoscKontraktu), 2) AS AVG
FROM Wykonawcy
         LEFT JOIN Imprezy
                   ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy
GROUP BY NazwaScenicznaWykonawcy;



-- Dla każdego klienta podaj imię i nazwisko, liczbę zawartych kontraktów,
-- ich wartość, najwyższą, najniższą oraz średnią wartość

SELECT ImieKlienta,
       NazwiskoKlienta,
       COUNT(NumerImprezy),
       MAX(WartoscKontraktu),
       MIN(WartoscKontraktu),
       SUM(WartoscKontraktu),
       AVG(WartoscKontraktu)
FROM Klienci
         NATURAL LEFT JOIN Imprezy
GROUP BY ImieKlienta, NazwiskoKlienta
ORDER BY NazwiskoKlienta, ImieKlienta;

-- COUNT(*)

SELECT ImieKlienta,
       NazwiskoKlienta,
       COUNT(*),
       MAX(WartoscKontraktu),
       MIN(WartoscKontraktu),
       SUM(WartoscKontraktu),
       AVG(WartoscKontraktu)
FROM Klienci
         NATURAL JOIN Imprezy
GROUP BY ImieKlienta, NazwiskoKlienta
ORDER BY NazwiskoKlienta, ImieKlienta;



-- Dla każdego klienta podaj pełne imię i nazwisko, kompletny adres,
-- datę zawarcia przez tego klienta ostatniego kontraktu oraz
-- łączną wartość wszystkich kontraktów

SELECT ImieKlienta,
       NazwiskoKlienta,
       AdresKlienta,
       MAX(DzienRozpoczecia),
       SUM(WartoscKontraktu)
FROM Klienci
         LEFT JOIN Imprezy
                   ON Klienci.IDKlienta = Imprezy.IDKlienta
GROUP BY ImieKlienta, NazwiskoKlienta, AdresKlienta;


/* Rozdział 14. Filtrowanie zgrupowanych danych ******************************************************************************************** */

-- Wybierz zespoły, ktore grają jazz i mają w swoim składzie więcej niż 3 muzyków.

SELECT NazwaScenicznaWykonawcy,
       NazwaStylu,
       COUNT(Czlonkowie_zespolu.IDWykonawcy)
FROM Wykonawcy
         JOIN Czlonkowie_zespolu
              ON Wykonawcy.IDWykonawcy = Czlonkowie_zespolu.IDWykonawcy
         JOIN Style_wykonawcow
              ON Wykonawcy.IDWykonawcy = Style_wykonawcow.IDWykonawcy
         JOIN Style_muzyczne
              ON Style_wykonawcow.IDStylu = Style_muzyczne.IDStylu
WHERE NazwaStylu LIKE '%jazz%'
GROUP BY NazwaScenicznaWykonawcy, NazwaStylu
HAVING COUNT(Czlonkowie_zespolu.IDWykonawcy) > 3;


-- Wyszukaj stany na zachodnim brzegu USA, gdzie sumaryczna wartość
-- zamówień przekroczyła 1 milion

SELECT Klienci.StanZamKlienta,
       SUM(Dane_zamowien.CenaZakupu * Dane_zamowien.ZamowionaIlosc)
FROM Klienci
         JOIN Zamowienia
              ON Klienci.IDKlienta = Zamowienia.IDKlienta
         JOIN Dane_zamowien
              ON Zamowienia.NumerZamowienia = Dane_zamowien.NumerZamowienia
WHERE StanZamKlienta IN ('WA', 'OR', 'CA')
GROUP BY StanZamKlienta
HAVING SUM(Dane_zamowien.CenaZakupu * Dane_zamowien.ZamowionaIlosc) > 1000000;



/* Rozdział 15. Aktualizowanie Zbiorów Danych. ********************************************************************************************* */


-- Zmodyfikuj plan zajęć przez zmianę sali lekcyjnej na 1635 i dni zajęć
-- z poniedziałku-środy-piątku na wtorek-czwartek-sobotę dla wszystkich zajęć
-- z rysunku (ID przedmiotu 13)

SELECT IDSali,
       PlanNaPoniedzialek,
       PlanNaSrode,
       PlanNaSobote
FROM Zajecia
WHERE IDPrzedmiotu = 13;

SELECT IDSali,
       PlanNaPoniedzialek,
       PlanNaSrode,
       PlanNaSobote
FROM Zajecia
         JOIN Przedmioty
              USING (IDPrzedmiotu)
WHERE IDPrzedmiotu IN
      (SELECT IDPrzedmiotu
       FROM Przedmioty
       WHERE NazwaPrzedmiotu LIKE '%rysunek%');


UPDATE Zajecia
SET PlanNaPoniedzialek = 0,
    PlanNaSrode        = 0,
    PlanNaSobote       = 0,
    PlanNaWtorek       = 1,
    PlanNaCzwartek     = 1,
    PlanNaSobote       = 1
WHERE IDPrzedmiotu = 13;



USE ZamowieniaZmiana;

SHOW TABLES;

-- Zmodyfikuj produkty przez zwiększenie ceny detalicznej wszystkich produktów
-- O 10%

UPDATE Produkty
SET CenaDetaliczna = CenaDetaliczna + (CenaDetaliczna * 0.1);

SELECT NazwaProduktu,
       CenaDetaliczna,
       (CenaDetaliczna + (CenaDetaliczna * 0.1)) AS NowaCena
FROM Produkty;

-- Mój dostawca odzieży właśnie ogłosił zwiększenie ceny detalicznej o 4%
-- dla wszystkich produktów należących do kategorii odzież

SELECT IDKategorii,
       OpisKategorii
FROM Kategorie;

UPDATE Produkty
SET CenaDetaliczna = CenaDetaliczna + (CenaDetaliczna * 0.04)
WHERE IDKategorii = 3;

UPDATE Produkty
SET CenaDetaliczna = CenaDetaliczna * 1.04
WHERE IDKategorii =
      (SELECT IDKategorii
       FROM Kategorie
       WHERE OpisKategorii LIKE '%odzież%');



-- Zrób listę nazw produktów, cen detalicznych oraz cen detalicznych podniesionych
-- o 4% na podstawie tabeli Produkty dla produktów należących do kategorii 3.


SELECT NazwaProduktu,
       CenaDetaliczna,
       CenaDetaliczna * 1.04 AS NowaCena,
       Kategorie.OpisKategorii
FROM Produkty
         INNER JOIN Kategorie
                    USING (IDKategorii)
WHERE IDKategorii =
      (SELECT IDKategorii
       FROM Kategorie
       WHERE OpisKategorii LIKE '%odzież%');



-- Zmień grafik zajęć przez ustalenie godziny rozpoczęcia wszystkich zajęć prowadzonych
-- przez Kathryn Patterson na godzinę 14:00.

UPDATE Zajecia
SET GodzinaRozpoczecia = '14:00:00'
WHERE IDZajec IN
      (SELECT IDZajec
       FROM Zajecia_wykladowcow
                JOIN Pracownicy
                     ON Zajecia_wykladowcow.IDPracownika = Pracownicy.IDPracownika
       WHERE NazwiskoPracownika = 'Patterson');


-- Pokaż wszystkie zajęcia Kathryn Patterson

SELECT Zajecia.IDZajec,
       Zajecia.GodzinaRozpoczecia,
       Przedmioty.IDPrzedmiotu,
       Przedmioty.NazwaPrzedmiotu,
       CONCAT(ImiePracownika, " ",
              NazwiskoPracownika) AS Pracownik
FROM Zajecia
         JOIN Przedmioty
              ON Zajecia.IDPrzedmiotu = Przedmioty.IDPrzedmiotu
         JOIN Przedmioty_wykladowcow
              ON Przedmioty_wykladowcow.IDPrzedmiotu = Przedmioty.IDPrzedmiotu
         JOIN Wykladowcy
              ON Wykladowcy.IDPracownika = Przedmioty_wykladowcow.IDPracownika
         JOIN Pracownicy -- RIGHT JOIN, in case Kathryn has no lectures
              ON Pracownicy.IDPracownika = Wykladowcy.IDPracownika
WHERE NazwiskoPracownika = 'Patterson'
  AND ImiePracownika = 'Kathryn';



/* Rozdział 16 Insert ************************************************************************************************************** */


-- Wprowadź nowego pracownika: Susan Metters

INSERT INTO Pracownicy
(ImiePracownika, NazwiskoPracownika, AdresPracownika, MiastoPracownika, StanZamPracownika,
 KodPocztowyPracownika, NumKierunkPracownika, TelefonPracownika)
VALUES ('Susan', 'Metters', '16547 NE 132nd St.', 'Woodinville', 'WA', '98072', '425', 555 - 7825);

SELECT IDPracownika,
       ImiePracownika,
       NazwiskoPracownika,
       TelefonPracownika
FROM Pracownicy
WHERE NazwiskoPracownika = 'Metters';

UPDATE Pracownicy
SET TelefonPracownika = '555-7824'
WHERE NazwiskoPracownika = 'Metters';

SELECT IDPracownika,
       NazwiskoPracownika
FROM Pracownicy
ORDER BY IDPracownika;


/*
INSERT INTO Pracownicy
(IDPracownika, ImiePracownika, NazwiskoPracownika, AdresPracownika, MiastoPracownika, StanZamPracownika,
 KodPocztowyPracownika, NumKierunkPracownika, TelefonPracownika)
VALUES ((SELECT MAX(IDPracownika) FROM Pracownicy) + 1,
        'John', 'Logan', '14547 NE 132nd St.', 'Woodinville', 'WA', '98072', '425', '555 - 1825')
 */

-- Skopiuj do tabeli Pracownicy odpowiednie kolumny z tabeli Klienci
-- David Smith

INSERT INTO Pracownicy
(ImiePracownika, NazwiskoPracownika, AdresPracownika, MiastoPracownika, StanZamPracownika,
 KodPocztowyPracownika, NumKierunkPracownika, TelefonPracownika)
SELECT Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta,
       Klienci.AdresKlienta,
       Klienci.MiastoKlienta,
       Klienci.StanZamKlienta,
       Klienci.KodPocztowyKlienta,
       Klienci.NumKierKlienta,
       Klienci.TelefonKlienta
FROM Klienci
WHERE ImieKlienta = 'David'
  AND NazwiskoKlienta = 'Smith';


-- Zarchiwizuj dane o wszystkich imprezach, które odbyły się przed '2013-01-01'

SHOW TABLES;

INSERT INTO Imprezy_archiwum
(NumerImprezy, DzienRozpoczecia, DzienZakonczenia, GodzinaRozpoczecia, GodzinaZakonczenia, WartoscKontraktu, IDKlienta,
 IDAgenta, IDWykonawcy)
SELECT Imprezy.NumerImprezy,
       Imprezy.DzienRozpoczecia,
       Imprezy.DzienZakonczenia,
       Imprezy.GodzinaRozpoczecia,
       Imprezy.GodzinaZakonczenia,
       Imprezy.WartoscKontraktu,
       Imprezy.IDKlienta,
       Imprezy.IDAgenta,
       Imprezy.IDWykonawcy
FROM Imprezy
WHERE DzienRozpoczecia < '2013-01-01';

SELECT *
FROM Imprezy_archiwum
WHERE DzienRozpoczecia < '2013-01-01';


-- Dodaj nowy produkt do kategorii Rowery

SELECT *
FROM Produkty
WHERE NazwaProduktu LIKE '%hot dog spinner%';

INSERT INTO Produkty
    (NazwaProduktu, CenaDetaliczna, IDKategorii)
SELECT 'Hot Dog Spinner' AS NazwaProduktu,
       895               AS CenaDetaliczna,
       IDKategorii
FROM Kategorie
WHERE OpisKategorii = 'Rowery';

INSERT INTO Pracownicy
(ImiePracownika, NazwiskoPracownika, AdresPracownika, MiastoPracownika, StanZamPracownika,
 KodPocztowyPracownika, NumKierunkPracownika, TelefonPracownika)
SELECT 'Nicolas'         AS ImiePracownika,
       'Tesla'           AS NazwiskoPracownika,
       '124 Main Street' AS AdresPracownika,
       'New York'        AS MiastoPracownika,
       'NY'              AS StanZamPracownika,
       '123-321'         AS KodPocztowyPracownika,
       '111'             AS NumKierunkPracownika,
       '112'             AS TelefonPracownika;


-- Dodaj nowego dostawcę

INSERT INTO Dostawcy
(NazwaDostawcy, AdresDostawcy, MiastoDostawcy, StanSiedzDostawcy, KodPocztowyDostawcy, TelefonDostawcy,
 FaxDostawcy, StronaInterDostawcy, EmailDostawcy)
VALUES ('Hot Dog Bikes', '1234 Main Street', 'Chicago', 'IL', '606060', '(777)555-3422', '(777)555-3422',
        'www.hotdogbikes.com',
        'hotdog@bikes.com');

-- Zarchiwizuj wszystkie zamówienia złożone przed '2013-01-01'

INSERT INTO Zamowienia_archiwum
(NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika, WartoscCalkowita)
SELECT Zamowienia.NumerZamowienia,
       Zamowienia.DataZamowienia,
       Zamowienia.DataWysylki,
       Zamowienia.IDKlienta,
       Zamowienia.IDPracownika,
       Zamowienia.WartoscCalkowita
FROM Zamowienia
WHERE DataZamowienia < '2013-01-01';

SELECT *
FROM Zamowienia_archiwum
WHERE DataZamowienia < '2013-01-01';



/* CZĘŚĆ VI ***************************************************************************************************************** */
/* Rozdział 18 Problemy z NIE i ORAZ **************************************************************************************** */




-- Zrób listę składników, które nie zostały użyte w żadnym przepisie.

SELECT Skladniki.NazwaSkladnika
FROM Skladniki
         LEFT OUTER JOIN Skladniki_przepisow
                         ON Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika
WHERE Skladniki_przepisow.IDSkladnika IS NULL;



-- Wyszukaj przepisy, które nie zawierają ani wołowiny ani cebuli ani marchwi.

-- OUTER JOIN/ SELECT
	
SELECT
	Przepisy.NazwaPrzepisu,
	Przepisy.IDPrzepisu
FROM
	Przepisy
LEFT OUTER JOIN (
	SELECT
		Skladniki_przepisow.IDPrzepisu
	FROM
		Skladniki_przepisow
	INNER JOIN Skladniki ON
		Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika
	WHERE
		Skladniki.NazwaSkladnika IN ('Wołowina', 'Cebula', 'Marchew')) AS Wolcebmar ON
	Przepisy.IDPrzepisu = Wolcebmar.IDPrzepisu
WHERE
	Wolcebmar.IDPrzepisu IS NULL;

-- NOT IN

SELECT
	Przepisy.NazwaPrzepisu
FROM
	Przepisy
WHERE
	Przepisy.IDPrzepisu NOT IN (
	SELECT
		Skladniki_przepisow.IDPrzepisu
	FROM
		Skladniki_przepisow
	INNER JOIN Skladniki ON
		Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika
	WHERE
		NazwaSkladnika IN ('Wołowina', 'Cebula', 'Marchew'));
	


SELECT Przepisy.IDPrzepisu,
       Przepisy.NazwaPrzepisu
FROM Przepisy
WHERE Przepisy.IDPrzepisu NOT IN
      (SELECT Skladniki_przepisow.IDPrzepisu
       FROM Skladniki_przepisow
                JOIN Skladniki
                     ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika
       WHERE Skladniki.NazwaSkladnika IN ('Wołowina'))
  AND Przepisy.IDPrzepisu NOT IN
      (SELECT Skladniki_przepisow.IDPrzepisu
       FROM Skladniki_przepisow
                JOIN Skladniki
                     ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika
       WHERE Skladniki.NazwaSkladnika IN ('Cebula'))
  AND Przepisy.IDPrzepisu NOT IN
      (SELECT Skladniki_przepisow.IDPrzepisu
       FROM Skladniki_przepisow
                JOIN Skladniki
                     ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika
       WHERE Skladniki.NazwaSkladnika IN ('Marchew'));



-- NOT EXISTS

SELECT
	Przepisy.IDPrzepisu,
	Przepisy.NazwaPrzepisu
FROM
	Przepisy
WHERE
	NOT EXISTS (
	SELECT
		Skladniki_przepisow.IDPrzepisu
	FROM
		Skladniki_przepisow
	INNER JOIN Skladniki ON
		Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika
	WHERE
		Skladniki.NazwaSkladnika IN ('Wołowina', 'Cebula', 'Marchew')
		AND Skladniki_przepisow.IDPrzepisu = Przepisy.IDPrzepisu);
	
-- HAVING/ GROUP BY

SELECT
	Przepisy.IDPrzepisu,
	Przepisy.NazwaPrzepisu
FROM
	Przepisy
LEFT JOIN (
	SELECT
		Skladniki_przepisow.IDPrzepisu
	FROM
		Skladniki_przepisow
	INNER JOIN Skladniki ON
		Skladniki.IDSkladnika = Skladniki_przepisow.IDSkladnika
	WHERE
		NazwaSkladnika IN ('Wołowina', 'Cebula', 'Marchew')) AS WCM ON
	Przepisy.IDPrzepisu = WCM.IDPrzepisu
GROUP BY
	Przepisy.IDPrzepisu,
	Przepisy.NazwaPrzepisu
HAVING
	COUNT(WCM.IDPrzepisu) = 0; 
	

-- Wyszukaj przepisy, które zawierają masło, ale nie zawieraja wołowiny ani cebuli, ani marchwi.

SELECT Przepisy.NazwaPrzepisu,
       Przepisy.IDPrzepisu
FROM ((Przepisy
    JOIN Skladniki_przepisow
    ON Przepisy.IDPrzepisu = Skladniki_przepisow.IDPrzepisu)
    JOIN Skladniki
    ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika)
         LEFT JOIN (SELECT Skladniki_przepisow.IDSkladnika
                    FROM Skladniki_przepisow
                             JOIN Skladniki
                                  ON Skladniki_przepisow.IDSkladnika = Skladniki.IDSkladnika
                    WHERE Skladniki.NazwaSkladnika IN ('Wołowina', 'Cebula', 'Marchew')) AS WCM
                   ON Przepisy.IDPrzepisu = WCM.IDSkladnika
WHERE Skladniki.NazwaSkladnika = 'Masło'
  AND WCM.IDSkladnika IS NULL
GROUP BY Przepisy.NazwaPrzepisu, Przepisy.IDPrzepisu
HAVING COUNT(WCM.IDSkladnika) = 0

USE AgencjaArtystycznaPrzyklad

-- Przygotuj listę klientów, którzy zamawiali występy Carol Peacock Trio, Caroline Coie Cuartet, Jazz Persuasion.

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
WHERE Klienci.IDKlienta IN
      (SELECT Imprezy.IDKlienta
       FROM Imprezy
                JOIN Wykonawcy
                     ON Imprezy.IDWykonawcy = Wykonawcy.IDWykonawcy
       WHERE Wykonawcy.NazwaScenicznaWykonawcy = 'Carol Peacock Trio')
  AND Klienci.IDKlienta IN
      (SELECT Imprezy.IDKlienta
       FROM Imprezy
                JOIN Wykonawcy
                     ON Imprezy.IDWykonawcy = Wykonawcy.IDWykonawcy
       WHERE Wykonawcy.NazwaScenicznaWykonawcy = 'Caroline Coie Cuartet')
  AND Klienci.IDKlienta IN
      (SELECT Imprezy.IDKlienta
       FROM Imprezy
                JOIN Wykonawcy W on Imprezy.IDWykonawcy = W.IDWykonawcy
       WHERE W.NazwaScenicznaWykonawcy = 'Jazz Persuasion');


SELECT DISTINCT CPT.IDKlienta,
                CPT.ImieKlienta,
                CPT.NazwiskoKlienta
FROM ((SELECT Klienci.IDKlienta,
              Klienci.NazwiskoKlienta,
              Klienci.ImieKlienta
       FROM (Klienci
           INNER JOIN Imprezy
           ON Klienci.IDKlienta = Imprezy.IDKlienta)
                INNER JOIN Wykonawcy
                           ON Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy
       WHERE Wykonawcy.NazwaScenicznaWykonawcy = 'Carol Peacock Trio') AS CPT
    INNER JOIN
    (SELECT Klienci.IDKlienta
     FROM (Klienci
         INNER JOIN Imprezy
         ON Klienci.IDKlienta = Imprezy.IDKlienta)
              INNER JOIN Wykonawcy W ON Imprezy.IDWykonawcy = W.IDWykonawcy
     WHERE W.NazwaScenicznaWykonawcy = 'Caroline Coie Cuartet') AS CCC
    ON CPT.IDKlienta = CCC.IDKlienta)
         INNER JOIN
     (SELECT Klienci.IDKlienta
      FROM (Klienci
          INNER JOIN Imprezy I on Klienci.IDKlienta = I.IDKlienta)
               INNER JOIN Wykonawcy W2 on I.IDWykonawcy = W2.IDWykonawcy
      WHERE W2.NazwaScenicznaWykonawcy = 'Jazz Persuasion') AS JP
     ON CCC.IDKlienta = JP.IDKlienta;


-- Wyświetl klientów oraz te zespoły, które style muzyczne pasują do wszystkich stylów
-- preferowanych przez klienta.

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta,
       Wykonawcy.IDWykonawcy,
       Wykonawcy.NazwaScenicznaWykonawcy,
       COUNT(Gusty_muzyczne.IDStylu) AS LiczbaIDStylu
FROM ((Klienci
    INNER JOIN Gusty_muzyczne
    ON Klienci.IDKlienta = Gusty_muzyczne.IDKlienta)
    INNER JOIN Style_wykonawcow Sw on Sw.IDStylu = Gusty_muzyczne.IDStylu)
         INNER JOIN Wykonawcy
                    ON Wykonawcy.IDWykonawcy = Sw.IDWykonawcy
GROUP BY Klienci.IDKlienta, Klienci.ImieKlienta, Klienci.NazwiskoKlienta, Wykonawcy.IDWykonawcy,
         Wykonawcy.NazwaScenicznaWykonawcy
HAVING COUNT(Gusty_muzyczne.IDStylu) = (SELECT COUNT(*)
                                        FROM Gusty_muzyczne
                                        WHERE Gusty_muzyczne.IDKlienta = Klienci.IDKlienta);


-- Wyświetl wszystkie Style muzyczne i pasujących do nich wykonawców.

SELECT Wykonawcy.NazwaScenicznaWykonawcy,
       Style_wykonawcow.IDStylu,
       Style_muzyczne.IDStylu,
       Style_muzyczne.NazwaStylu
FROM Wykonawcy
         RIGHT JOIN Style_wykonawcow
                    USING (IDWykonawcy)
         RIGHT JOIN Style_muzyczne
                    USING (IDStylu);


-- Style muzyczne klientów z zapytania:
-- Wyświetl klientów oraz zespoły, których style muzyczne pasują do wszystkich
-- stylów preferowanych przez klienta.

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta,
       Gm.IDStylu,
       Sm.IDStylu,
       Sm.NazwaStylu
FROM Klienci
JOIN Gusty_muzyczne Gm on Klienci.IDKlienta = Gm.IDKlienta
JOIN Style_muzyczne Sm on Gm.IDStylu = Sm.IDStylu
WHERE Klienci.IDKlienta IN (10008, 10012, 10003, 10002, 10010, 10013, 10005)

SELECT IDStylu,
       NazwaStylu
FROM Style_muzyczne;



-- Wyszukaj wszystkich klientów, którzy zamówili rower, a oprócz tego zamówili też kask.

-- INNER JOIN

SELECT DISTINCT R.IDKlienta,
       R.NazwiskoKlienta,
       R.ImieKlienta
FROM ((SELECT Klienci.IDKlienta,
              Klienci.NazwiskoKlienta,
              Klienci.ImieKlienta
       FROM ZamowieniaPrzyklad.Klienci
                INNER JOIN Zamowienia Z on Klienci.IDKlienta = Z.IDKlienta
                INNER JOIN Dane_zamowien Dz on Z.NumerZamowienia = Dz.NumerZamowienia
                INNER JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
       WHERE P.NazwaProduktu LIKE 'Rower%') AS R
         JOIN
     (SELECT Klienci.IDKlienta
      FROM ZamowieniaPrzyklad.Klienci
               INNER JOIN Zamowienia Z2 on Klienci.IDKlienta = Z2.IDKlienta
               INNER JOIN Dane_zamowien D on Z2.NumerZamowienia = D.NumerZamowienia
               INNER JOIN Produkty P2 on D.NumerProduktu = P2.NumerProduktu
      WHERE P2.NazwaProduktu LIKE 'Kask%') AS K
     ON R.IDKlienta = K.IDKlienta);


-- IN

SELECT Klienci.IDKlienta,
       Klienci.NazwiskoKlienta,
       Klienci.ImieKlienta
FROM Klienci
WHERE Klienci.IDKlienta IN
      (SELECT Zamowienia.IDKlienta
       FROM Zamowienia
                JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
                JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
       WHERE P.NazwaProduktu LIKE 'Rower%')
  AND Klienci.IDKlienta IN
      (SELECT Zamowienia.IDKlienta
       FROM Zamowienia
                JOIN Dane_zamowien D on Zamowienia.NumerZamowienia = D.NumerZamowienia
                JOIN Produkty P2 on D.NumerProduktu = P2.NumerProduktu
       WHERE P2.NazwaProduktu LIKE 'Kask%');

-- EXISTS

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
WHERE EXISTS
    (SELECT Zamowienia.IDKlienta
     FROM Zamowienia
              JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
              JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
     WHERE NazwaProduktu LIKE 'Rower%'
       AND Zamowienia.IDKlienta = Klienci.IDKlienta)
  AND EXISTS
    (SELECT Zamowienia.IDKlienta
     FROM Zamowienia
              JOIN Dane_zamowien D on Zamowienia.NumerZamowienia = D.NumerZamowienia
              JOIN Produkty P2 on D.NumerProduktu = P2.NumerProduktu
     WHERE P2.NazwaProduktu LIKE 'Kask%'
       AND Zamowienia.IDKlienta = Klienci.IDKlienta)





-- Wyszukaj wszystkich klientów, którzy nie zamówili ani rowerów, ani opon.

SELECT IDKategorii,
       OpisKategorii
FROM Kategorie;

-- OUTER LEFT JOIN (1)

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
         LEFT JOIN
     (SELECT Zamowienia.IDKlienta
      FROM Zamowienia
               INNER JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
               INNER JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
      WHERE P.IDKategorii IN (2, 6)) AS R
     ON Klienci.IDKlienta = R.IDKlienta
WHERE R.IDKlienta IS NULL;

-- NOT IN (2)

SELECT Klienci.IDKlienta,
       Klienci.NazwiskoKlienta,
       Klienci.ImieKlienta
FROM Klienci
WHERE Klienci.IDKlienta NOT IN
      (SELECT Zamowienia.IDKlienta
       FROM Zamowienia
                INNER JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
                INNER JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
       WHERE P.IDKategorii = 2)
  AND Klienci.IDKlienta NOT IN
      (SELECT Zamowienia.IDKlienta
       FROM Zamowienia
                INNER JOIN Dane_zamowien D on Zamowienia.NumerZamowienia = D.NumerZamowienia
                INNER JOIN Produkty P2 on D.NumerProduktu = P2.NumerProduktu
       WHERE P2.IDKategorii = 6);

-- (3)

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
WHERE Klienci.IDKlienta NOT IN
      (SELECT Zamowienia.IDKlienta
       FROM Zamowienia
                JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
                JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
       WHERE P.IDKategorii IN (2, 6));

-- NOT EXISTS (4)

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
WHERE NOT EXISTS(
        SELECT Zamowienia.IDKlienta
        FROM Zamowienia
                 JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
                 JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
        WHERE P.IDKategorii IN (2, 6)
          AND Klienci.IDKlienta = Zamowienia.IDKlienta
    );

-- (5)

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta
FROM Klienci
WHERE NOT EXISTS(
        SELECT Zamowienia.IDKlienta
        FROM Zamowienia
                 INNER JOIN Dane_zamowien Dz on Zamowienia.NumerZamowienia = Dz.NumerZamowienia
                 INNER JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
        WHERE P.IDKategorii = 2
          AND Klienci.IDKlienta = Zamowienia.IDKlienta
    )
  AND NOT EXISTS(
        SELECT Zamowienia.IDKlienta
        FROM Zamowienia
                 INNER JOIN Dane_zamowien D on Zamowienia.NumerZamowienia = D.NumerZamowienia
                 INNER JOIN Produkty P2 on D.NumerProduktu = P2.NumerProduktu
        WHERE P2.IDKategorii = 6
          AND Klienci.IDKlienta = Zamowienia.IDKlienta
    );



-- Wymień wykonawców, którzy występowali dla obydwu następujących klientów:
-- Berg, Hallmark

-- INNER JOIN

SELECT DISTINCT Berg.IDWykonawcy,
                Berg.NazwaScenicznaWykonawcy
FROM (SELECT Wykonawcy.IDWykonawcy,
             Wykonawcy.NazwaScenicznaWykonawcy
      FROM Wykonawcy
               INNER JOIN Imprezy I on Wykonawcy.IDWykonawcy = I.IDWykonawcy
               INNER JOIN Klienci K on I.IDKlienta = K.IDKlienta
      WHERE K.NazwiskoKlienta = 'Berg') AS Berg
         INNER JOIN
     (SELECT Wykonawcy.IDWykonawcy
      FROM Wykonawcy
               INNER JOIN Imprezy I2 on Wykonawcy.IDWykonawcy = I2.IDWykonawcy
               INNER JOIN Klienci K2 on I2.IDKlienta = K2.IDKlienta
      WHERE K2.NazwiskoKlienta = 'Hallmark') AS Hallmark
     ON Berg.IDWykonawcy = Hallmark.IDWykonawcy;

-- IN

SELECT Wykonawcy.IDWykonawcy,
       Wykonawcy.NazwaScenicznaWykonawcy
FROM Wykonawcy
WHERE Wykonawcy.IDWykonawcy IN (SELECT Imprezy.IDWykonawcy
                                FROM Imprezy
                                         JOIN Klienci K on Imprezy.IDKlienta = K.IDKlienta
                                WHERE K.NazwiskoKlienta IN ('Berg'))
  AND Wykonawcy.IDWykonawcy IN (SELECT Imprezy.IDWykonawcy
                                FROM Imprezy
                                         JOIN Klienci K2 on Imprezy.IDKlienta = K2.IDKlienta
                                WHERE K2.NazwiskoKlienta = 'Hallmark');

-- EXISTS

SELECT Wykonawcy.IDWykonawcy,
       Wykonawcy.NazwaScenicznaWykonawcy
FROM Wykonawcy
WHERE EXISTS(SELECT Imprezy.IDWykonawcy
             FROM Imprezy
                      JOIN Klienci K on Imprezy.IDKlienta = K.IDKlienta
             WHERE K.NazwiskoKlienta = 'Berg'
               AND Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy)
  AND EXISTS(SELECT Imprezy.IDWykonawcy
             FROM Imprezy
                      JOIN Klienci K2 on Imprezy.IDKlienta = K2.IDKlienta
             WHERE K2.NazwiskoKlienta = 'Hallmark'
               AND Wykonawcy.IDWykonawcy = Imprezy.IDWykonawcy);



-- Zrób zestawienie agentów, którzy nigdy nie zawarli kontraktu z wykonawcą
-- grającym country, albo country rocka.

-- LEFT OUTER JOIN

SELECT Agenci.IDAgenta,
       Agenci.ImieAgenta,
       Agenci.NazwiskoAgenta
FROM Agenci
         LEFT JOIN (SELECT Imprezy.IDAgenta
                    FROM Imprezy
                             INNER JOIN Wykonawcy W on Imprezy.IDWykonawcy = W.IDWykonawcy
                             INNER JOIN Style_wykonawcow Sw on W.IDWykonawcy = Sw.IDWykonawcy
                             INNER JOIN Style_muzyczne Sm on Sw.IDStylu = Sm.IDStylu
                    WHERE Sm.NazwaStylu IN ('country', 'country rock')) AS Country
                   ON Agenci.IDAgenta = Country.IDAgenta
WHERE Country.IDAgenta IS NULL;


-- NOT IN

SELECT Agenci.IDAgenta,
       Agenci.ImieAgenta,
       Agenci.NazwiskoAgenta
FROM Agenci
WHERE Agenci.IDAgenta NOT IN
      (SELECT Imprezy.IDAgenta
       FROM Imprezy
                INNER JOIN Wykonawcy W on Imprezy.IDWykonawcy = W.IDWykonawcy
                INNER JOIN Style_wykonawcow Sw on W.IDWykonawcy = Sw.IDWykonawcy
                INNER JOIN Style_muzyczne Sm on Sw.IDStylu = Sm.IDStylu
       WHERE Sm.NazwaStylu IN ('country', 'country rock'));

-- NOT EXISTS

SELECT Agenci.IDAgenta,
       Agenci.ImieAgenta,
       Agenci.NazwiskoAgenta
FROM Agenci
WHERE NOT EXISTS(SELECT Imprezy.IDAgenta
                 FROM Imprezy
                          JOIN Wykonawcy W on Imprezy.IDWykonawcy = W.IDWykonawcy
                          JOIN Style_wykonawcow Sw on W.IDWykonawcy = Sw.IDWykonawcy
                          JOIN Style_muzyczne Sm on Sw.IDStylu = Sm.IDStylu
                 WHERE Sm.NazwaStylu IN ('country', 'country rock')
                   AND Agenci.IDAgenta = Imprezy.IDAgenta);



/* Rozdział 19 Operacje warunkowe **********************************************************************************/


-- Przygotuj listę identyfikatorów, personaliów oraz płci studentów wyrażonej słownie.

SELECT IDStudenta,
       ImieStudenta,
       NazwiskoStudenta,
       (CASE PlecStudenta
            WHEN 'M' THEN 'Mężczyzna'
            WHEN 'K' THEN 'Kobieta'
            ELSE 'Nie okreslono' END) AS Plec
FROM Studenci;



-- Sporządź zestawienie wszystkich studentów, obejmujące ID studenta, imię, nazwisko,
-- liczbę ukończonych zajęć, łączną liczbę punktów edukacyjnych oraz średnią ocenę punktową,
-- z uwzględnieniem tych zajęć, które zostały ukończone z oceną 67 albo lepszą.

SELECT Studenci.IDStudenta,
       Studenci.ImieStudenta,
       Studenci.NazwiskoStudenta,
       COUNT(StuZaj.IDStudenta)                              AS Liczba,
       SUM(StuZaj.PunktyEdukacyjne)                          AS SumaPktEd,
       (CASE COUNT(StuZaj.IDStudenta)
            WHEN 0 THEN 0
            ELSE ROUND(SUM(StuZaj.PunktyEdukacyjne * StuZaj.Ocena) /
                       SUM(StuZaj.PunktyEdukacyjne), 3) END) AS Srednia
FROM Studenci
         LEFT OUTER JOIN (SELECT Grafik_studenta.IDStudenta,
                                 Grafik_studenta.Ocena,
                                 Zajecia.PunktyEdukacyjne
                          FROM (Grafik_studenta INNER JOIN
                              Status_zajec_studenta
                              ON Grafik_studenta.StatusZajec = Status_zajec_studenta.StatusZajec)
                                   INNER JOIN Zajecia
                                              ON Grafik_studenta.IDZajec = Zajecia.IDZajec
                          WHERE (Status_zajec_studenta.OpisStatusuZajec = 'Ukończono')
                            AND (Grafik_studenta.Ocena >= 67)) AS StuZaj
                         ON Studenci.IDStudenta = StuZaj.IDStudenta
GROUP BY Studenci.IDStudenta, Studenci.ImieStudenta, Studenci.NazwiskoStudenta;


-- Dla wszystkich pracowników podaj ID pracownika, imię, nazwisko, datę zatrudnienia
-- i czas pracy w pełnych latach, stan na 1 października 2012 roku, posortowane według nazwiska i imienia.

SELECT IDPracownika,
       ImiePracownika,
       NazwiskoPracownika,
       YEAR(CAST('2012-10-01' AS DATE)) - YEAR(DataZatrudnienia) -
       (CASE
            WHEN MONTH(DataZatrudnienia) < 10 THEN 0
            WHEN MONTH(DataZatrudnienia) > 10 THEN 1
            WHEN DAY(DataZatrudnienia) > 1 THEN 1
            ELSE 0 END) AS StazPracy
FROM Pracownicy
ORDER BY NazwiskoPracownika, ImiePracownika;

-- Utwórz listę mailingową studentów, objemującą zwrot grzecznościowy, imię, nazwisko,
-- adres, miasto, stan zamieszkania oraz kod pocztowy.

SELECT Studenci.IDStudenta,
       (CASE PlecStudenta
            WHEN 'M' THEN 'Pan'
            WHEN 'K' THEN 'Pani'
            ELSE '' END) AS FormaGrzecznosciowa,
       Studenci.ImieStudenta,
       Studenci.NazwiskoStudenta,
       Studenci.AdresStudenta,
       Studenci.MiastoStudenta,
       Studenci.KodPocztowyStudenta
FROM Studenci;

-- Zrób listę wszystkich studentów płci męskiej.

SELECT Studenci.ImieStudenta,
       Studenci.NazwiskoStudenta
FROM Studenci
WHERE PlecStudenta = 'M';


-- Sporządź listę wszystkich produktów z zaznaczeniem, czy produkt był zamawiany w grudniu 2012.

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       (CASE
            WHEN Produkty.NumerProduktu IN
                 (SELECT Dane_zamowien.NumerProduktu
                  FROM Dane_zamowien
                           INNER JOIN Zamowienia Z on Dane_zamowien.NumerZamowienia = Z.NumerZamowienia
                  WHERE Z.DataZamowienia BETWEEN
                            CAST('2012-12-01' AS DATE) AND
                            CAST('2012-12-31' AS DATE))
                THEN 'ZAMAWIANO'
            ELSE 'NIE ZAMAWIANO' END) AS ZamowionyProdukt
FROM Produkty;

-- Wyświetl produkty i określ popyt na nie w oparciu o liczbę sprzedanych sztuk:
-- mierny <= 200 sprzedanych sztuk,
-- <= 500 przeciętny > 200,
-- 500 < dobry >= 1000,
-- znakomity > 1000.

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       (CASE
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu))
                    <= 200 THEN 'Mierny'
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu
                               ))
                    <= 500 THEN 'Przeciętny'
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu))
                    <= 500 THEN 'Dobry'
            ELSE 'Znakomity' END) AS Popyt
FROM Produkty




-- Sporządź listę wszystkich produktów z zaznaczeniem, czy produkt był zamawiany w grudniu 2012.

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       (CASE
            WHEN Produkty.NumerProduktu IN
                 (SELECT Dane_zamowien.NumerProduktu
                  FROM Dane_zamowien
                           INNER JOIN Zamowienia Z on Dane_zamowien.NumerZamowienia = Z.NumerZamowienia
                  WHERE Z.DataZamowienia BETWEEN
                            CAST('2012-12-01' AS DATE) AND
                            CAST('2012-12-31' AS DATE))
                THEN 'ZAMAWIANO'
            ELSE 'NIE ZAMAWIANO' END) AS ZamowionyProdukt
FROM Produkty;

-- Wyświetl produkty i określ popyt na nie w oparciu o liczbę sprzedanych sztuk:
-- mierny <= 200 sprzedanych sztuk,
-- <= 500 przeciętny > 200,
-- 500 < dobry >= 1000,
-- znakomity > 1000.

SELECT Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       (CASE
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu))
                    <= 200 THEN 'Mierny'
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu
                               ))
                    <= 500 THEN 'Przeciętny'
            WHEN
                    (SELECT SUM(ZamowionaIlosc)
                     FROM (Dane_zamowien)
                     WHERE (Dane_zamowien.NumerProduktu = Produkty.NumerProduktu))
                    <= 500 THEN 'Dobry'
            ELSE 'Znakomity' END) AS Popyt
FROM Produkty


-- Sprawdź, ile wynosiłyby zarobki pełnoetatowych wykładowców, jeśli dałbyś 5% podwyżki
-- instruktorom, 4% adiunktom, 3.5% profesorom.

SELECT Pracownicy.IDPracownika,
       Pracownicy.ImiePracownika,
       Pracownicy.NazwiskoPracownika,
       Tytul,
       Status,
       Pracownicy.Wynagrodzenie,
       (CASE Tytul
            WHEN 'Instuktor' THEN ROUND(Wynagrodzenie * 1.05, 2)
            WHEN 'Adiunkt' THEN ROUND(Wynagrodzenie * 1.04, 2)
            WHEN 'Profesor' THEN ROUND(Wynagrodzenie * 1.035, 2)
            ELSE Wynagrodzenie END) AS NoweWynagrodzenie
FROM Pracownicy
         JOIN Wykladowcy W on Pracownicy.IDPracownika = W.IDPracownika
WHERE W.Status = 'Pełny wymiar';

-- Zrób listę wszystkich studentów, zajęć, na jakie się zapisali, otrzymanej oceny punktowej
-- oraz przelicznika tej oceny na skalę od A do F.

SELECT Studenci.IDStudenta,
       Studenci.ImieStudenta,
       Studenci.NazwiskoStudenta,
       Z.IDZajec,
       Z.DataRozpoczecia,
       P.KodPrzedmiotu,
       P.NazwaPrzedmiotu,
       Grafik_studenta.Ocena,
           (CASE
                WHEN Ocena BETWEEN 97 AND 100 THEN '5+'
                WHEN Ocena BETWEEN 93 AND 96.99 THEN '5'
                WHEN Ocena BETWEEN 90 AND 92.99 THEN '5-'
                WHEN Ocena BETWEEN 87 AND 89.99 THEN '4+'
                WHEN Ocena BETWEEN 83 AND 86.99 THEN '4'
                WHEN Ocena BETWEEN 80 AND 82.99 THEN '4-'
                WHEN Ocena BETWEEN 77 AND 79.99 THEN '3+'
                WHEN Ocena BETWEEN 73 AND 76.99 THEN '3'
                WHEN Ocena BETWEEN 70 AND 72.99 THEN '3-'
                WHEN Ocena BETWEEN 67 AND 69.99 THEN '2+'
                WHEN Ocena BETWEEN 63 AND 66.99 THEN '2'
                WHEN Ocena BETWEEN 60 AND 62.99 THEN '2-'
                ELSE '1' END) AS Ocena
FROM (((Studenci
    INNER JOIN Grafik_studenta ON Studenci.IDStudenta = Grafik_studenta.IDStudenta)
    INNER JOIN Zajecia Z ON Grafik_studenta.IDZajec = Z.IDZajec)
    INNER JOIN Przedmioty P ON Z.IDPrzedmiotu = P.IDPrzedmiotu)
         INNER JOIN Status_zajec_studenta Szs ON Grafik_studenta.StatusZajec = Szs.StatusZajec
WHERE Szs.OpisStatusuZajec = 'Ukończono';



/* Rozdział 20 Zastosowanie niepowiązanych danych i tabel sterujących ************************************************* */



SELECT Klienci.NazwiskoKlienta,
       Produkty.NazwaProduktu
FROM Klienci
         CROSS JOIN Produkty
ORDER BY Klienci.NazwiskoKlienta;

SELECT Klienci.NazwiskoKlienta,
       P.NazwaProduktu,
       Dz.ZamowionaIlosc
FROM Klienci
         JOIN Zamowienia Z on Klienci.IDKlienta = Z.IDKlienta
         JOIN Dane_zamowien Dz on Z.NumerZamowienia = Dz.NumerZamowienia
         JOIN Produkty P on Dz.NumerProduktu = P.NumerProduktu
GROUP BY Dz.ZamowionaIlosc, P.NazwaProduktu, Klienci.NazwiskoKlienta;

-- Przygotuj listę wszystkich klientów wraz z adresami oraz wszystkich produktów,
-- które znajdują się w naszej ofercie i zaznacz, które produkty dany klient kupował już wcześniej

SELECT Klienci.IDKlienta,
       Klienci.ImieKlienta,
       Klienci.NazwiskoKlienta,
       Klienci.AdresKlienta,
       Klienci.MiastoKlienta,
       Klienci.StanZamKlienta,
       Klienci.KodPocztowyKlienta,
       Kategorie.OpisKategorii,
       Produkty.NumerProduktu,
       Produkty.NazwaProduktu,
       Produkty.CenaDetaliczna,
       (CASE
            WHEN Klienci.IDKlienta IN
                 (SELECT Zamowienia.IDKlienta
                  FROM Zamowienia
                           INNER JOIN Dane_zamowien
                                      ON Zamowienia.NumerZamowienia = Dane_zamowien.NumerZamowienia
                  WHERE Dane_zamowien.NumerProduktu = Produkty.NumerProduktu)
                THEN 'Kupione'
            ELSE '' END) AS ZamowionyProdukt
FROM Klienci,
     Kategorie
         INNER JOIN Produkty
                    ON Kategorie.IDKategorii = Produkty.IDKategorii
ORDER BY Klienci.IDKlienta, Kategorie.OpisKategorii, Produkty.NumerProduktu;






