

--LEKCIQ !!!




USE test4;
GO

--FUNKCIQTA SE ZAPISVA V TAZI BAZA DANNI KOQTO POLVAME V MOMENTA.
--Funkciq: Imame dve dati i izkarvame kolko sedmici ima mejdu tqh
ALTER FUNCTION udf_ProjectDurationWeeks(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT --return tip
AS
BEGIN
	DECLARE @ProjectWeeks INT; --promenliva
	
	--Proverqvame dali @EndDate e NULL		
	IF(@EndDate IS NULL)
		BEGIN
			SET @EndDate = GETDATE();
		END
	
	IF(@StartDate >= @EndDate)
		BEGIN
			SET @ProjectWeeks = DATEDIFF(WEEK , @EndDate, @StartDate);		
		END
	ELSE
		BEGIN
			SET @ProjectWeeks = DATEDIFF(WEEK , @StartDate, @EndDate);		
		END
	--setvame proenlivata 
		

	RETURN	@ProjectWeeks; -- vrushtame stoinost
END
GO 
--'GO' Oznachava: "IZPULNI VSICHKO PREDI TOVA I POSLE IZPULNQVAI NAPRED !", tova se naricha 'BATCH' !!!
--AKO NQMAME 'GO' CQLOTO NI QUERY SHTE SE IZPULNI KATO EDNA FUNKCIQ.


--KAK SE IZVIKVA ?   VINAGI S dbo. OTPRED
	SELECT dbo.udf_ProjectDurationWeeks('12-10-2016', '12-11-2016')
GO
--MOJEM DA GO POLZVAME I V TABLICI OT DANNI !!!
--MOJEM DA GO DROPVAME !




--Zadacha: Salary level Function!
USE SoftUni;
GO
CREATE FUNCTION ufn_GetSalaryLevel (@Salary money)
RETURNS VARCHAR(20)
BEGIN
	DECLARE @Result VARCHAR(20);

	IF(@Salary < 30000)
	BEGIN
		SET @Result = 'Low';
	END
	ELSE IF(@Salary BETWEEN 30000 AND 50000)
	BEGIN
		SET @Result = 'Average';
	END
	ELSE
	BEGIN
		SET @Result = 'High';
	END
	RETURN @Result;
END
GO

--SUBMITVAME V JUDJE SAMO CREATE FUNKCIQTA BEZ 'GO' ILI DR.
	 SELECT  
			e.FirstName,
			e.LastName,
			e.Salary,
			dbo.ufn_GetSlaryLevel(e.Salary) AS SalaryLevel
	   FROM Employees AS e























