

/*
	Razlika mejdu procedura i funkciq:
	Funkciqta vrushta rezultat dokato procedurata ne, no mojem da q 
	setnem taka che da vrushta rezultat.
	No v takuv sluchai e po dobre da polzvame funkcii.

	Procedurata izvurshva nqkukva operaciq vurhu bazata primerno:
	Iskame da vkarame rabotnici v dadena staq samoche po ime a ne po ID,
	s ID e lesno zashtoto mojem da polzvame mapping tablica, obache po ime
	trqbva da si napravim procedura koqto da izprashta cqla tablica s rabotnici
	kum staq s dadeno ID, procedurata priema kato parametur imenata, namira
	pravilnite IDta i nakraq gi dobavq kum IDto na Staqta.

	PROCEDURATA NE VRUSHTA DADEN REZULTAT KOITO NIE DA OBRABOTVAME.
	

	Podobni sa na funkciite, v tqh ima logika koqto mojem da polzvame na razlichni 
	mesta, priema parametri i moje da izkarva rezultati, Namalq network trafika.


	VAJNO : v papka Programmability/StoredProcedures mojem da si vidim procedurite 


	Izpulnqvat se sus :  EXEC ImeNaProcedura;
*/



-- Sintaxis

GO
CREATE PROCEDURE dbo.urf_SelectEmployeesName
AS
	--tuk si pishem logikata 
	SELECT FirstName, LastName FROM Employees
GO

--Sega v papka Programmability/StoredProcedures mojem da vidim procedurata.


EXEC dbo.urf_SelectEmployeesName;


--MNOOOOOOOGO VAJNOOOOOOOOOOOOOO !!!!!!!!!!!!!
--Mojem da q polzvame v INSERT statement kato dobavqme cqla tablica s neshto kum druga tablica


--S ALTER se promenqt i s DROP se triqt kakto e pri funkciite.



/*
	Procedurite priemat parametri po po razlihen nachin.
	Primer :

	CREATE PROCEDURE NameOfProcedure
	@ParameterOneName ParameterOneType, 
	@ParameterTwoName ParameterTwoType,
	@ParameterThreeName ParameterThreeType, 
	@ParameterFourName ParameterFourType
	AS
		...
	GO

	--t.e. nqmame nujda ot scoup.


	VAJNOOOOOOOOOOOOOOOOO !!!!!!!!!!!!!!!!!!!!!!!!!!!
	OBACHE AKO ISKAME DA PRILOJIM DEFAULT STOINOST SE PISHAT SUS SCOUP KAKTO VUV FUNKCIITE !!!!!!
	
	CREATE PROCEDURE NameOfProcedure(@ParameterOneName ParameterOneType = Stoinost) 
	AS
		...
	GO

*/


/*
	VAJNO : Ako iskame da zapisvame neshta v dadena promenliva i da q dostupvame izvun 
	procedurata polzvame OUTPUT.


	
	CREATE PROCEDURE NameOfProcedure(@ParameterOneName ParameterOneType = Stoinost) 
	AS
		@Promenliva INT OUTPUT;   --S OUTPUT kazvame che mojem da q polzvame i otvun.
		...
	GO


	Primer:
*/


CREATE PROCEDURE dbo.utf_AddNumbers
@FirstNumber INT,
@SecondNumber INT,
@Result INT OUTPUT
AS
	SET @Result = @FirstNumber + @SecondNumber;
GO

--Sega tazi promenliva Result mojem da q polzvame OBACHE :

--1. Deklarirame si promeniva koqto da e sus sushtiq tip kakto @Result
DECLARE @Answare INT;

--2. Chrez EXEC ili EXECUTE si izvikvame Procedurata kato i podavame parametri i kazvame 
--kude da zapisva outputa t.e. rezultata !!!!!!!!
EXECUTE dbo.utf_AddNumbers 5, 3, @Answare OUTPUT;

select 'The result is : ' , @Answare;  --izkarva rezultat 8 zashtoto 5 + 3 = 8
--NO V TAKUV SLUCHAI E PO DOBRE DA POLZVAME FUNKCIQ !!!!!



--Zd. V SoftUni bazata shte zakachim proekti kum rabotnici s PROCEDURA, obache ako rabotnik ima
--poveche ot 3 proekta znachi e prerabotil i trqbva DA VURNEM EXCEPTIION I DA ROLLBACKNEM PROMENITE.
-- Znachi shte imame i tranzakciq koqto da rollbackva v procedurata !!!!!

--use SoftUni


CREATE PROCEDURE dbo.utf_AddProjectToEmployee
(@EmployeeID INT, 
@ProjectID INT)
AS
 
	BEGIN TRANSACTION
	

	--Vkarvame gi v EmployeeProjects tablicata:
	INSERT INTO EmployeesProjects
	VALUES (@EmployeeID, @ProjectID);
	
	
	IF((select COUNT(EmployeeID) FROM EmployeesProjects
		Where EmployeeID = @EmployeeID) > 3)
		BEGIN
			--Ako broqt na rabotnicite v EmployeesProjects tablicata s tova ID e poveche ot 3
			--Hvurlqme greshka i rollbackvame
	
			ROLLBACK
			raiserror('Cannot work in more than three projects at once !', 16, 1);
			--purvo suobshtenieto posle tjesta na exceptiona i nkraq nivoto
			
			return; --naraq returnvame zada prekratim vsichko
		END
	
	--Sled kato sme dali rowback znachi nqma napraven commit i operaciqta se anulira
	
	COMMIT;

GO


--ostava da si testvame procedurata :

--1. vijdame che rabotnik s ID 6 ima 0 proekti
select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 6;


--2. kato si izvikame procedurata s EXECUTE ili EXEC tq trabva da dobavi proekt na nashiq rabotnik
EXEC dbo.utf_AddProjectToEmployee 2, 2;


--3. sega pa kato proverim vijdame che veche ima edin proekt dobaven
select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 2;


--Ako ima 3 i opitame da dobavim oshte shte ni izpishe greshkata kqto suzdadohme.






--Zd. Withdraw money

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


--Shte testvame kato izvadim 23.12 ot akaunt s id 1:

--proverqvame parite v momenta i vijdame che sa 123.12
select * from Accounts
where Id = 1;

--Izteglqme parite
EXEC dbo.usp_WithdrawMoney 1, 23.12;

--I vijdame che sega ima 100
select * from Accounts
where Id = 1;

--Ako opitame da izvadim pari ot akaunt koito ne sushtestvuva`poluchavame greshka koqto napisahme:
EXEC dbo.usp_WithdrawMoney 2131, 23.12;

--Ako opitame da izteglim poveche pari ot kolkoto ima ni hvurlq drugata greshka koqto si napisahme.
EXEC dbo.usp_WithdrawMoney 1, 101;










