


--01. Find Names of All Employees by First Name
--use SoftUni
SELECT 
	FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'SA%'



--02. Find Names of All Employees by Last Name
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE LastName LIKE '%ei%'



--03. Find First Names of All Employess
SELECT 
	e.FirstName
FROM Employees AS e
WHERE (DepartmentId = 3 OR DepartmentId = 10)
AND DATEPART(year,HireDate) BETWEEN 1995 AND 2005



--04. Find All Employees Except Engineers
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE e.JobTitle NOT LIKE '%engineer%'



--05. Find Towns with Name Length
SELECT 
	t.Name
FROM Towns AS t
WHERE LEN(t.Name) = 5 OR LEN(t.Name) = 6
ORDER BY t.Name;



--06. Find Towns Starting With
	SELECT 
	*
	FROM Towns AS t
	WHERE t.Name LIKE 'M%' OR t.Name LIKE 'K%' OR
	t.Name LIKE 'B%' OR t.Name LIKE 'E%'
	ORDER BY t.Name;


--07. Find Towns Not Starting With
SELECT * FROM Towns AS t
WHERE t.Name NOT LIKE 'R%' AND t.Name NOT LIKE 'B%'
AND t.Name NOT LIKE 'D%'
ORDER BY t.Name;
--Moje i taka  ...Name LIKE '[^RDB]%'  ...
-- sus '[RDB]%' hte seektira vsichki.

--08. Create View Employees Hired After
GO
CREATE VIEW v_EmployeesHiredAfter2000
AS
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE DATEPART(year,HireDate) > '2000'



--09. Length of Last Name
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE LEN(LastName) = 5;



--10. Countries Holding 'A'
SELECT 
	c.CountryName, c.IsoCode
FROM Countries AS c
WHERE c.CountryName LIKE '%A%A%A%'
ORDER BY c.IsoCode;




--11. Mix of Peak and River Names
SELECT
	p.PeakName,
	r.RiverName,
	LOWER(LEFT(p.PeakName, (LEN(p.PeakName) - 1)) + r.RiverName) AS Mix
FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName, 1)
ORDER BY Mix;


--12. Games From 2011 and 2012 Year
--USE Diablo;

SELECT TOP (50)
	Name, 
	FORMAT(Start, 'yyyy-MM-dd') AS Start
FROM Games 
WHERE DATEPART(YEAR ,Start) = 2011 OR DATEPART(YEAR ,Start) = 2012
ORDER bY Start, Name;



--13. User Email Providers
USE Diablo

SELECT 
	Username, 
	SUBSTRING(u.Email, CHARINDEX('@', u.Email)+1, LEN(u.Email)) AS [Email Provider]
FROM Users AS u
ORDER BY (SUBSTRING(u.Email, CHARINDEX('@', u.Email)+1, LEN(u.Email))), u.Username



--14. Get Users with IPAddress Like Pattern

SELECT 
	u.Username, u.IpAddress 
FROM Users AS u
WHERE u.IpAddress LIKE '___.1%.%.___'
ORDER BY u.Username;



--15. Show All Games with Duration
SELECT 
	g.Name AS Game,
	CASE 
		WHEN (DATEPART(HOUR, g.Start) >= 0 AND DATEPART(HOUR, g.Start) < 12)
		THEN 'Morning'
		WHEN (DATEPART(HOUR, g.Start) >= 12 AND DATEPART(HOUR, g.Start) < 18)
		THEN 'Afternoon'
		WHEN (DATEPART(HOUR, g.Start) >= 18 AND DATEPART(HOUR, g.Start) < 24)
		THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN g.Duration >= 0 AND g.Duration <= 3
		THEN 'Extra Short'
		WHEN g.Duration >= 4 AND g.Duration <= 6
		THEN 'Short'
		WHEN g.Duration > 6
		THEN 'Long'
		WHEN g.Duration IS NULL
		THEN 'Extra Long'
	END AS [Duration]
FROM Games AS g
ORDER BY 
g.Name, 
	CASE
		WHEN g.Duration >= 0 AND g.Duration <= 3
		THEN 'Extra Short'
		WHEN g.Duration >= 4 AND g.Duration <= 6
		THEN 'Short'
		WHEN g.Duration > 6
		THEN 'Long'
		WHEN g.Duration IS NULL
		THEN 'Extra Long'
	END, 
	CASE 
		WHEN (DATEPART(HOUR, g.Start) >= 0 AND DATEPART(HOUR, g.Start) < 12)
		THEN 'Morning'
		WHEN (DATEPART(HOUR, g.Start) >= 12 AND DATEPART(HOUR, g.Start) < 18)
		THEN 'Afternoon'
		WHEN (DATEPART(HOUR, g.Start) >= 18 AND DATEPART(HOUR, g.Start) < 24)
		THEN 'Evening'
	END 




--16. Orders Table
--Use Orders;

SELECT 
	o.ProductName,
	o.OrderDate, 
	DATEADD(day, 3, o.OrderDate) AS [Pay Due],
	DATEADD(MONTH, 1, o.OrderDate) AS [Delivery Due]
FROM Orders AS o


--17.People Table

SELECT 
	Name,
	DATEDIFF(YEAR , Birthdate, GETDATE()) AS [Age in Years],
	DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
FROM People





