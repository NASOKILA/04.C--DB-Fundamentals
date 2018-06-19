	



/*
	Shte razgledame :
	1.Funkcii
	2.Transakcii
	3.Proceduri
	4.Trigeri


	Mejdu funkcii i proceduri ima malka razlika

*/
	
	
	
/*

	Funkcii:
	V SQL imame 3 vida funkcii:

	1.Scalar (skalarni) kato SQRT(...) koito ot razlichen 
	broi parametri vadat edna stoinost. Te sa kato Build-In-Functions

	2. Table-Valued functions kato (SELECT) koito vrushtat cqla tablica

	3.Agregirashti funkcii veche gi vidqhme, polzvat se v .NET ne moje 
	prosto v SQL, ponqkoga se iziskva grupirane na danni.

	NOJEM DA GI NAMERIM V PAPKATA Programmability i posle Functions.
*/


CREATE FUNCTION udf_ProjectDurationWeeks   --Ime na funkciqta
(@StartDate DATETIME, @EndDate DATETIME)   --Parametri
RETURNS INT								   --kakvo vrushta
AS
BEGIN
	--tuk si pishem koda:

	DECLARE @ProjectWeeks INT; --pravim si int promeniva 
	
	IF(@EndDate IS NULL) -- if()
	BEGIN
		--Ako @EndDate e NULL go setvame na ssegashnata data	
		SET @EndDate = GETDATE()
	END

	SET @ProjectWeeks = DATEDIFF(WEEK, @StartDate, @EndDate);
	--setvame na razlikata mejdu @StartDate i @EndDate v sedmici.
	--Dava ni broq na sedmicite.

	RETURN @projectWeeks; -- vrushtame si rezultata

END


--KAK SE POLZVA ?
--Slagame rezultata ot tazi funkciq kato i slojim koito parametri si iskame.
-- VAJNO !!! : TRQBVA DA NAPISHEM OTPRED dbo. INACHE NQMA DA SE SETI ENGINA !!!!


SELECT 
	ProjectID,
	StartDate,
	EndDate,
	dbo.udf_ProjectDurationWeeks(StartDate, EndDate) AS ProjectWeeks
FROM Projects
--parametrite mojem da gi napishem i po drug nachin primerno: '20150101', GETDATE()

--VAJNO : AKO ISKAME DA NE GO PODCHERTAVA V CHERVENO TRQBVA DA E EDINSTVENOTO
--NESHTO V TOVA QUERY, OBACHE PAK SHTE SI RABOTI !!!!!!!





--Zd 1. 

CREATE FUNCTION ufn_GetSalaryLevel(@Salary money)
RETURNS varchar(30)
AS
BEGIN

	--if salary is < 30000 pishem Low, if  > 30000 and < 50000 pishem Average
	--if > 50000 pishem High

	IF(@Salary < 30000)
	BEGIN
		RETURN 'Low'
	END
	
	ELSE IF(@Salary > 30000 AND @Salary > 50000)
	BEGIN
		RETURN 'Average'
	END

		RETURN 'High'
END

--VAJNO : Mojem da promenim funkciqta s ALTER vmesto da q triem i pak da q suzdavame !!!!
Select 
	FirstName, 
	LastName,
	dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevel
From Employees





/*
	KAK SE DEBUGVA ?
	Ami imame butonche Debug i kato go cuknem zapochva
	da debugva ot purviq red, i ot meniuto kato cuknem na
	Debug vijdame vsichko koeto mojem da pravim. Imame si vsichko.
*/



--PRIMERI S CIKLI

--Ima samo edin cikul koito e WHILE.

CREATE FUNCTION utf_Loops(@Param INT)
RETURNS bit   --bit e kato boolean, priema samo 0 i 1
AS
BEGIN
	--VUV FUNKCIITE NE MOJEM DA POLZVAME PRINT, TE TRQBVA DA SA CHISTI.
		
	--While() loop
	WHILE(@Param > 0)
	BEGIN
		SET @Param = @Param - 1
	END
	
END




--Shte reshavame zadachi ot predishni lekcii
--Use Gringotts


create function utf_GetAgeGroup(@Age INT)
RETURNS varchar(7)
AS
BEGIN

	DECLARE @Lower INT = (((@Age - 1) / 10) * 10 + 1);
	DECLARE @Upper INT = @Lower + 9;

		IF(@Lower = 1)
		SET @Lower = 0;

	RETURN CONCAT('[', @Lower, '-', @Upper, ']');

END

--Vijdame za vseki edin sobstvenik na deposit vuzrastovata grupa !!!
SELECT 
	dbo.utf_GetAgeGroup(Age) AS AgeGroup
FROM WizzardDeposits
GROUP BY dbo.utf_GetAgeGroup(Age)



--Zd. Heron's formula for Area of triangle
--USE Demo

CREATE FUNCTION utf_GetArea(@A FLOAT, @B FLOAT, @C FLOAT)
RETURNS DECIMAL(8,2)
AS
BEGIN
	
	DECLARE @S FLOAT = (@A + @B + @C) / 2;

	DECLARE @Area DECIMAL(8,2) = SQRT(@S * (@S - @A)*(@S - @B)*(@S - @C))

	RETURN @Area
END

select 
	A,
	B,
	C,
	dbo.utf_GetArea(A, B, C) AS Area
from Triangles


--MNOGO VAJNO : VMESTO dbo.utf_GetArea(A, B, C) AS Area MOJEM DA PISHEM:
-- Area = dbo.utf_GetArea(A, B, C)  !!! SUSHTOTO E !!!
select 
	Area = dbo.utf_GetArea(A, B, C)
from Triangles




--Zd. Funkciq koqto da priema nqkakuv text i duljina i da vrushta nqkakuv text
--Shte sukrashtavame imenata na rabotnicite

CREATE FUNCtION udf_Summarize(@Text varchar(MAX), @Length INT)
RETURNS varchar(MAX)
AS
BEGIN
	DECLARE @result varchar(MAX);

	IF(LEN(@Text) <= @Length)
	BEGIN
		SET @result = @Text
	END

	ELSE
		SET @result = SUBSTRING(@Text, 0, @Length + 1) + '...' 
		--vzimame ot 0 do @Lengthiq element, MOJEM DA POLZVAME I LEFT(@Text, @Length)
		--I dobavqme tochicite.

	RETURN @result;
END


select 
	FirstName,
	dbo.udf_Summarize(FirstName, 5) As Summary
from Employees




/*
	VAJNO : 'GO' OZNACHAVA 'IZPULNI VSICHKI ZAQVKI DO MOMENTA I OSLE PRODULJI !!!'
*/








