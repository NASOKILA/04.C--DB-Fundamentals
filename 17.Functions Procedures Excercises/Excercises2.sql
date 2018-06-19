
/*
UNION obedinqva dva selecta no trqbva da 
sa s ednakkuv broi kolonki

select * from Games
union
select * from Games
*/


/*
	Mojem da imame PROCEDURA s durjanie na VIEW s parametri.
	Na edno normalno VIEW ne mojem da slagame parametri !!!
*/

GO
--01.
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
BEGIN
	SELECT e.FirstName,
		   e.LastName 
	  FROM Employees AS e
	 WHERE e.Salary > 35000;
END


GO
--02.
CREATE PROC usp_GetEmployeesSalaryAboveNumber @Number DECIMAL(18,4)
AS
BEGIN
	SELECT e.FirstName,
		   e.LastName
	  FROM Employees AS e
	 WHERE e.Salary >= @Number;
END

GO
--03.
CREATE PROC usp_GetTownsStartingWith @Param VARCHAR(100)
AS 
BEGIN
	SELECT t.Name 
	  FROM Towns AS t
	 WHERE LEFT(t.Name, LEN(@Param)) = @Param
END

GO
--04.
CREATE PROC usp_GetEmployeesFromTown @TownName VARCHAR(100)
AS
BEGIN
   SELECT e.FirstName,
		  e.LastName
     FROM Employees AS e
	 JOIN Addresses AS a
	   ON a.AddressID = e.AddressID
	 JOIN Towns AS t
	   ON t.TownID = a.TownID
	WHERE t.Name = @TownName;
END

GO
--05.
CREATE PROC usp_GetEmployeesFromTown @TownName VARCHAR(100)
AS
BEGIN
   SELECT e.FirstName,
		  e.LastName
     FROM Employees AS e
	 JOIN Addresses AS a
	   ON a.AddressID = e.AddressID
	 JOIN Towns AS t
	   ON t.TownID = a.TownID
	WHERE t.Name = @TownName;
END

GO
--06.
CREATE PROCEDURE usp_EmployeesBySalaryLevel @Param VARCHAR(100)
AS
BEGIN
	DECLARE @LevelOfSalary INT;

	IF(@Param = 'Low')
	BEGIN
		SELECT e.FirstName, 
			   e.LastName 
		  FROM Employees AS e
		 WHERE e.Salary < 30000;
	END
	ELSE IF(@Param = 'Average')
	BEGIN
		SELECT e.FirstName, 
			   e.LastName 
		  FROM Employees AS e
		 WHERE e.Salary BETWEEN 30000 AND 50000;
	END
	ELSE
	BEGIN
		SELECT e.FirstName, 
			   e.LastName 
		  FROM Employees AS e
		 WHERE e.Salary > 50000;
	END 
END 

GO
--07.
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(100), @word VARCHAR(100)) 
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT = 1;
		
		DECLARE @counter INT = 1;

		--Dokato 0 ne stane = na duljinata na dumata 
		WHILE @counter < LEN(@word) + 1
		BEGIN
			
			IF(CHARINDEX(SUBSTRING(@word, @counter,1), @setOfLetters) = 0)
			BEGIN
				SET @Result = 0;
				RETURN @Result;
			END
				
		   SET @counter = @counter + 1;
		END;
	RETURN @Result;
END

GO
--08.
USE SoftUni;
ALTER PROC usp_DeleteEmployeesFromDepartment @DepartmentId INT
AS
BEGIN
	--Imame foreign kluchovete koito ni prechat	prosto da iztriem rabotnicite
	
	--Purvo ni dava greshka tuka zatova triem or EmployeesProjects
	--Rabornicite chiito ID e ot teq IDta koito iskame da iztriem ot nashiq departament.
	DELETE FROM EmployeesProjects 
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees
						 WHERE DepartmentId = @DepartmentId);


	--SETVAME ManagerID da moje da bude NULLABLE
	ALTER TABLE Departments
		ALTER COLUMN ManagerID INT NULL


	--Sega imame konflikt v Departemnts_Employees, imame ManagerID 
	--koeto ni prechi.
	--Otivame v Departamentite i setvame ManagerID da e NULL tam kudeto ManagerID
	--e edno ot teq IDta koito iskame da iztriem ot nashiq departament
	--OBACHE ZA DA STANE TOVA TRQBVA PURVO DA SETNEM ManagerID da moje da bude NULLABLE
	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID = @DepartmentId)


	--Dava ni konflikt kum Employees_Employees s ManagerID zatova pravim
	--sushtoto i za Employees
	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID = @DepartmentId)


	--Sega deletvame bez problemi ot tablicite
	DELETE FROM Employees
	WHERE DepartmentID IN (@DepartmentId);

	DELETE FROM Departments
	WHERE DepartmentID IN (@DepartmentId);

	SELECT COUNT(*) FROM Departments WHERE DepartmentID = @DepartmentId;


END


--Proverqvame dali raboti sled kato sme izvikali procedurata s parametur 1
select * from Employees WHERE DepartmentID = 1 
select * from Departments WHERE DepartmentID = 1 


GO
--09.
CREATE PROC usp_GetHoldersFullName 
AS
BEGIN
	SELECT ah.FirstName + ' ' + ah.LastName AS [Full Name]
	  FROM AccountHolders AS ah
END
GO
--10.
CREATE PROC usp_GetHoldersWithBalanceHigherThan @Money DECIMAL(18,2)
AS
BEGIN
	SELECT FirstName, LastName FROM
			(SELECT 
		           ah.FirstName, 
				   ah.LastName,
				   SUM(a.Balance) AS [Total Balance] 
			  FROM AccountHolders AS ah
			  JOIN Accounts AS a
				ON ah.Id = a.AccountHolderId
		  GROUP BY ah.FirstName, 
				   ah.LastName
			HAVING SUM(a.Balance) > @Money) AS [Resultss]
END

GO
--11.
CREATE FUNCTION ufn_CalculateFutureValue(@I MONEY, @R FLOAT, @T INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
	-- Formula: FV = I x ((1 + R) na stepen 'T')
	DECLARE @FV DECIMAL(18,4);

	SET @FV = (@I * POWER(1 + @R ,@T))
		
	RETURN @FV;
END

GO
--12.
CREATE PROC usp_CalculateFutureValueForAccount 
@AccountId INT, @InterestRate FLOAT
AS
BEGIN


SELECT TOP 1 
		   ah.Id AS [ccount Id],
		   ah.FirstName AS [First Name],
		   ah.LastName AS [Last Name],
		   a.Balance AS [Current Balance],
		   dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, 5) AS [Balance in 5 years]
	  FROM AccountHolders AS ah
	  JOIN Accounts AS a
	  ON a.AccountHolderId = ah.Id
	 WHERE ah.Id = @AccountId 	
END


GO

--13.

CREATE FUNCTION ufn_CashInUsersGames (@GameName VARCHAR(MAX))
RETURNS TABLE 
AS
BEGIN
		DECLARE @Result TABLE;
		SET @Result = 
		(
		SELECT SUM(Cash) AS [SumCash] 
		  FROM (SELECT ug.Cash, 
					   ROW_NUMBER() OVER(ORDER BY Cash DESC) as RowNum
				  FROM UserGames AS ug
				  JOIN Games AS g 
				    ON g.Id = ug.GameId
				 WHERE g.Name = @GameName)
		 WHERE (RowNum % 2 = 1) 
		 )
	RETURN @Result;

GO


















































