
GO
CREATE PROCEDURE dbo.urf_SelectEmployeesName
AS
	SELECT FirstName, LastName FROM Employees
GO

EXEC dbo.urf_SelectEmployeesName;

CREATE PROCEDURE dbo.utf_AddNumbers
@FirstNumber INT,
@SecondNumber INT,
@Result INT OUTPUT
AS
	SET @Result = @FirstNumber + @SecondNumber;
GO

DECLARE @Answare INT;

EXECUTE dbo.utf_AddNumbers 5, 3, @Answare OUTPUT;

select 'The result is : ' , @Answare; 

--use SoftUni
CREATE PROCEDURE dbo.utf_AddProjectToEmployee
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
			raiserror('Cannot work in more than three projects at once !', 16, 1);
			return; 
		END
	COMMIT;
GO

select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 6;

EXEC dbo.utf_AddProjectToEmployee 2, 2;

select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 2;

--Withdraw money
CREATE PROCEDURE usp_WithdrawMoney(@AccountId INT, @MoneyAmount money)
AS
	BEGIN TRAN

		IF( @AccountId NOT IN (select Id from Accounts))
		BEGIN
			ROLLBACK;
			raiserror('AccountId dont exist!', 16, 1);
			return;
		END

		UPDATE Accounts
		SET Balance -= @MoneyAmount
		Where @AccountId = Id;

		DECLARE @Balance money = 
		(select Balance from Accounts
		Where @AccountId = Id);

		IF(@Balance < 0)
		BEGIN
		ROLLBACK;
			
			raiserror('Insufficent Balance!', 16, 1);
			return;
		END
		
		COMMIT;
GO

select * from Accounts
where Id = 1;

EXEC dbo.usp_WithdrawMoney 1, 23.12;

select * from Accounts
where Id = 1;

EXEC dbo.usp_WithdrawMoney 2131, 23.12;

EXEC dbo.usp_WithdrawMoney 1, 101;
