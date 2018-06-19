



--01. Employee Address

SELECT top(5)
e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
Order by e.AddressID




--02. Addresses with Towns

SELECT top (50)
	FirstName, 
	LastName,
	t.Name AS [Town],
	a.AddressText AS [AddressText]
from Employees AS e
	JOIN Addresses AS a
	ON e.AddressID = a.AddressID
	JOIN Towns AS t
	ON a.TownID = t.TownID
ORDER BY FirstName, LastName;




--03. Sales Employees

SELECT 
	EmployeeID, 
	FirstName, 
	LastName,
	d.Name 
FROM Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE(d.Name = 'Sales');




--04. Employee Departments

	SELECT TOP (5) 
		e.EmployeeID,
		e.FirstName,
		e.Salary,
		d.Name
	FROM Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY d.DepartmentID;




--05. Employees Without Projects

	select top (3) 
			   t1.EmployeeID, 
			   t1.EmployeeWithNoProject AS FirstName 
		  from (select e.EmployeeID,
				  CASE
				  WHEN (e.EmployeeID NOT IN (select distinct EmployeeID from EmployeesProjects))
				  THEN (e.FirstName) 
				  ELSE 'Has Project'
				END AS EmployeeWithNoProject
		  FROM Employees AS e) AS t1
		 WHERE t1.EmployeeWithNoProject <> 'Has Project'
	  ORDER BY t1.EmployeeID

	/*
		Vzeh vsichki prisustvashti IDta ot EmployeesProjects tablicaca s edno malko query.
		Posle selektiram ot Employees i kazvam v edin CASE END ako tekushtiq rabotnik
		ne e v tova query KOETO SEGA STAVA NA SUBQUERY, da izpishe 'Has Project', 
		zashtoto tova znachi che tozi rabotnik ima proekt,
		inache pishem imeto na rabotnika I CQLOTO TOVA NESHTO VLIZA E EDNO QUERY KOETO 
		SEGA STAVA SUBQUERY S IME t1.
		I posledno ot t1 vzimame top (3) t1.EmployeeID, t1.EmployeeWithNoProject KUDETO
		t1.EmployeeWithNoProject != 'Has Project' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	*/




--06. Employees Hired After

SELECT
	e.FirstName,
	e.LastName,
	e.HireDate,
	d.Name
FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '1991-01-01 00:00:00'
AND (d.Name = 'Sales' OR d.Name = 'Finance')
ORDER BY e.HireDate



--07. Employees With Project

SELECT TOP (5)
	e.EmployeeID, 
	e.FirstName, 
	p.Name	
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE (p.EndDate IS NULL AND p.StartDate > CAST('2002-08-13 00:00:00' AS Date))
ORDER BY EmployeeID




--08. Employee 24
--Vmesto da kastvam i da polzvam DATEPART() moga prosto da napisha < '2005-01-01'
SELECT 
	e.EmployeeID, 
	e.FirstName,	
CASE
	WHEN (DATEPART(YEAR, CAST(p.StartDate AS varchar(MAX))) < 2005)
	THEN p.Name	
	ELSE NULL
END AS ProjectName
FROM Employees AS e
	JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p
	ON ep.ProjectID = p.ProjectID
WHERE (e.EmployeeID = 24)



--09. Employee Manager

SELECT
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	m.FirstName AS ManagerName
FROM Employees AS e
JOIN Employees AS m
ON m.EmployeeID = e.ManagerID
WHERE m.EmployeeID = 3 OR m.EmployeeID = 7
ORDER BY e.EmployeeID




--10. Employees Summary

SELECT TOP (50)
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS EmployeeName,
	m.FirstName + ' ' + m.LastName AS ManagerName,
	d.Name AS DepartmentName
FROM Employees AS e
JOIN Employees AS m
ON m.EmployeeID = e.ManagerID
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
ORDER BY EmployeeID




--11. Min Average Salary

--find the lowest average slary for each deprtment
--find the lowest of all of them

select 
	MIN(t1.AVGSalaryPerDepartment) AS MinAverageSalary
	from 
(
SELECT 
	AVG(Salary) AS AVGSalaryPerDepartment
FROM Employees
Group by DepartmentID
) AS t1




--12. Highest Peaks in Bulgaria

--Use Geography

--Realno nie mojem da si spestim JOIN-a na Mountains i direktno
--s MountainId da se svurje kum Peaks MountainId

select 
	c.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
from Countries AS c
	JOIN MountainsCountries AS mc
	ON mc.CountryCode = c.CountryCode
	JOIN Mountains AS m
	ON mc.MountainId = m.Id
	JOIN Peaks AS p
	ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC;




--13. Count Mountain Ranges

SELECT 
	c.CountryCode,
	COUNT(m.MountainRange) AS MountainRanges
FROM Countries AS c
JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
JOIN Mountains AS m
ON mc.MountainId = m.Id
GROUP BY c.CountryCode
HAVING c.CountryCode = 'BG' OR c.CountryCode = 'RU' OR c.CountryCode = 'US'




--14. Countries With or Without Rivers

select top 5
		c.CountryName,
		r.RiverName
	from Countries as c
		LEFT JOIN CountriesRivers AS cr
		ON c.CountryCode = cr.CountryCode
		LEFT JOIN Rivers AS r
		ON r.Id = cr.RiverId
	WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName;



--15.*Continents and Currencies

--Find all continents and their most used currency

--1. find most used currency for one Continent

	

	select 
		usages.ContinentCode, 
		usages.CurrencyCode, 
		usages.Usage AS CurrencyUsage 
	from
	(
		select 
		c.ContinentCode, c.CurrencyCode, COUnt(*) AS Usage
		from Countries AS c
		group by c.ContinentCode, c.CurrencyCode
		having count(*) > 1
	) AS usages
	JOIN 
	(
		select Usages.ContinentCode, MAX(Usages.Usage) AS maxUsed from
		(
			select 
			c.ContinentCode, c.CurrencyCode, COUnt(*) AS Usage
			from Countries AS c
			group by c.ContinentCode, c.CurrencyCode
		) AS usages 
		GROUP BY Usages.ContinentCode
	) AS maxUsages
	ON  usages.ContinentCode = maxUsages.ContinentCode 
	AND usages.Usage = maxUsages.maxUsed
	ORDER BY usages.ContinentCode;

	--NAPRAVIHME DVE ZAQVKI I GI JOINAHME za da selektirme tova koeto ni trqbva

	--VTOROTO RESHENIE e S DENSE_RANK() koeto sortira po counta na 
	--valutite kato dobavim partition continenCode


--16.Countries without any Mountains

select (COUNT (*) -
	(
		select 
			COUNT(DISTINCT mc.CountryCode) AS AllCountriesWithMountains
		FROM Countries AS c
		JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	)) AS CountryCode
from Countries AS cc
--vzeh broq na tezi durjavi koito imat planini i izvadih tova chislo ot broq na vsichki durjavi !!!!!!




--17. Highest Peak and Longest River by Country

select top 5
	c.CountryName,
	MAX(p.Elevation) AS HiestPeakElevation,
	MAX(r.Length) AS LongestRiverLength 
from Countries AS c
	LEFT JOIN MountainsCountries AS mc
	ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m
	ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p
	ON p.MountainId = m.Id
	LEFT JOIN CountriesRivers AS cr
	ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r
	ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HiestPeakElevation DESC, LongestRiverLength DESC, c.CountryName

--Mountains JOINa mojme i da go mahnem
--STAVA I NAVSQKUDE S FULL JOIN 

