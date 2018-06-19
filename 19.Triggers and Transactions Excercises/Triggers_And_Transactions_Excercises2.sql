

USE Bank;

--01. Create Table Logs

CREATE TABLE Logs
(
	LogId INT PRIMARY KEY IDENTITY(1,1),
	AccountId INT NOT NULL,
	OldSum MONEY,
	NewSum MONEY

	CONSTRAINT FK_Accounts_Logs 
	FOREIGN KEY (AccountId)
	REFERENCES Accounts(Id)
)
GO
CREATE TRIGGER TR_LogEntry ON Accounts
AFTER UPDATE
AS
BEGIN
	
	INSERT INTO Logs
	VALUES
	((select Id from inserted), 
	(select Balance from deleted), 
	(select Balance from inserted))
END
GO

--Testvame
UPDATE Accounts
SET Balance -= 100
WHERE Id = 2;

select * from Logs
GO

--02. Create Table Emails
CREATE TABLE NotificationEmails
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Recipient INT NOT NULL,
	[Subject] VARCHAR(MAX),
	Body VARCHAR(MAX) 
)
GO

CREATE TRIGGER TR_LogsNewEmail ON Logs
AFTER INSERT
AS
BEGIN
	
	DECLARE @Recipient INT = 
	(SELECT AccountId FROM inserted); 
	
	DECLARE @Subject VARCHAR(MAX) = 
	'Balance change for account: ' + 
	CAST((SELECT AccountId FROM inserted) AS VARCHAR(MAX));
	 
	DECLARE @Body VARCHAR(MAX) = 
	'On ' + CAST(GETDATE() AS VARCHAR(MAX)) + 
	' your balance was changed from' +  
	CAST((SELECT OldSum FROM inserted) AS VARCHAR(MAX)) + ' to ' +
	CAST((SELECT NewSum FROM inserted) AS VARCHAR(MAX)) + '.';
	  
	INSERT INTO NotificationEmails
	VALUES
	(@Recipient, @Subject, @Body);
END
GO

--TESTVAME:
UPDATE Accounts
SET Balance -= 10
WHERE Id = 1;
--Kato updeitnem vkarvame danni v logs tablicata i 
--suotvetno vkarvame v NotificationEmails

select * from Accounts
select * from Logs
select * from NotificationEmails





--03. Deposit Money
GO
CREATE PROC usp_DepositMoney 
(@AccountId INT, @MoneyAmount MONEY)
AS
BEGIN
	IF(@MoneyAmount < 0)
	BEGIN
		RAISERROR('Cannot deposit a number less than 0 !',16,2)
		RETURN;
	END

	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId;
END 
GO

--Testvame:
EXEC dbo.usp_DepositMoney 1, -20;
select * from Accounts




--04. Withdraw Money Procedure
GO
CREATE PROC usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL(16,4)) 
AS
BEGIN

	BEGIN TRAN

	IF(@MoneyAmount < 0 )
	BEGIN
		ROLLBACK;
		RAISERROR('Cannot withdrat amoount less than zero!',16,2);
		RETURN;
	END

	IF(@MoneyAmount > (SELECT Balance FROM Accounts WHERE Id = @AccountId))
	BEGIN
		ROLLBACK;
		RAISERROR('Insuficient funds!',16,2);
		RETURN;
	END

	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id = @AccountId;

	COMMIT;
	
END

--Testvame:
EXEC dbo.usp_WithdrawMoney 1, -25000;
EXEC dbo.usp_WithdrawMoney 1, 25000;
EXEC dbo.usp_WithdrawMoney 1, 25;


SELECT * FROM Accounts

--05. Money Transfer

GO
CREATE PROC usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DeCIMAL(18,4))  
AS
BEGIN
	
	IF(@Amount < 0)
	BEGIN
		RAISERROR('Cannot withdraw an amount less htan zero !', 16, 2)
		RETURN;
	END

	IF(@Amount > (SELECT Balance FROM Accounts WHERE Id = @SenderId))
	BEGIN
		RAISERROR('Insufficient funds !', 16, 2)
		RETURN;	
	END

	--First we withdraw from sender
	UPDATE Accounts
	SET Balance -= @Amount
	WHERE Id = @SenderId;
	
	--Then we deposit to the recevier 
	UPDATE Accounts
	SET Balance += @Amount
	WHERE Id = @ReceiverId;
	
END
GO

--We test it
EXEC dbo.usp_TransferMoney 1, 2, -14000; 

EXEC dbo.usp_TransferMoney 2, 1, 14000;

EXEC dbo.usp_TransferMoney 2, 1, 140;

select * from Accounts




--06 Trigger
USE Diablo;
CREATE TRIGGER TR_DiabloDatabase TO 





--07. *Massive Shopping

--08. Employees with Three Projects
USE SoftUni;

GO
CREATE PROC usp_AssignProject(@EmloyeeId INT, @ProjectId INT)
AS
BEGIN
	BEGIN TRAN
	
	IF((SELECT COUNT(*) 
		FROM EmployeesProjects
		WHERE EmployeeID = @EmloyeeId) >= 3)
	BEGIN
		ROLLBACK;
		RAISERROR('The employee has too many projects!', 16, 1);
		RETURN;
	END


	INSERT INTO EmployeesProjects
	VALUES
	(@EmloyeeId, @ProjectId );


	COMMIT;
END
GO 

--Testvame:
EXEC dbo.usp_AssignProject 250, 5;

SELECT * FROM EmployeesProjects
WHERE EmployeeID = 250;




--09. Delete Employees
CREATE TABLE Deleted_Employees
(
	EmployeeId INT PRIMARY KEY,
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	MiddleName VARCHAR(100),
	JobTitle VARCHAR(100),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentID),
	Salary MONEY
)


GO
CREATE OR ALTER TRIGGER TR_FireEmployees ON Employees
AFTER DELETE
AS
BEGIN
	
	--VAJNO !!! Mojem da Insertvame prosto sus select !!!!!!!!!!!
	INSERT INTO Deleted_Employees(FirstName, LastName, MiddleName,
			   JobTitle, DepartmentID, Salary)
		SELECT FirstName, LastName, MiddleName,
			   JobTitle, DepartmentID, Salary
		FROM deleted
END
GO

--Test it, delete some employee and see if it goes in the Deleted_Employees tabke
DELETE FROM Employees
WHERE EmployeeID IN (50,55,60);


DELETE FROM Deleted_Employees

select * from Deleted_Employees


select * from Employees
WHERE EmployeeID = 56;







INSERT INTO Deleted_Employees
	VALUES
	(
	(select EmployeeID from deleted),
	(select FirstName from deleted),
	(select LastName from deleted),
	(select MiddleName from deleted),
	(select JobTitle from deleted),
	(select DepartmentID from deleted),
	(select Salary from deleted)
	)
































