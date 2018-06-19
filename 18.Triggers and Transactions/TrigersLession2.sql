

--LEKCIQ ZA TRIGGERI:


/*
	Te sa kato proceduri samoche nie ne gi izvikvame, te se 
	izvikvat (SLED ili VMESTO) dadeno deistvie.
	Tova deistvie moje da e INSERT, UPDATE ili DELETE !

	Nie suzdavame triger koito da pravi dadeno neshto (EVENT) 
	obache chaka da se izpulni dadeno deistvie za da se aktivira.

	EVENTI:
	Eventite sa neshta koito trigera moge da pravi, i te mogat da 
	budat INSERT, UPDATE, DELETE.

	Ima dva vida triggeri: 
	AFTER - koito se izpulnqva sled dadeno deistvie 
	INSTEAD OF - koito se izpulnqva vmesto dadeno deistvie 


	VAJNO  !!! :
	Vmesto 'AFTER' moje i da kajem 'FOR'


	VAJNO !!! :
	V tranzakciite imame dve vgradeni tablici 'inserted' i 'deleted' koito 
	avtomatichno durjut rezultati:


	PRI 'UPDATE TRIGGER':
	'inserted' - durji dannite koito toku shto sme promenili t.e. novite stoinosti
	'deleted' - durji starite stoinosti

	PRI 'INSERT TRIGGER':
	'inserted' - durji dannite koito toku shto sme dobavili
	'deleted' - e prazna

	PRI 'DELETE TRIGGER':
	'inserted' - e prazna 
	'deleted' - durji dannite koito toku shto sme itrili

*/



--Primer:

use Bank;

--Suzdavame si tablica Transactions v koqto shte si zapisvame 
--vsichki transferi: SHTE IMA VRUZKA KUM Account OneToMany zashtoto
--edin akaunt moje da ima mnogo tranzakcii napraveni.

--KOGATO UPDEITNEM NESHTO V AKAUNTS TO DA SE ZAPISVA V TAZI TABLICA,
--RABOTI SAMO AKO DOBAVQME ILI VADIM OT BALANSA NA NQKOI !!!!!
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



GO  -- kakvo:       ime:       tablica:   kakuv da e:
CREATE OR ALTER TRIGGER tr_ProcessTransactions ON Accounts AFTER UPDATE
AS
BEGIN
	--Tozi triger shte se zktivira sled kato updaitnem nqkoi akaunt

	DECLARE @OldBalance MONEY = (select Balance from deleted);
	DECLARE @NewBalance MONEY = (select Balance from inserted);
	DECLARE @AmountTransfered MONEY = ABS(@OldBalance - @NewBalance);
	DECLARE @DateAndTime DATETIME = GETDATE();
	DECLARE @AccountId INT = (select Id from inserted);
	
	INSERT INTO Transactions
	VALUES
	(@OldBalance, @NewBalance, @AmountTransfered, @DateAndTime, @AccountId);


	--slagame si i edin selekt da ni izobrazqva vsichko
		select * from Transactions

END

--Testvame :
UPDATE Accounts
SET Balance -= 20
WHERE Id = 5;




/*
	INSTEAD OF TRIGER veche znaem kakvo e

	Dobur Primer e vmesto da triem nqkkuv akaunt mojem prosto da 
	updeitnem IsActive kolonata (Ako ima takava) na 'N'
	t.e. gi deaktivirame:

*/

use Bank;

--Dobavqme si tazi kolonka v AccountHolders
ALTER TABLE AccountHolders
ADD IsActive CHAR(1);

--Ot NULL gi setvame vsichki na 'Y' t.e. YES
UPDATE AccountHolders
SET IsActive = 'Y'
WHERE IsActive IS NULL;

--Setvame kolonata da e NOT NULL zashtoto pri suzdavaneto ne ni dava !!!
ALTER TABLE AccountHolders
ALTER COLUMN IsActive CHAR(1)NOT NULL;

--Suzdavame si trigera
GO
CREATE OR ALTER TRIGGER tr_DeleteAccountHolder ON AccountHolders
INSTEAD OF DELETE
AS
BEGIN

	--setvame na 'N' tezi koito bi trqbvalo da se iztriqt :
	UPDATE AccountHolders
	SET IsActive = 'N'
	FROM AccountHolders AS ah   --ZA DA JOINEM TRQBVA DA DOBAVIM TABLICATA
	JOIN deleted AS d ON d.Id = ah.Id
	WHERE d.IsActive = 'Y';
	 
END
GO

DELETE FROM AccountHolders
WHERE Id IN (1,2);


select * from AccountHolders







