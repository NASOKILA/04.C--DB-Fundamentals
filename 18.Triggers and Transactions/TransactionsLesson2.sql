

/*
	TRIGGERS AND TRANSACTIONS:

	Shte govorim za ACID modeli,
	Tranzakcii,
	Trigeri ot dva vida AFTER i INSTEAD,
	Database Security ROLI USERI LOGIN i dr,



	'AFTER TRIGERA' SE IZPULNQVA SLED DEISTVIETO A
	'INSTEAD TRIGERA' SE IZPULNQVA VMESTO DEISTVIETO

*/


/*
	Tranzakciq e poredica ot stupki koito trqbva da se izpulnqt
	i ako edna ot tezi stupki ne se izpulni znachi cqlata tranzakciq
	otpada i nishto nqma da se izpulni.

	
	Primer e tozi s prehvurlqneto na pari ot edna smetka v druga.
	rollback i commit gi znaem.

	Kakvo moje da se oburka? Da krashne servera, da spre toka ...

	Otvarqme tranzakciq s BEGIN TRANSACTION i svurshva s END.

	@@ROWCOUNT ni pokazva kolko reda sa bili afektirani ot 
	predishnoto deistvie. S nego proverqvame dali vsichko e nared.

	Sled ROLLBACK mojem da slagame SUOBSHTENIQ RAISERROR
	i sled tova mojem da kajem RETURN !


*/

use Bank;

--Primera s bankata:
--Shte napravim procedura koqto da vadi pari ot ediniq akaunt i da gi slaga v drugiq.

GO
CREATE OR ALTER PROC usp_MoneyTransfer @AccountOneId INT, @AccountTwoId INT, @Amount MONEY
AS
BEGIN
	BEGIN TRANSACTION

	--We check if there is enouph money in the account from which we withdraw :
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

	--Ako amounta e < ot 0 znachi hvurlqme greshka.
		IF(@Amount < 0)
		BEGIN
			ROLLBACK;
			RAISERROR ('Cannot withdraw an amount less than 0 !', 16,2)
			RETURN;
		END
		
		--mahame ot ediniq akaunt
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountOneId;

		--Ako afektirame poveche ot 1 red hvurlqme greshka
		IF(@@ROWCOUNT <> 1)
		BEGIN
			ROLLBACK;
			RAISERROR ('Error, Something went wrong !', 16,2)
			RETURN;	
		END

		--Slagame v drugiq akaunt
		UPDATE Accounts
		SET Balance += @Amount
		WHERE Id = @AccountTwoId;

		--Ako afektirame poveche ot 1 red hvurlqme greshka
		IF(@@ROWCOUNT <> 1)
		BEGIN
			ROLLBACK;
			RAISERROR ('Error, Something went wrong !', 16,2)
			RETURN;	
		END

		--VINAGI PISHEM 'COMMIT' Nakraq
		COMMIT;
	
END
GO

--Testvame : VIJDAME CHE VSICHKO RABOTI !!!															
EXEC dbo.usp_MoneyTransfer 2, 1, 100;






/*
	MOJEM DA POLZVAME 'SET ISOLATION LEVEL'
	
*/










