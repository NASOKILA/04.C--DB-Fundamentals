
--1.
SELECT 
	FirstName,
	LastName
FROM Employees
WHERE FirstName LIKE('SA%');

--2.
SELECT 
	FirstName,
	LastName
FROM Employees
WHERE LastName LIKE('%ei%');

--3.
SELECT 
	FirstName
FROM Employees
WHERE DepartmentID IN (3, 10) AND
DATEPART(Year,HireDate) IN (1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005);

--4.
SELECT 
	FirstName,
	LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%';

--5.
SELECT 
Name
FROM Towns
WHERE LEN(Name) = 5 OR LEN(Name) = 6
ORDER BY Name;

--6.
SELECT
TownID, 
Name
FROM Towns
WHERE Name LIKE ('[M,K,B,E]%')
ORDER BY Name;

--7.
SELECT
TownID, 
Name
FROM Towns
WHERE Name NOT LIKE ('[R,B,D]%')
ORDER BY Name;

--8.
CREATE VIEW V_EmployeesHiredAfter2000
AS SELECT FirstName, LastName
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000

--9.
SELECT 
FirstName, 
LastName
FROM Employees
WHERE LEN(LastName) = 5;

--10.
SELECT 
CountryName, 
IsoCode
FROM Countries
WHERE CountryName LIKE ('%A%A%A%')
ORDER BY ISOCode;

--11.
SELECT
PeakName,
RiverName,
LOWER(CONCAT(PeakName, RIGHT(RiverName, LEN(RiverName) - 1))) AS Mix 
FROM Peaks, Rivers
WHERE RIGHT(PeakName,1) = LEFT(RiverName,1)
ORDER BY Mix

--12.
SELECT TOP (50)
Name, 
FORMAT(Start, 'yyyy-MM-dd')
FROM Games
WHERE DATEPART(YEAR, Start) = 2011 
OR DATEPART(YEAR, Start) = 2012
ORDER BY Start;

--13.
SELECT
Username,
SUBSTRING(Email, CHARINDEX('@', Email)+1, (LEN(Email) + 1) - CHARINDEX('@', Email)) AS 'Email Provider'
FROM Users
ORDER BY 'Email Provider', Username;

--14.
SELECT
Username,
IpAddress AS 'IP Address'
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username;

--15.
SELECT 
Name,
CASE
  WHEN ((DATEPART(HOUR, Start) >= 0) AND (DATEPART(HOUR, Start) < 12))
    THEN 'Morning'
  WHEN ((DATEPART(HOUR, Start) >= 12) AND (DATEPART(HOUR, Start) < 18))
	THEN 'Afternoon'
  WHEN ((DATEPART(HOUR, Start) >= 18) AND (DATEPART(HOUR, Start) < 24))
    THEN 'Evening'
END AS 'Part of the day',

CASE
	WHEN Duration <= 3  
		THEN 'Extra Short'
	WHEN Duration >= 4 AND Duration <= 6
		THEN 'Short'
	WHEN Duration > 6
		THEN 'Long'
	WHEN Duration IS NULL
		THEN 'Extra Long'
END AS Duration
FROM Games
ORDER BY Name, Duration, [Part of the day]

--16.
SELECT
ProductName, 
OrderDate,
DATEADD(DAY, 3, OrderDate) AS 'Pay Due',
DATEADD(MONTH, 1, OrderDate) AS 'Delivery Due' 
FROM Orders

--17.
CREATE TABLE People
(
Id INT PRIMARY KEY IDENTITY,
Name varchar(50),
Birthdate DATETIME
)

SELECT 
Name,
DATEDIFF(YEAR, Birthdate, GETDATE()) AS 'Age in Years',
DATEDIFF(MONTH, Birthdate, GETDATE()) AS 'Age in Months',
DATEDIFF(DAY, Birthdate, GETDATE()) AS 'Age in Days',
DATEDIFF(MINUTE, Birthdate, GETDATE()) AS 'Age in Minutes'
FROM People
