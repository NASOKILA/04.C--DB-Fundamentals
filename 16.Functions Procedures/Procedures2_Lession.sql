

--STORED PROCEDURES :

/*
	Tova e prosto da dadem ime na parche kod,
	obache ne vrushta rezultat a prosto 
	izpulnqva dadeno deistvie.
	MOJEM DA GI NAPRAVIM TAKA CHE DA VRUSHTAT REZULTAT.

	Procedurite ulesnqvat rabotata ni.
	Vmesto da pishem edin i sushti SELECT 10 PUTI
	mojem da go slojim v Procedura i da q izvikvame
	koeto ni ulesnqva.
*/

USE SoftUni;
--Primer: Shte suzdadem procedura koqto selectira 
--vsichki rabotnici koito sa s nad 15 godini staj.
GO
CREATE PROC dbo.usp_SelectEmployeesBySeniority
AS
BEGIN
  SELECT * FROM Employees
  WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 15;
END
GO

--KAK SE IZVIKVA ?     
EXEC dbo.usp_SelectEmployeesBySeniority
/*
	Prosto pishem EXEC i imeto, ili samo imeto, 
	ili mojem da q kombiniram sus SELECT !!!!!
*/

--Pravi se s CREATE PROCEDURE i s CREATE PROC
/*
	Procedurata nqma parametri ! 
	MOJEM DA Q PROMENQME S 'ALTER' ILI E DOBRE 
	DA NAPISHEM 'CREATE OR ALTER' SAMOCHE NE 
	MINAVA V JUDGE. 
	
	KAKTO FUNKCIITE MOJEM DA GI DROVAME S 'DROP' !

	VAJNOOOO!!!!!!!!!
	Stored Procedures sa tezi proceduri koito sa veche
	napraveni avtomatichno, mojem da gi dostupim sus:
	EXEC sp_... SHTE VIDISH KOLKO SA MNOGO !
*/


--Sus 'Stored Procedure depends' vijdame dali nashata 
--procedura zavisi ot neshto.
EXEC sp_depends 'dbo.usp_SelectEmployeesBySeniority';
--Vijdame che zavisi ot dadeni koloni v tablica 
--Employees, t.e razchita na tqh.


/*
	PROCEDURI S PARAMETRI:
	Sushtoto e kakto pri funkciite samoche NE se slagat 
	v skobi a prosto se izrejdat sled tova.
*/

GO
CREATE PROC dbo.usp_SelectEmployeesBySeniority2 @years INT
AS
BEGIN
	SELECT * FROM Employees AS e
	WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > @years;
END
GO

EXEC dbo.usp_SelectEmployeesBySeniority2 17;



/*
	I procedurata moje da izvikva rezultat no ne se pravi chesto.
	V takuv sluchai se polzva Funkciq.

*/

GO
CREATE OR ALTER PROC dbo.usp_AddNumbers
@FirstNumber SMALLINT,
@SecondNumber SMALLINT,
@Result INT OUTPUT --Predi AS BEGIN pishem @Result INT OUTPUT
AS
BEGIN
	SET @Result = @FirstNumber + @SecondNumber
END
GO

--Kak se printira rezultata v tozi skuchai ?
DECLARE @Answer smallint; --Pravim si promenliva.
EXEC dbo.usp_AddNumbers 5, 10, @Answer OUTPUT;  -- posochvame nakraq che tam iskame da zapishem rezultata.
SELECT @Answer AS Resultat; 
--VAJNO E DA SeLEKTIRAME VSICHKO ZAEDNO !
GO



--Zd Employee with three projects.
USE SoftUni;

GO
CREATE PROCEDURE dbo.AddEmployeeToProject (@EmployeeId INT, @ProjectId INT)
AS
BEGIN
	DECLARE @EmployeeProjectCount INT = (SELECT COUNT(*) 
										   FROM EmployeesProjects
										  WHERE EmployeeID = @EmployeeId);

	--Pravim si promenliva ravna na broq na proektite za daden rabotnik.
	
	
	IF(@EmployeeProjectCount >= 3)
		BEGIN
			RAISERROR ('Employee has to many projects !', 16, 1);
			RETURN;
		END
	--ako ima 3 ili poveche proekta hvurlqme greshka !


	INSERT INTO EmployeesProjects
	VALUES (@EmployeeId, @ProjectId);
	--dobavqme proekt !!!

END
GO

EXEC dbo.AddEmployeeToProject 263, 25; --dobavqme proekt s Id 25 kum Rabotnik s Id 263 !
GO

EXEC dbo.AddEmployeeToProject 263, 26; --dobavqme proekt s Id 26 kum Rabotnik s Id 263 !
GO

EXEC dbo.AddEmployeeToProject 263, 27; --Tuk veche dava greshka!
GO


SELECT * FROM EmployeesProjects; --Proverqvame koi kolko proekta ima !

--VAJNO !!! RAISERROE se pishe  edno E !!! Purviq parametur e suobshtenieto 
--Posle e serioznostta na greshkata ot 10 do 25 e FATALNA GRESHKA I SE RAZVURZVA MSSQL !!!.
--Posledniq parametur e STATE, tova e prosto chislo koeto polzvame da razlichavame greshkite.




-- Zd: Withdrwa money from bank account
-- Veche imame napraveni 3 roceduri 
-- p_AddAccount, p_Deposit, p_Withdraw

USE Bank2;

--TOVA E KODA NA PROCEDURATA :
/*
CREATE PROC dbo.p_Withdraw @AccountId INT, @Amount DECIMAL(15,2) AS
BEGIN
	DECLARE @OldBalance DECIMAL(15, 2)
	SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
	IF (@OldBalance - @Amount >= 0)
	BEGIN
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountId
	END
	ELSE
	BEGIN
		RAISERROR('Insufficient funds', 10, 1)
	END
END
GO

*/



--KAK Se POLZVA ?
GO
EXEC dbo.p_Withdraw 1, 100; --We take 100 from accaunt with ID 1
GO
EXEC dbo.p_Deposit 2, 100; 
GO
EXEC dbo.p_AddAccount 3, 2; 
GO
-- Dobavihme i nov account ot tip s ID 2 na Client s ID 3
 
SELECT * FROM Accounts;



/*
	VAJNO !!!
	SUS @@ DOSTUPVAME 'SISTEMNITE PROMENLIVI' !!!
	TE SA OKOLO 40 !!!!!!!!!!!!!!!!!!!

	@@ROWCOUNT ni kazva kolko reda sme promenili !!!
*/
































