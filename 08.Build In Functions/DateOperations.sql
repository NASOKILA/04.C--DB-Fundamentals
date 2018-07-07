


SELECT GETDATE(); 

SELECT DATEPART(YEAR, GETDATE()); 



USE SoftUni
SELECT TOP (1000) [EmployeeID]
      ,[HireDate]
	  ,DATEPART(QUARTER, HireDate) AS Quarter
	  ,DATEPART(YEAR, HireDate) AS Year
	  ,DATEPART(MONTH, HireDate) AS Month
	  ,DATEPART(DAY, HireDate) AS Day
FROM [SoftUni].[dbo].[Employees]

SELECT DATEDIFF(MONTH, '1998-01-23', '1998-07-31'); 

SELECT DATEDIFF(DAY, '1998-01-23', '1998-07-31'); 

SELECT DATEDIFF(HOUR, '1998-01-23', '1998-07-31'); 


SELECT DATENAME(WEEKDAY, GETDATE()); 

SELECT DATENAME(MONTH, GETDATE()); 

SELECT DATENAME(DAYOFYEAR, GETDATE()); 


SELECT DATEADD(MONTH, 2, GETDATE()); 

SELECT DATEADD(YEAR, 2, GETDATE()); 


SELECT CAST(2.56 AS int); 

SELECT CONVERT(int, 2.56);


SELECT 
FirstName,
ISNULL(MiddleName, 'Nqma Sredno Ime !!!'),
LastName
FROM Employees


SELECT 
EmployeeId,
FirstName,
LastName
FROM Employees
ORDER BY EmployeeId
OFFSET 10 ROWS     
FETCH NEXT 5 ROWS ONLY
