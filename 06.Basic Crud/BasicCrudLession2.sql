


USE SoftUni



SELECT TOP (5)
	EmployeeID, FirstName, LastName, JobTitle, Salary FROM Employees
WHERE Salary > 20000
ORDER BY Salary DESC



SELECT FirstName + ' ' + LastName AS [Full Name] FROM Employees


--Zd:

SELECT 
	FirstName + ' ' + LastName AS [Full Name],
	JobTitle AS 'Job Title',
	Salary
FROM Employees


--DISTINCT
SELECT 
	DISTINCT DepartmentID
 FROM Employees


 --vsichki ot daden departament s JOIN
SELECT 
	* 
FROM Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Research and Development';


--Vsichki rabotnici ot marketing departamenta sus subquery
SELECT 
	* 
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE Name = 'Marketing')



--NOT IN : Selektirame vsichki koito menidjera NE im e s ID 5 ili 6	
SELECT 
	*
FROM Employees
WHERE ManagerID NOT IN (5, 6);



--AND, OR, BETWEEN, NOT, NOT IN, IN




--IS NULL,  not = NULL
SELECT * FROM Employees AS e
WHERE MiddleName IS NULL;


--View e zapazen select s ime
GO
CREATE VIEW v_EmployeesNamesAndDepartments
AS
	SELECT 
		FirstName + ' ' + LastName AS 'Ful Name',
		DepartmentID
	FROM Employees AS e



select * from v_EmployeesNamesAndDepartments;
--Viewto samo spestqva pisane i ni ulesnqva 
-- no ne e po burzo, kato performance si e sushtoto 
--kato prosto SELECT



--Zd Nai golemiq Peak
USE Geography;

CREATE VIEW v_HighestPeak2
AS
SELECT TOP(1) * FROM Peaks
ORDER BY Elevation DESC


select * from v_HighestPeak2;

--VAJNO !!! : MOJEM DA NAPISHEM I 'TOP 10 PERCENT' 
--koeto shte ni dade 10 procenta ot tova.





--Zapisvane v tablica s INSERT
--Vajno e da spesificirame koi koloni iskame da naulnim
--Ako ne go napravim shte napulnim vsichi.




--VAJNOOOOOOOO !!!!!! :
--INTO : sus nego suzdavame novi tablici kato polzvame select ili view
SELECT TOP(5) 
	*
INTO FiveLowestPeaks 
FROM Peaks
ORDER BY Elevation
--SUZDADOHME NOVA TABLICA S IME FiveLowestPeaks KOQTO SUDURJA PURVITE 5 
--NAI NISKI VURHOVE.




--VAJNOOO !!!! :
--Ponqkoga cesh pametta ne razbira che imame nova tablica
--Za da q refreshnem natiskme CTRL + SHIFT + R ili otivame na
--ili otivame na Edit, Intellisence, Refresh Local Cashe.



--Sequenses: Te sa malko kato IDENTITY

CREATE SEQUENCE seq_Customers_CustomerID
AS INT
	START WITH 1
	INCREMENT BY 1

--Selektvame sledvashtata stoinost za SEQUENSA KOITO SUZDADOHME.
SELECT NEXT VALUE FOR seq_Customers_CustomerID

--VSEKI PUT KATO GO SELEKTNEM SE UVELICHAVA S 1 ZASHTOTO TAKA SME GO NAPRAVILI.




--S UPDATE i DELETE znaem kakvo se pravi

--Ako na DELETE ne i slojim WHERE shte iztrie vsichko 
--kakto pravi TRUNCATE

--DROP znaem kakvo pravi



--UPDATE shte smenim Middle Name na roberto ot tablicata Employees
Use SoftUni;

UPDATE Employees
SET MiddleName = 'Ivanov'
WHERE FirstName = 'Roberto' AND LastName = 'Tamburello'

select * from Employees
--TRQBVA I TUK DA SLAGAME WHERE INACHE PROMENQME VSICHKO V TABLICATA.




--Zd: Complete all unfinished projects:

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL;

select * from Projects













