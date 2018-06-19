


/*
	VAJNO !!! :
	SET IDENTITY_INSERT:
*/

--USE Orders;

--Pravim s iprimerna tablica
CREATE TABLE Example
(
	Id INT PRIMARY KEY IDENTITY,
	Name varchar(50) NOT NULL
)

--Slagame si neshto vutre
INSERT INTO Example
VALUES('Nasko');

/*Vijdame che na Id 1 imame 'Nasko'*/
SELECT * FROM Example


--MOJEM DA SLOJIM DADENO IME NA IZBRANO OT NAS Id !!! :
SET IDENTITY_INSERT Example ON
	INSERT INTO Example (Id, Name)
	VALUES (4, 'Asi')
SET IDENTITY_INSERT Example OFF; 
--Vajno e nakraq da go izkluchim inache na sledvashtiq put shte ni dade greshka !!!


/*Vijdame che na Id 4 sme slojili 'Asi'*/
SELECT * FROM Example








