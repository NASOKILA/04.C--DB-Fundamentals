/****** Script for SelectTopNRows command from SSMS  ******/


/* 0. */
SELECT * FROM Departments

/* 1. */
SELECT Name FROM Departments

/* 2. */
SELECT Salary FROM Employees

/* 3. */
SELECT FirstName, LastName, Salary FROM Employees

/* 4. */
SELECT FirstName, MiddleName,LastName FROM Employees

/* 5. */
SELECT(FirstName + '.' + LastName + '@softuni.bg') FROM Employees

/* 6. */
SELECT DISTINCT Salary FROM Employees;

/* 7. */
SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative';

/* 8. */
SELECT FirstName, LastName, JobTitle FROM Employees
WHERE (Salary >= 20000 AND Salary <= 30000);

/* 9. */
SELECT (FirstName + ' ' + MiddleName + ' ' + LastName) FROM Employees
WHERE Salary  IN (25000, 14000, 12500, 23600);

SELECT * FROM Employees;

/* 10. */
SELECT FirstName, LastName FROM Employees
WHERE ManagerID IS NULL;

/* 11. */
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

/* 12. */
SELECT TOP(5) FirstName, LastName FROM Employees
ORDER BY Salary DESC;

/* 13. */
SELECT FirstName, LastName FROM Employees
WHERE DepartmentID != 4;

/* 14. */
SELECT * FROM Employees
ORDER BY Salary DESC,  FirstName, LastName DESC, MiddleName;

/* 15. */
CREATE VIEW v_employeesSalaries
AS SELECT FirstName, LastName, Salary
FROM Employees;

/* 16. */
CREATE VIEW V_EmployeeNameJobTitle
AS 
SELECT FirstName + ' ' + ISNULL(MiddleName, '')+ ' ' + LastName AS FullName,
JobTitle
FROM Employees; 

SELECT * FROM V_EmployeeNameJobTitle;

-- RESHENIE SUS 'CASE' 'WHEN', 'END'
/*CASE e nachaloto a END e kraq, usvolieto ni 
sedi v WHEN, to trqbva da vrushta rezultat,
Mojem da polzvame nqkolko puti WHEN i THEN
KONSTRUKCIQTA E KATO V SWITCH CASE,
ELSE e kato DEFAULT:
*/

CREATE VIEW V_EmployeeNameJobTitle2
AS 
SELECT 
CASE
WHEN MiddleName IS NULL THEN FirstName + ' ' + ' ' + LastName
ELSE FirstName + ' ' + MiddleName + ' ' + LastName
END AS CountryName
JobTitle
FROM Employees;

SELECT * FROM V_EmployeeNameJobTitle2


/* 17. */
SELECT DISTINCT JobTitle
FROM Employees;

/* 18. */
SELECT TOP (10) * FROM Projects
ORDER BY StartDate, Name;

/* 19. */
SELECT TOP(7) FirstName, LastName, HireDate FROM Employees
ORDER BY HireDate DESC;

/* 20. */
SELECT TOP(7) FirstName, LastName, HireDate FROM Employees
ORDER BY HireDate DESC;

/* 21. */
UPDATE Employees
SET Salary = Salary + (Salary * 0.12)
WHERE DepartmentID IN ( 1, 2, 4, 11 );

SELECT Salary FROM Employees


--Subquery oznachava zaqvka v druga zaqvka, shte go uchim po napred



