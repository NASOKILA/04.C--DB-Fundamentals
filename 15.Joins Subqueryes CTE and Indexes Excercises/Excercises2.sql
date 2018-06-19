



--Excercises:

--01. Employee Address

 SELECT TOP 5
			e.EmployeeID,
			e.JobTitle,
			e.AddressId,
			a.AddressText
	   FROM Employees AS e
	   JOIN Addresses AS a
		 ON e.AddressID = a.AddressID
   ORDER BY e.AddressID 


--04. Employee Departments
SELECT TOP 5 
		   e.EmployeeID,
		   e.FirstName,
		   e.Salary,
		   d.Name AS DepartmentName
	  FROM Employees AS e
INNER JOIN Departments AS d
		ON e.DepartmentID = d.DepartmentID
  	 WHERE e.Salary > 1500
  ORDER BY e.DepartmentID ASC;


--05. Employees Without Projects

SELECT TOP 3 
		   e.EmployeeID,
	   	   e.FirstName 
	  FROM Employees AS e
	 WHERE e.EmployeeID NOT IN ( select EmployeeID 
                               from EmployeesProjects
						   Group by EmployeeID ) 
  ORDER BY e.EmployeeID;


--07
SELECT TOP 5
		   e.EmployeeID,
	   	   e.FirstName,
		   p.Name AS ProjectName 
	  FROM Employees AS e
	  JOIN EmployeesProjects AS ep 
	    ON ep.EmployeeID = e.EmployeeID
	  JOIN Projects AS p
	    ON ep.ProjectID = p.ProjectID
	 WHERE p.StartDate > CAST('2002-08-13 00:00:00' AS Date) 
	   AND p.EndDate IS NULL
	 ORDER BY e.EmployeeID;



--08. Employee 24
	
	SELECT e.EmployeeID,
	   	   e.FirstName,
      CASE
      WHEN (p.StartDate > '01-01-2005')
      THEN NULL
      ELSE p.Name 
    END AS ProjectName  
	  FROM Employees AS e
	  JOIN EmployeesProjects AS ep 
	    ON ep.EmployeeID = e.EmployeeID
	  JOIN Projects AS p
	    ON ep.ProjectID = p.ProjectID
		WHERE e.EmployeeID = 24;


--09. Employee Manager

	SELECT e.EmployeeID,
		   e.FirstName,
		   e.ManagerID,
		   m.FirstName AS ManagerName	
	  FROM Employees AS e
	  JOIN Employees AS m
		ON m.EmployeeID = e.ManagerID
	 WHERE e.ManagerID IN (3, 7)
  ORDER BY e.EmployeeID;




--11. Min Average Salary

	 SELECT 
		MIN (AverageSalary) AS MinAverageSalary
	   FROM (SELECT 
				AVG (e.Salary) AS AverageSalary
			   FROM Employees AS e
		   GROUP BY DepartmentID) AS DepartmentAverageSalaries

	


--12. Highest Peaks in Bulgaria

Use Geography;

	  SELECT c.CountryCode,
			 m.MountainRange,
			 p.PeakName,
			 p.Elevation
		FROM Countries AS c
		JOIN MountainsCountries AS mc
		  ON mc.CountryCode = c.CountryCode
		JOIN Mountains AS m
		  ON mc.MountainId = m.Id
		JOIN Peaks AS p
	   	  ON p.MountainId = m.Id
	   WHERE p.Elevation > 2835 
	     AND c.CountryCode = 
							  (SELECT CountryCode 
							     FROM Countries
							    WHERE CountryName = 'Bulgaria')
	ORDER BY p.Elevation DESC



--13. Count Mountain Ranges

	SELECT c.CountryCode,
		   COUNT(m.MountainRange) AS MountainRanges
	  FROM Countries AS c
	  JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	  JOIN Mountains AS m
		ON m.Id = mc.MountainId
	WHERE c.CountryName IN (SELECT CountryName 
							 FROM Countries
							WHERE CountryName 
							   IN ('United States', 'Russia', 'Bulgaria'))
	GROUP BY c.CountryCode 


	

--14. Countries And Rivers

SELECT TOP 5 
		   c.CountryName,
		   r.RiverName 
	  FROM Countries AS c
	  LEFT JOIN CountriesRivers AS cr
	    ON cr.CountryCode = c.CountryCode
	  LEFT JOIN Rivers AS r
		ON cr.RiverId = r.Id 
	 WHERE c.ContinentCode = (SELECT ContinentCode
								FROM Continents
							   WHERE ContinentName = 'Africa')
  ORDER BY c.CountryName ASC;




--15. *Continents and Currencies

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




--16. Countries Without any Mountains


	SELECT COUNT(*) AS CountryCode FROM
	(SELECT c.CountryCode 
	   FROM Countries AS c
  LEFT JOIN MountainsCountries AS mc
		 ON mc.CountryCode = c.CountryCode
  LEFT JOIN Mountains AS m
		 ON m.Id = mc.MountainId
		 WHERE m.MountainRange IS NULL) AS Subquery
	


--17. Highest Peak and Longest River by Country
	
SELECT TOP 5
		   c.CountryName,
		   MAX(p.Elevation) AS HighestPeakElevation,
		   MAX(r.Length) AS LongestRiverLength
	  FROM Countries AS c
 LEFT JOIN MountainsCountries AS mc
	    ON mc.CountryCode = c.CountryCode
 LEFT JOIN Mountains AS m
		ON m.Id = mc.MountainId
 LEFT JOIN Peaks AS p
		ON p.MountainId = m.Id
 LEFT JOIN CountriesRivers AS cr
	    ON cr.CountryCode = c.CountryCode
 LEFT JOIN Rivers AS r
	    ON cr.RiverId = r.Id	
  GROUP BY c.CountryName
  ORDER BY MAX(p.Elevation) DESC
 


--18. *Highest Peak Name and Elevation by Country


SELECT TOP 5
	   CountryName, 
  CASE 
	WHEN PeakName IS NULL THEN '(no highest peak)'
	ELSE PeakName
  END AS [Highest Peak Name], 
  CASE 
	WHEN Elevation IS NULL THEN 0
	ELSE Elevation
  END AS [Highest Peak Elevation], 
  CASE 
	WHEN MountainRange IS NULL THEN '(no mountain)'
	ELSE MountainRange
  END
	FROM (SELECT CountryName, PeakName, Elevation, MountainRange,
		   DENSE_RANK() OVER(PARTITION BY CountryName ORDER BY Elevation DESC) AS [Rank] 
	FROM 
		(SELECT 
			  c.CountryName,
			  p.PeakName,
			  p.Elevation,
			  m.MountainRange
		 FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
		   ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m
		   ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p
		   ON p.MountainId = m.Id
		   )AS AllPeaks) AS Table1
WHERE [Rank] = 1
ORDER BY CountryName, [Highest Peak Name];




























