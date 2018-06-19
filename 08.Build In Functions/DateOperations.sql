


--Date operations:

-- vrushta ni segashniq godina mesec den chas minuta sekunda
SELECT GETDATE(); 

-- s DATEPART() vzimame samo chast ot dadena data, moje da e den, chas, godina, i dr
SELECT DATEPART(YEAR, GETDATE()); 



--Zadacha 1. Ot tablicata Employees ot bazata SoftUni iskame da razdelim HireDate na 
--quarter,den, godina i mesec :

USE SoftUni
SELECT TOP (1000) [EmployeeID]
      ,[HireDate]
	  ,DATEPART(QUARTER, HireDate) AS Quarter
	  ,DATEPART(YEAR, HireDate) AS Year
	  ,DATEPART(MONTH, HireDate) AS Month
	  ,DATEPART(DAY, HireDate) AS Day
FROM [SoftUni].[dbo].[Employees]

/*
DATEDIFF(Part, FirstDate, SecondDate)  Namira razlika mejdu 2 dati
*/
SELECT DATEDIFF(MONTH, '1998-01-23', '1998-07-31'); -- razlikata v meseci e 6

SELECT DATEDIFF(DAY, '1998-01-23', '1998-07-31'); -- razlikata v dni e 189

SELECT DATEDIFF(HOUR, '1998-01-23', '1998-07-31'); -- razlikata v chasove e 4536


/*
DATENAME(Part, Date)  Vadi ni imeto na chastta ot datata:
*/

SELECT DATENAME(WEEKDAY, GETDATE()); -- Vtornik
SELECT DATENAME(MONTH, GETDATE()); -- Septemvri
SELECT DATENAME(DAYOFYEAR, GETDATE()); -- 248 den ot godinata



/*
DATEADD(Part, Number, Date)  Dobavqme dadena chast kum dadena data
*/

SELECT DATEADD(MONTH, 2, GETDATE()); -- dobavqme 2 meseca kum segashnata data i q selektirame
SELECT DATEADD(YEAR, 2, GETDATE()); -- dobavqme 2 godini kum segashnata data i q selektirame


/*
VAJNO !!! : 

CAST() i CONVERT() konvertirat mejdu tipove danni
CAST(Data AS NewType)
CONVERT(NewType, Data)

--CONVERT() e po burs no nqma da raboti vurhu binarni danni
*/

SELECT CAST(2.56 AS int); -- prevrushta go v int i pokazva 2
SELECT CONVERT(int, 2.56); -- prevrushta go v int i pokazva 2


/*
ISNULL(Data, DefaultValue); ZNAEM KAKVO PRAVI, ako e NULL mu slagame defaultValue
Samoche trqbva DefaultValue-to da e ot sushtiq tip kato Data inache nqma da stane,
Mojem da castnem Data-to rimerno v string za da mojem da podadem string kato DefaultValue !!!
*/

SELECT 
FirstName,
ISNULL(MiddleName, 'Nqma Sredno Ime !!!'),
LastName
FROM Employees



/*
OFFSET i FETCH  Rabotqt kato TOP(), ogranichavat ni rezultata pri selektiraneto.
S tqh mojemd a kazvame primerno : Selektirai mi samo 5 samoche ne pochvai ot purviq a ot 21-viq !!!

Vajno e da znaem che se kombinira s ORDER BY
*/

SELECT 
EmployeeId,
FirstName,
LastName
FROM Employees
ORDER BY EmployeeId
OFFSET 10 ROWS     
FETCH NEXT 5 ROWS ONLY

--S OFFSET 10 ROWS mu kazvame da propusne purvite 10 reda
--S FETCH NEXT 5 ROWS ONLY mu kazvame da zvane samo sledvashtite 5 reda

--Ne rabotqs bez OR





