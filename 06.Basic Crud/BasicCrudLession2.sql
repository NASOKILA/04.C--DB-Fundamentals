
USE SoftUni

SELECT TOP (5)
	EmployeeID, FirstName, LastName, JobTitle, Salary FROM Employees
WHERE Salary > 20000
ORDER BY Salary DESC

SELECT FirstName + ' ' + LastName AS [Full Name] FROM Employees


SELECT 
	FirstName + ' ' + LastName AS [Full Name],
	JobTitle AS 'Job Title',
	Salary
FROM Employees


SELECT 
	DISTINCT DepartmentID
 FROM Employees

SELECT * 
FROM Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Research and Development';

SELECT 
	* 
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE Name = 'Marketing')

SELECT 
	*
FROM Employees
WHERE ManagerID NOT IN (5, 6);

SELECT * FROM Employees AS e
WHERE MiddleName IS NULL;


GO
CREATE VIEW v_EmployeesNamesAndDepartments
AS
	SELECT 
		FirstName + ' ' + LastName AS 'Ful Name',
		DepartmentID
	FROM Employees AS e



select * from v_EmployeesNamesAndDepartments;

USE Geography;

CREATE VIEW v_HighestPeak2
AS
SELECT TOP(1) * FROM Peaks
ORDER BY Elevation DESC

select * from v_HighestPeak2;

SELECT TOP(5) 
	*
INTO FiveLowestPeaks 
FROM Peaks
ORDER BY Elevation

CREATE SEQUENCE seq_Customers_CustomerID
AS INT
	START WITH 1
	INCREMENT BY 1

SELECT NEXT VALUE FOR seq_Customers_CustomerID

Use SoftUni;

UPDATE Employees
SET MiddleName = 'Ivanov'
WHERE FirstName = 'Roberto' AND LastName = 'Tamburello'

select * from Employees

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL;

select * from Projects
