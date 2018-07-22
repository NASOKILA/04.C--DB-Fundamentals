
CREATE TRIGGER tr_TownsUpdate ON Towns FOR UPDATE 
AS	
	IF(EXISTS(select * from Towns WHERE Name IS NULL) OR EXISTS(select * from Towns WHERE LEN(Name) = 0))
	BEGIN
		ROLLBACK
		raiserror('Cannot Update because Town cannot be NULL or Empty',1,15)
		return;
	END

GO

select * from Towns
where TownID = 1;

UPDATE Towns
SET Name = ''
Where TownID = 1;

CREATE TRIGGER tr_TownsDelete ON Towns 
INSTEAD OF DELETE
AS
	INSERT Towns
	VALUES ('NewTown');
GO

BEGIN TRAN

	DELETE FROM Towns
	WHERE TownID = 15;

select * from Towns
ROLLBACK;
