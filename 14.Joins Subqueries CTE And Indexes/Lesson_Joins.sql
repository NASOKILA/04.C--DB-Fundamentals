
--InnerJoin:
--CREATE DATABASE Test3;
--USE Test3;
CREATE TABLE Departments(
	DepartmentID INT PRIMARY KEY,
	DepartmentName varchar(50)
)

CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY,
	DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
)

INSERT INTO Departments
VALUES
(3,'Sales'),
(4,'Marketing'),
(5,'Purchasing');

INSERT INTO Employees
VALUES
(263,3),
(270, NULL);

SELECT * FROM Employees AS e
INNER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

SELECT * FROM Employees AS e
JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Left Outer Join
SELECT * FROM Employees AS e
LEFT OUTER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Right Outer Join
SELECT * FROM Employees AS e
RIGHT OUTER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Full Join:
SELECT * FROM Employees AS e
FULL JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Cross Join:
SELECT * FROM Employees AS e
CROSS JOIN Departments AS d 

--USE Diablo
Select u.Username, g.Name from Users AS u
inner Join UsersGames AS ug 
ON u.Id = ug.UserId
inner Join Games AS g
ON g.Id = ug.GameId
Order by u.Username;

---Use test3
select * from Departments AS d, Employees AS e;

select * from Departments AS d, Employees AS e
Where(d.DepartmentID = e.DepartmentID)

--USE SoftUni
select * from Departments AS d, Employees AS e, EmployeesProjects AS ep
Where(d.DepartmentID = e.DepartmentID AND e.EmployeeID = ep.EmployeeID);

select e1.FirstName, e2.LastName From Employees as e1
CROSS JOIN Employees AS e2
order by RAND();

select e1.FirstName, e2.LastName From Employees as e1
CROSS JOIN Employees AS e2
order by NEWID();

--Self Join
--USE SoftUni
Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name',
e2.FirstName + ' ' + e2.LastName AS 'Manager name'  
from Employees AS e1  
JOIN Employees AS e2  
ON e1.ManagerID = e2.EmployeeID  

Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name',
e2.FirstName + ' ' + e2.LastName AS 'Colegue name'  
from Employees AS e1  
JOIN Employees AS e2  
ON e1.DepartmentID = e2.DepartmentID  
AND e1.EmployeeID <> e2.EmployeeID 
order by [Employee name];

Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name',
e2.FirstName + ' ' + e2.LastName AS 'Colegue name'  
from Employees AS e1  
JOIN Employees AS e2  
ON e1.DepartmentID = e2.DepartmentID
AND e1.EmployeeID <> e2.EmployeeID
AND e1.FirstName + ' ' + e1.LastName  = 'Alan Brewer';

--use SoftUni
select top(50)                  
e.FirstName,                    
e.LastName,						
t.Name AS 'Town',							
a.AddressText					
from Employees AS e				
Join Addresses as a				
ON e.AddressID = a.AddressID	
Join Towns AS t					
ON a.TownID = t.TownID			
ORDER BY e.FirstName, e.LastName; 

select * from Addresses

select 
	e.EmployeeID, 
	e.FirstName, 
	e.LastName, 
	d.Name 
from Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
	AND d.Name = 'Sales'
ORDER BY e.EmployeeID;

Select e.FirstName, e.LastName, e.HireDate, d.Name from Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID 
WHERE(d.Name = 'Sales' OR d.Name = 'Finance')
AND e.HireDate > '1999-01-01 00:00:00'            
ORDER BY e.HireDate ASC;

Select TOP (50) 
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS 'EmployeeName',
	m.FirstName + ' ' + m.LastName AS 'ManagerName',
	d.Name AS 'DepartmentName'
from Employees AS e
	JOIN Employees AS m
	ON m.EmployeeID = e.ManagerID
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID;
