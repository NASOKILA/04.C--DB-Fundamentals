
USE SoftUni;

GO
CREATE PROC dbo.usp_SelectEmployeesBySeniority
AS
BEGIN
  SELECT * FROM Employees
  WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 15;
END
GO

EXEC dbo.usp_SelectEmployeesBySeniority

EXEC sp_depends 'dbo.usp_SelectEmployeesBySeniority';

GO
CREATE PROC dbo.usp_SelectEmployeesBySeniority2 @years INT
AS
BEGIN
	SELECT * FROM Employees AS e
	WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > @years;
END
GO

EXEC dbo.usp_SelectEmployeesBySeniority2 17;

GO
CREATE OR ALTER PROC dbo.usp_AddNumbers
@FirstNumber SMALLINT,
@SecondNumber SMALLINT,
@Result INT OUTPUT
AS
BEGIN
	SET @Result = @FirstNumber + @SecondNumber
END
GO

DECLARE @Answer smallint; 
EXEC dbo.usp_AddNumbers 5, 10, @Answer OUTPUT;  
SELECT @Answer AS Resultat; 
GO

USE SoftUni;

GO
CREATE PROCEDURE dbo.AddEmployeeToProject (@EmployeeId INT, @ProjectId INT)
AS
BEGIN
	DECLARE @EmployeeProjectCount INT = (SELECT COUNT(*) 
										   FROM EmployeesProjects
										  WHERE EmployeeID = @EmployeeId);
	IF(@EmployeeProjectCount >= 3)
		BEGIN
			RAISERROR ('Employee has to many projects !', 16, 1);
			RETURN;
		END
	INSERT INTO EmployeesProjects
	VALUES (@EmployeeId, @ProjectId);
END
GO

EXEC dbo.AddEmployeeToProject 263, 25; 
GO

EXEC dbo.AddEmployeeToProject 263, 26; 
GO

EXEC dbo.AddEmployeeToProject 263, 27; 
GO

SELECT * FROM EmployeesProjects; 

USE Bank2;

GO
EXEC dbo.p_Withdraw 1, 100; --We take 100 from accaunt with ID 1
GO
EXEC dbo.p_Deposit 2, 100; 
GO
EXEC dbo.p_AddAccount 3, 2; 
GO

SELECT * FROM Accounts;
