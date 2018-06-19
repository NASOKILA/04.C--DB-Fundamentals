




--2.Find All Information About Departments
--USE SoftUni
SELECT * FROM Departments


--3.Find all Department Names
SELECT Name FROM Departments


--4.Find Salary of Each Employee
SELECT FirstName, LastName, Salary FROM Employees


--5. Find Full Name of Each Employee
SELECT FirstName, MiddleName, LastName FROM Employees


--6. Find Email Address of Each Employee
	SELECT 
		FirstName + '.' + LastName + '@softuni.bg' AS [Full Email Address] 
	FROM Employees


--7. Find All Different Employee’s Salaries
SELECT DISTINCT Salary FROM Employees


--8. Find all Information About Employees
SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative';


--9. Find Names of All Employees by Salary in Range
SELECT 
	FirstName, LastName, JobTitle
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000


--10. Find Names of All Employees
SELECT 
	FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)


--11. Find All Employees Without Manager
SELECT FirstName, LastName FROM Employees AS e
WHERE ManagerID IS NULL;


--12. Find All Employees with Salary More Than
SELECT 
	FirstName, LastName, Salary 
FROM Employees AS e
WHERE Salary > 50000
ORDER BY Salary DESC


--13. Find 5 Best Paid Employees
SELECT TOP (5)
	e.FirstName, e.LastName
FROM Employees AS e
ORDER BY Salary DESC


--14. Find All Employees Except Marketing
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE DepartmentID != 4;


--15. Sort Employees Table
SELECT * FROM Employees AS e
ORDER BY e.Salary DESC, e.FirstName, e.LastName DESC, e.MiddleName 


--16. Create View Employees with Salaries
CREATE VIEW V_EmployeesSalaries
AS
SELECT e.FirstName, e.LastName, e.Salary FROM Employees AS e


--17. Create View Employees with Job Titles
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

--SELECT * FROM V_EmployeeNameJobTitle

--18. Distinct Job Titles
SELECT DISTINCT JobTitle FROM Employees


--19. Find First 10 Started Projects
SELECT TOP (10)
	*
FROM Projects AS p
ORDER BY p.StartDate, p.Name



--20. Last 7 Hired Employees
SELECT TOP (7)
	e.FirstName, e.LastName, e.HireDate
FROM Employees AS e
ORDER BY e.HireDate DESC


--21. Increase Salaries
UPDATE Employees
SET Salary = (Salary * 1.12)
WHERE DepartmentID IN 
('Engineering', 'Tool Design', 'Marketing','Information Services')

SELECT Salary From Employees


use master
RESTORE DATABASE SoftUni
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\SoftUni.bak';


--22. All Mountain Peaks
--use Geography
SELECT 
	PeakName 
FROM Peaks AS p
ORDER BY PeakName ASC


--23. Biggest Countries by Population
SELECT TOP (30)
	CountryName, [Population]
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName ASC


--24. Countries and Currency (Euro / Not Euro)
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



--25. All Diablo Characters
--USE Diablo
SELECT Name FROM Characters
ORDER BY Name ASC









