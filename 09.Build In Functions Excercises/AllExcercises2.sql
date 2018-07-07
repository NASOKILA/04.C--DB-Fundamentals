
SELECT 
	FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'SA%'


SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE LastName LIKE '%ei%'


SELECT 
	e.FirstName
FROM Employees AS e
WHERE (DepartmentId = 3 OR DepartmentId = 10)
AND DATEPART(year,HireDate) BETWEEN 1995 AND 2005


SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE e.JobTitle NOT LIKE '%engineer%'


SELECT 
	t.Name
FROM Towns AS t
WHERE LEN(t.Name) = 5 OR LEN(t.Name) = 6
ORDER BY t.Name;


SELECT 
	*
	FROM Towns AS t
	WHERE t.Name LIKE 'M%' OR t.Name LIKE 'K%' OR
	t.Name LIKE 'B%' OR t.Name LIKE 'E%'
	ORDER BY t.Name;


SELECT * FROM Towns AS t
WHERE t.Name NOT LIKE 'R%' AND t.Name NOT LIKE 'B%'
AND t.Name NOT LIKE 'D%'
ORDER BY t.Name;

GO
CREATE VIEW v_EmployeesHiredAfter2000
AS
SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE DATEPART(year,HireDate) > '2000'


SELECT 
	e.FirstName, e.LastName
FROM Employees AS e
WHERE LEN(LastName) = 5;


SELECT 
	c.CountryName, c.IsoCode
FROM Countries AS c
WHERE c.CountryName LIKE '%A%A%A%'
ORDER BY c.IsoCode;

SELECT
	p.PeakName,
	r.RiverName,
	LOWER(LEFT(p.PeakName, (LEN(p.PeakName) - 1)) + r.RiverName) AS Mix
FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName, 1)
ORDER BY Mix;


SELECT TOP (50)
	Name, 
	FORMAT(Start, 'yyyy-MM-dd') AS Start
FROM Games 
WHERE DATEPART(YEAR ,Start) = 2011 OR DATEPART(YEAR ,Start) = 2012
ORDER bY Start, Name;


USE Diablo

SELECT 
	Username, 
	SUBSTRING(u.Email, CHARINDEX('@', u.Email)+1, LEN(u.Email)) AS [Email Provider]
FROM Users AS u
ORDER BY (SUBSTRING(u.Email, CHARINDEX('@', u.Email)+1, LEN(u.Email))), u.Username


SELECT 
	u.Username, u.IpAddress 
FROM Users AS u
WHERE u.IpAddress LIKE '___.1%.%.___'
ORDER BY u.Username;

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

SELECT 
	o.ProductName,
	o.OrderDate, 
	DATEADD(day, 3, o.OrderDate) AS [Pay Due],
	DATEADD(MONTH, 1, o.OrderDate) AS [Delivery Due]
FROM Orders AS o

SELECT 
	Name,
	DATEDIFF(YEAR , Birthdate, GETDATE()) AS [Age in Years],
	DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
FROM People