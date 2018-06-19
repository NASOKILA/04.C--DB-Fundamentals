
/*
	Funkcii v SQL Server

	Ime stringovi, matematicheski, takiva s dati i drugi funkcii

	Funkciqta vrushta rezultat a procedurata ne, tq prosto izvurshva dadeno deistvie

	CONCAT zamenq nulevite stoinosti s prazen string
	REPLICATE('SINVOL', Count) replikira dadeno neshto count puti
	SUBSTRING(String, StringIndex, Length) vadi parche ot po golqm string

	v SQL indexite zapochvat ot 1

	REPLACE(String, Pattern, Replacement) zamestva edin string s drug
	
	LTRIM(String) i RTRIM(String) premahvat praznite mesta ot lqvo i ot dqsno na daden string
	LEN(String) Broi kolko sinvoli ima daden string
	DATALENGTH(String) broi kolko baita sme polzvali za da napravim tozi string

	LEFT(String, Length) vzimame lqvata strana na daden string do Length
	RIGHT(String, Length) vzimame dqsnata strana na daden string do Length

*/

--zd 1. POKAZVAME PURVITE 6 cifri ot kartata i drugite gi zamestvame s '*'
SELECT 
CustomerID, 
FirstName, 
LastName, 
LEFT(PaymentNumber, 6) + REPLICATE('*', LEN(PaymentNumber) - 6)
AS PaymentNumber
FROM Customers;
--Vzimame purvite 6 nomera, posle replikirame '*' tolkova puti kolkoto e duljinata na 
-- PaymentNumber minus 6


--s UPPER() i LOWER() pravim dannite v kolonite da sa s glavni ili s malki bukvi
SELECT 
Name,
Quantity,
UPPER(BoxCapacity),
PalletCapacity
FROM Products

/* 
Ot chinook database saita mojem da si svalim bazi s koito da praktikuvame.
*/

--REVERSE(String) Obrushta stringa na obratni
SELECT TOP(1) REVERSE(Name) FROM Products

/*

s CHARINDEX(Pattern, String, [StartIndex]) namirame daden string v text 
Ako propusnem [StartIndex] zapochva da broi ot 1

STUFF(String, StartIndex, Length, Substring) slaga substring v dadena poziciq
*/

SELECT TOP(5) 
STUFF(Name, 1, 0, 'Naso '),  
Quantity, 
BoxCapacity
FROM Products
-- Posochvame na koi string shte rabotim, ot kude da pochnem, kolko sinvola da iztriem,
-- nie sme napisali 0, i nakraq pishem substringa koito iskame da dobavim.



-- Dobavqme zvezdichki otzad dokato ne stignem 10 sinvola
SELECT LEFT('Pesho'+ '**********', 10);

--Probvame ot dqsno 
SELECT RIGHT('0000000' + '123', 10);

--MOJEM I DA GO KASTNEM S CAST(): CAST(123 AS varchar)
SELECT RIGHT('0000000' + CAST(123 AS varchar), 10);

--Mojem da polzvame FORMAT() za dopulvane na cifri v dadeno chislo:
SELECT FORMAT(22, 'd10');


SELECT Id
      ,Name
      ,Quantity
  FROM Products
  WHERE LEFT(Name, 2) = 'Pe'
  --Selektirame tezi na koito purvite 2 bukvi sa 'Pe'






