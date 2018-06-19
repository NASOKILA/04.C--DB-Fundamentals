

--01. Employees with salary above 35000

CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	
		SELECT FirstName, LastName FROM Employees
		WHERE Salary > 35000;
GO
--Ne slagai GO v Judja

--EXEC dbo.usp_GetEmployeesSalaryAbove35000;




--02.Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@Number money)
AS
	select 
		FirstName, LastName
	From Employees	
	WHERE Salary >= @Number;
GO
--Ne slagai GO v Judja

--EXEC usp_GetEmployeesSalaryAboveNumber 48100;




--03.Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith(@Str varchar(max))
AS
	select 
		Name
	FROM Towns
	Where left(Name, LEN(@Str)) = @Str;
GO	
--Ne slagai GO v Judja

--EXEC dbo.usp_GetTownsStartingWith 'Bor';


--04. Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown(@TownName varchar(MAX))
AS
	select 
		e.FirstName, e.LastName
	from Employees AS e
		JOIN Addresses AS a
		ON e.AddressID = a.AddressID
		JOIN Towns AS t
		ON a.TownID = t.TownID
	WHERE t.Name = @TownName;
GO
--Ne slagai GO v Judja

--EXEC dbo.usp_GetEmployeesFromTown 'Sofia';



--05. Salary Level Function

CREATE FUNCTION ufn_GetSalaryLevel (@salary money)
RETURNS varchar(max)
BEGIN

	DECLARE @Result varchar(MAX);

	IF(@salary < 30000)
	BEGIN 
		SET @Result = 'Low';
	END

	IF(@salary > 50000)
	BEGIN 
		SET @Result = 'High';
	END

	IF(@salary BETWEEN 30000 AND 50000)
	BEGIN 
		SET @Result = 'Average';
	END

	RETURN @Result;

END


/*
SELECT 
	Salary,
	dbo.ufn_GetSalaryLevel2(Salary) AS SalaryLevel 
FROM Employees
*/



--06. Employees by Salary Level

CREATE PROCEDURE usp_EmployeesBySalaryLevel (@Level varchar(MAX))
AS

	select
		FirstName,
		LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @Level;	
GO
--Ne slagai GO v Judja

--EXEC dbo.usp_EmployeesBySalaryLevel 'High';




--07. Define Function

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters varchar(MAX), @word varchar(MAX))
RETURNS BIT
AS
BEGIN

	DECLARE @Counter INT = 1;
	WHILE(@Counter <= LEN(@word))
	BEGIN                           --@WordCopy
		DECLARE @LetterOfWord varchar(1) = SUBSTRING(@word, @Counter, 1);

		DECLARE @ContainableLetter BIT = 0
		DECLARE @Counter2 INT = 1;
		WHILE(@Counter2 <= LEN(@setOfLetters))
		BEGIN
			IF(SUBSTRING(@setOfLetters, @Counter2, 1) = @LetterOfWord)
			BEgiN
				SET @ContainableLetter = 1;
				BREAK;
			END
			
			SET @Counter2 += 1; 
		END

		IF(@ContainableLetter = 0)
		 BEGIN
			return 0;
		 END
		 
		SET @Counter += 1;
	END

		return 1;	 
END

/*
	--TEST
select 
	'pppp' AS SetOfLetters,
	'guy' AS Word,
	dbo.ufn_IsWordComprised('pppp', 'guy') AS Result
*/
--VAJNOOOO !!! TUK MOJEHME DA POLZVAME CHARINDEX() <= 0  VMESTO DVA VGRADENI CIKULA
SELECT CHARINDEX('t', 'Customer') AS MatchPosition; -- dava kolko takuva bukvi ima v stringa !




	--08. Delete Employees and Departments

	
	--Setvame managerId-to v tablicata Departments
	AltER TaBLE Departments
	Alter column ManagerId int NULL

	--Namirame slujitelite koito trqbva da iztriem te sa 185 choveka:
	select EmployeeID FROM Employees AS e
		JOIN Departments As d
		ON d.DepartmentID = e.DepartmentID
		WHERE d.Name IN ('Production', 'Production Control');

	--ZA DA MOJEM DA IZTRIEM TEZI HORA
	--1.Trqbva da gi ot iztriem EmployeesProjects
	--2.Trqbva da vidim ako tezi hora sa menidgeri na nqkoi i da gi mahnem kato menidgeri
	--3.Na koi departamenti sa menidjeri i da im setnem menidgerId na null

	DELETE FROM EmployeesProjects 
	WHERE EmployeeID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));

	--Setvame ManagerId na NULL na vseki koito Menidger e edin ot tezi hora koito iskame da iztriem
	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));
	
	--Pravim sushtoto za departamentite, ako ima departament chiito menidger 
	--e nqkoi ot tezi hora, setvame mu MenidgerId na NULL
	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));
	
	--Sega trqbva da iztriem horata i Departamentite
	DELETE FROM Employees
	WHERE EmployeeID IN  (select EmployeeID FROM Employees AS e
						 JOIN Departments As d
						 ON d.DepartmentID = e.DepartmentID
						 WHERE d.Name IN ('Production', 'Production Control'));

	DELETE FROM Departments
	WHERE Name IN ('Production', 'Production Control'); 






--09.

CREATE PROCEDURE usp_AssignProject
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
			raiserror('The employee has too many projects!', 16, 1);
			--purvo suobshtenieto posle tjesta na exceptiona i nkraq nivoto
			
			return; --naraq returnvame zada prekratim vsichko
		END
	
	--Sled kato sme dali rowback znachi nqma napraven commit i operaciqta se anulira
	
	COMMIT;

GO

/*
--ostava da si testvame procedurata :

--1. vijdame che rabotnik s ID 6 ima 0 proekti
select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 6;


--2. kato si izvikame procedurata s EXECUTE ili EXEC tq trabva da dobavi proekt na nashiq rabotnik
EXEC dbo.utf_AddProjectToEmployee 6, 7;


--3. sega pa kato proverim vijdame che veche ima edin proekt dobaven
select NumberOfProjects = COUNT(EmployeeID) FROM EmployeesProjects
	Where EmployeeID = 2;


--Ako ima 3 i opitame da dobavim oshte shte ni izpishe greshkata kqto suzdadohme.
*/




-- MNOOOGO JAVNOOOO ! Mojem da pishem promenlivi ot tip TABLE i da zapisvame tablici v tqh.