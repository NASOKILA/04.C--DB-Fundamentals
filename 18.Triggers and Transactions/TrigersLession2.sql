
use Bank;

CREATE TABLE Transactions
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	OldBalance MONEY NOT NULL,
	NewBalance MONEY NOT NULL,
	Amount MONEY NOT NULL,
	[DateTime] DateTime,
	AccountId INT NOT NULL 
	
	CONSTRAINT FK_Transactions_Accounts 
	FOREIGN KEY (AccountId)
	REFERENCES Accounts(Id)  
)

GO 
CREATE OR ALTER TRIGGER tr_ProcessTransactions ON Accounts AFTER UPDATE
AS
BEGIN
	DECLARE @OldBalance MONEY = (select Balance from deleted);
	DECLARE @NewBalance MONEY = (select Balance from inserted);
	DECLARE @AmountTransfered MONEY = ABS(@OldBalance - @NewBalance);
	DECLARE @DateAndTime DATETIME = GETDATE();
	DECLARE @AccountId INT = (select Id from inserted);
	
	INSERT INTO Transactions
	VALUES
	(@OldBalance, @NewBalance, @AmountTransfered, @DateAndTime, @AccountId);

		select * from Transactions
END

UPDATE Accounts
SET Balance -= 20
WHERE Id = 5;

use Bank;

ALTER TABLE AccountHolders
ADD IsActive CHAR(1);

UPDATE AccountHolders
SET IsActive = 'Y'
WHERE IsActive IS NULL;

ALTER TABLE AccountHolders
ALTER COLUMN IsActive CHAR(1)NOT NULL;

GO
CREATE OR ALTER TRIGGER tr_DeleteAccountHolder ON AccountHolders
INSTEAD OF DELETE
AS
BEGIN
	UPDATE AccountHolders
	SET IsActive = 'N'
	FROM AccountHolders AS ah   
	JOIN deleted AS d ON d.Id = ah.Id
	WHERE d.IsActive = 'Y';
END
GO

DELETE FROM AccountHolders
WHERE Id IN (1,2);

select * from AccountHolders
