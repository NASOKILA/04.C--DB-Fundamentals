
--01. Employees with salary above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
		SELECT FirstName, LastName FROM Employees
		WHERE Salary > 35000;
GO

--EXEC dbo.usp_GetEmployeesSalaryAbove35000;

--02.Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@Number money)
AS
	select 
		FirstName, LastName
	From Employees	
	WHERE Salary >= @Number;
GO

--EXEC usp_GetEmployeesSalaryAboveNumber 48100;

--03.Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith(@Str varchar(max))
AS
	select 
		Name
	FROM Towns
	Where left(Name, LEN(@Str)) = @Str;
GO	

--EXEC dbo.usp_GetTownsStartingWith 'Bor';

--04. Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown(@TownName varchar(MAX))
AS
	select 
		e.FirstName, e.LastName
	from Employees AS e
		JOIN Addresses AS a
		ON e.AddressID = a.AddressID
		JOIN Towns AS t
		ON a.TownID = t.TownID
	WHERE t.Name = @TownName;
GO

--EXEC dbo.usp_GetEmployeesFromTown 'Sofia';

--05. Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel (@salary money)
RETURNS varchar(max)
BEGIN
	DECLARE @Result varchar(MAX);

	IF(@salary < 30000)
	BEGIN 
		SET @Result = 'Low';
	END

	IF(@salary > 50000)
	BEGIN 
		SET @Result = 'High';
	END

	IF(@salary BETWEEN 30000 AND 50000)
	BEGIN 
		SET @Result = 'Average';
	END

	RETURN @Result;
END

--06. Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@Level varchar(MAX))
AS
	select
		FirstName,
		LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @Level;	
GO

--EXEC dbo.usp_EmployeesBySalaryLevel 'High';
--07. Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters varchar(MAX), @word varchar(MAX))
RETURNS BIT
AS
BEGIN

	DECLARE @Counter INT = 1;
	WHILE(@Counter <= LEN(@word))
	BEGIN                           --@WordCopy
		DECLARE @LetterOfWord varchar(1) = SUBSTRING(@word, @Counter, 1);

		DECLARE @ContainableLetter BIT = 0
		DECLARE @Counter2 INT = 1;
		WHILE(@Counter2 <= LEN(@setOfLetters))
		BEGIN
			IF(SUBSTRING(@setOfLetters, @Counter2, 1) = @LetterOfWord)
			BEgiN
				SET @ContainableLetter = 1;
				BREAK;
			END
			
			SET @Counter2 += 1; 
		END

		IF(@ContainableLetter = 0)
		 BEGIN
			return 0;
		 END
		 
		SET @Counter += 1;
	END

		return 1;	 
END

SELECT CHARINDEX('t', 'Customer') AS MatchPosition; 

	AltER TaBLE Departments
	Alter column ManagerId int NULL

	select EmployeeID FROM Employees AS e
		JOIN Departments As d
		ON d.DepartmentID = e.DepartmentID
		WHERE d.Name IN ('Production', 'Production Control');

	DELETE FROM EmployeesProjects 
	WHERE EmployeeID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));
	
	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));
	
	DELETE FROM Employees
	WHERE EmployeeID IN  (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));

	DELETE FROM Departments
	WHERE Name IN ('Production', 'Production Control'); 

--09.
CREATE PROCEDURE usp_AssignProject
(@EmployeeID INT, 
@ProjectID INT)
AS
	BEGIN TRANSACTION
	
	INSERT INTO EmployeesProjects
	VALUES (@EmployeeID, @ProjectID);
	
	IF((select COUNT(EmployeeID) FROM EmployeesProjects
		Where EmployeeID = @EmployeeID) > 3)
		BEGIN	
			ROLLBACK
			raiserror('The employee has too many projects!', 16, 1);
			return;
		END
	
	COMMIT;
GO
