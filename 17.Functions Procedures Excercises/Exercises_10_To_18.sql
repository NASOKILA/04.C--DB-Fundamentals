



--use Bank

--10. Find Full Name

CREATE PROCEDURE usp_GetHoldersFullName
AS
	select FirstName + ' ' + LastName AS FullName
	from AccountHolders

GO
--Ne submitvai 'GO' v judja

--EXEC dbo.usp_GetHoldersFullName;



--11. People with Balance Higher Than

CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@Amount money)
AS
	select 
	 	 ah.FirstName, ah.LastName
	from AccountHolders AS ah
	JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	GROUP BY ah.FirstName, ah.LastName
	HAVING SUM(a.Balance) > @Amount
	
GO

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 55000;



--12. Future Value Function

CREATE FUNCTION ufn_CalculateFutureValue
(@Sum money, @YearlyInterestRate float, @NumberOfYears int)
RETURNS money
BEGIN
	DECLARE @FV MONEY
	SET @FV = @Sum*POWER(1e0+@YearlyInterestRate,@NumberOfYears)
	RETURN @FV 
END

SELECT 
	dbo.ufn_CalculateFutureValue(1000, 0.1, 5) AS Output;




--13. Calculating Interest

create PROCEDURE usp_CalculateFutureValueForAccount
(@AccountId INT, @InterestRate float)
AS

	SELECT 
		ah.Id AS [Account Id], 
		ah.FirstName [First Name], 
		ah.LastName [Last Name],
		a.Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, 5) AS [Balance in 5 years]

	FROM AccountHolders AS ah
	JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	WHERE a.Id = @AccountId;
	
GO

--EXEC usp_CalculateFutureValueForAccount 1, 0.1;
	

--14

CREATE PROCEDURE usp_DepositMoney(@AccountId INT , @MoneyAmount money)
AS
	
BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance += @MoneyAmount  
	WHERE Id = @AccountId;

	IF @@ROWCOUNT <> 1      --AKO SME AFEKTIRALI POVECHE OT 1 RED
	BEGIN
		ROLLBACK;
		RETURN;
	END
	
COMMIT;

GO

--EXEC dbo.usp_DepositMoney 1, 50;





--15. Withdraw Money Procedure
AltER PROCEDURE usp_WithdrawMoney(@AccountId INT , @MoneyAmount money)
AS
	
BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance -= @MoneyAmount  
	WHERE Id = @AccountId;

	IF @@ROWCOUNT <> 1      --AKO SME AFEKTIRALI POVECHE OT 1 RED
	BEGIN
		ROLLBACK;
		RETURN;
	END
	
COMMIT;

GO


--EXEC dbo.usp_WithdrawMoney 2, 405;





--16. Money Transfer

ALTER PROCEDURE usp_TransferMoney
(@senderId INT, @receiverId INT, @amount money)
AS
	BEGIN TRAN
	
	EXEC usp_WithdrawMoney @senderId, @amount;
	EXEC usp_DepositMoney @receiverId, @amount;
	
		IF(@amount < 0)
		BEGIN
			ROLLBACK;
			RETURN;	
		END
	COMMIT;
GO


--EXEC dbo.usp_TransferMoney 1, 4, 100;



--17. Create Table Logs
--use Bank

CREATE TABLE Logs
(
LogId INT IDENTITY PRIMARY KEY, 
AccountId INT, 
OldSum money, 
NewSum money,
CONSTRAINT FK_Logs_Accounts FOREIGN KEY (AccountId)
REFERENCES Accounts(Id)
)

--Pravim trigger koito dobavq danni v tablica Logs vseki put kogato Updatenem sumata v akaunta :
CREATE TRIGGER tr_AddLogs ON Accounts 
AFTER UPDATE -- dali shte n`pishem AFTER ili FOR e edno i sushto !!!
AS
BEGIN
	
	--MNOOGO VAJNOOOOOO !!!!!

	--UPDATE TRIGGERA MOJE DA POLZVA I DVETE TABLICI inserted I deleted 
	--DOKATO DELETE TRIGERA POLZVA SAMO deleted I INSERT TRIGGERA POLZVA 
	--SAMO inserted

	--Ako imahme INSERT trigger shtqhme insertnatite danni da gi slagame tuk
	-- SEGA KOGATO UPDAITNEM DADENI DANNI SHTE SE ZAPISVAT V inserted TABLICATA
	--select * from inserted 

	--AKO TRIGGERA BESHE DELETED DELITNATITE DANNI SHTEHA DA SA V deleted TABLICATA 
	--PRI UPDATED TRIGGER TUK VLIZAT VSICHKI TEZI DANNI KOITO SA BILI PREDI PROMQNATA
	--select * from deleted


	INSERT INTO Logs (AccountId, OldSum, NewSum)
	VALUES ((select Id from inserted), 
			(select Balance from deleted),
			(select Balance from inserted))
END




--18. Create Table Emails

CREATE TABLE NotificationEmails
(
	Id INT PRIMARY KEY IDENTITY,
	Recipient INT,
	Subject varchar(100),
	Body varchar(max)
)

select * from AccountHolders

CREATE TRIGGER tr_AddEmail ON Logs
AFTER INSERT
AS
BEGIN
	
	DECLARE @Account INT = (select AccountId from inserted);
	DECLARE @Date Date = GetDate();
	DECLARE @OldBalance money = (select A from inserted)

	INSERT INTO NotificationEmails 
	VALUES(
			1, 
			'Balance change for account:' + @account,
			'On' + )

END

















