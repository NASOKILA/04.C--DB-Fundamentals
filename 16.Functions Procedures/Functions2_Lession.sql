
USE test4;
GO

ALTER FUNCTION udf_ProjectDurationWeeks(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT 
AS
BEGIN
	DECLARE @ProjectWeeks INT; 
		
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

	RETURN	@ProjectWeeks; 
END
GO 

	SELECT dbo.udf_ProjectDurationWeeks('12-10-2016', '12-11-2016')
GO

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

	 SELECT  
			e.FirstName,
			e.LastName,
			e.Salary,
			dbo.ufn_GetSlaryLevel(e.Salary) AS SalaryLevel
	   FROM Employees AS e
