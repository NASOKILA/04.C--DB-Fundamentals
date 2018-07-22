use SoftUni

select 
	e.FirstName + ' ' + e.LastName AS FullName, 
	d.Name AS DepartmentName
from Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID;

select 
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS FullName1, 
	e2.EmployeeID,
	e2.FirstName + ' ' + e2.LastName AS FullName2 
from Employees AS e
CROSS JOIN Employees AS e2
WHERE e.EmployeeID > e2.EmployeeID; 

--Addresses with Towns
USE SoftUni;

SELECT TOP 50
		   e.FirstName, 
		   e.LastName, 
		   t.Name AS Town, 
		   a.AddressText
	  FROM Employees AS e
	  JOIN Addresses AS a
		ON a.AddressID = e.AddressID
	  JOIN Towns AS t
		ON t.TownID = a.TownID
  ORDER BY e.FirstName, e.LastName;
  
  --Find all employees in the saled department
  SELECT e.EmployeeID,
  		 e.FirstName,
  		 e.LastName,
  		 d.Name
    FROM Employees AS e
    JOIN Departments AS d
      ON d.DepartmentID = e.DepartmentID
   WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID;
	 
	SELECT e.FirstName,
		   e.LastName,
		   e.HireDate,
		   d.Name AS DeptName
	  FROM Employees AS e
INNER JOIN Departments AS d
		ON e.DepartmentID = d.DepartmentID
  	 WHERE d.Name IN ('Sales','Finance')
	   AND e.HireDate > '01/01/1999'
  ORDER BY e.HireDate;

--Employee Summary top 50
	SELECT TOP 50
			   e.EmployeeID,
			   e.FirstName + ' ' + e.LastName AS EmployeeName,
			   m.FirstName + ' ' + m.LastName AS ManagerName,
			   d.Name AS DepartmentName 
		  FROM Employees AS e
	INNER JOIN Employees AS m
		    ON e.ManagerID = m.EmployeeID
	INNER JOIN Departments AS d
			ON d.DepartmentID = e.DepartmentID
	  ORDER BY e.EmployeeID;	

--Min Average salary
SELECT MIN(AverageSalary) AS MinAverageSalary
  FROM (SELECT AVG(e.Salary) AS AverageSalary
	    FROM Employees AS e
	    GROUP BY e.DepartmentID) AS AverageSalariesByDepartment

WITH CTE_EmployeeInfo (FirstName, LastName, Salary) 
AS
(
	SELECT e.FirstName, e.LastName, e.Salary FROM Employees AS e
)

SELECT * FROM CTE_EmployeeInfo;
