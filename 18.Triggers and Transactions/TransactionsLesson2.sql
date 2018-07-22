
use Bank;

GO
CREATE OR ALTER PROC usp_MoneyTransfer @AccountOneId INT, @AccountTwoId INT, @Amount MONEY
AS
BEGIN
	BEGIN TRANSACTION

		DECLARE @CurrentAmountOfAccount MONEY = (
			SELECT a.Balance
			  FROM Accounts AS a
			 WHERE Id = @AccountOneId
		);

		IF(@CurrentAmountOfAccount < @Amount)
		BEGIN
			ROLLBACK;
			RAISERROR('Insufficient amount!', 16, 2)
			RETURN;
		END

		IF(@Amount < 0)
		BEGIN
			ROLLBACK;
			RAISERROR ('Cannot withdraw an amount less than 0 !', 16,2)
			RETURN;
		END
		
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountOneId;

		IF(@@ROWCOUNT <> 1)
		BEGIN
			ROLLBACK;
			RAISERROR ('Error, Something went wrong !', 16,2)
			RETURN;	
		END

		UPDATE Accounts
		SET Balance += @Amount
		WHERE Id = @AccountTwoId;

		IF(@@ROWCOUNT <> 1)
		BEGIN
			ROLLBACK;
			RAISERROR ('Error, Something went wrong !', 16,2)
			RETURN;	
		END

		COMMIT;
END
GO
														
EXEC dbo.usp_MoneyTransfer 2, 1, 100;
