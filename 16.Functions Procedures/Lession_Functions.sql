
CREATE FUNCTION udf_ProjectDurationWeeks  
(@StartDate DATETIME, @EndDate DATETIME)   
RETURNS INT								  
AS
BEGIN

	DECLARE @ProjectWeeks INT;
	
	IF(@EndDate IS NULL) 
	BEGIN
		
		SET @EndDate = GETDATE()
	END

	SET @ProjectWeeks = DATEDIFF(WEEK, @StartDate, @EndDate);

	RETURN @projectWeeks; 

END

SELECT 
	ProjectID,
	StartDate,
	EndDate,
	dbo.udf_ProjectDurationWeeks(StartDate, EndDate) AS ProjectWeeks
FROM Projects

CREATE FUNCTION ufn_GetSalaryLevel(@Salary money)
RETURNS varchar(30)
AS
BEGIN

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

Select 
	FirstName, 
	LastName,
	dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevel
From Employees

CREATE FUNCTION utf_Loops(@Param INT)
RETURNS bit   
AS
BEGIN
	WHILE(@Param > 0)
	BEGIN
		SET @Param = @Param - 1
	END
END

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

SELECT 
	dbo.utf_GetAgeGroup(Age) AS AgeGroup
FROM WizzardDeposits
GROUP BY dbo.utf_GetAgeGroup(Age)

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

select 
	Area = dbo.utf_GetArea(A, B, C)
from Triangles

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
	RETURN @result;
END

select 
	FirstName,
	dbo.udf_Summarize(FirstName, 5) As Summary
from Employees
