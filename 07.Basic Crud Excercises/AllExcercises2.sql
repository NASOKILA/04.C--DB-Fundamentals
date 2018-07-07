
SELECT * FROM Departments

SELECT Name FROM Departments


SELECT FirstName, LastName, Salary FROM Employees

SELECT FirstName, MiddleName, LastName FROM Employees

	SELECT 
		FirstName + '.' + LastName + '@softuni.bg' AS [Full Email Address] 
	FROM Employees

SELECT DISTINCT Salary FROM Employees

SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative';

SELECT 
	FirstName, LastName, JobTitle
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

SELECT 
	FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)

SELECT FirstName, LastName FROM Employees AS e
WHERE ManagerID IS NULL;


SELECT 
	FirstName, LastName, Salary 
FROM Employees AS e
WHERE Salary > 50000
ORDER BY Salary DESC


SELECT TOP (5)
	e.FirstName, e.LastName
FROM Employees AS e
ORDER BY Salary DESC


SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE DepartmentID != 4;


SELECT * FROM Employees AS e
ORDER BY e.Salary DESC, e.FirstName, e.LastName DESC, e.MiddleName 


CREATE VIEW V_EmployeesSalaries
AS
SELECT e.FirstName, e.LastName, e.Salary FROM Employees AS e


CREATE VIEW V_EmployeeNameJobTitle 
AS
SELECT
	CASE
		WHEN(MiddleName IS NULL)
		THEN(FirstName + ' ' + '' + ' ' + LastName)
		ELSE (FirstName + ' ' + MiddleName + ' ' + LastName)
	END AS [Full Name],
	JobTitle AS [Job Title]
FROM Employees

SELECT DISTINCT JobTitle FROM Employees

SELECT TOP (10)
	*
FROM Projects AS p
ORDER BY p.StartDate, p.Name

SELECT TOP (7)
	e.FirstName, e.LastName, e.HireDate
FROM Employees AS e
ORDER BY e.HireDate DESC


UPDATE Employees
SET Salary = (Salary * 1.12)
WHERE DepartmentID IN 
('Engineering', 'Tool Design', 'Marketing','Information Services')

SELECT Salary From Employees

use master
RESTORE DATABASE SoftUni
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\SoftUni.bak';

SELECT 
	PeakName 
FROM Peaks AS p
ORDER BY PeakName ASC

SELECT TOP (30)
	CountryName, [Population]
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName ASC

SELECT 
	CountryName, CountryCode,
	CASE
		WHEN (CurrencyCode = 'EUR')
		THEN 'Euro'
		ELSE 'Not Euro' 
	END AS Currency
FROM Countries
ORDER BY CountryName ASC

select * from Countries


SELECT Name FROM Characters
ORDER BY Name ASC
