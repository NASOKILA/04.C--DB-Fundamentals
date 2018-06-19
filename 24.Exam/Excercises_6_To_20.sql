


--06

select Description, OpenDate from Reports where EmployeeId IS NULL
ORDER BY OpenDate, Description

--07
select e.FirstName, 
		e.LastName, 
		r.Description, 
		FORMAT(r.OpenDate , 'yyyy-MM-dd') AS  OpenDate
   from Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id
ORDER BY e.Id, r.OpenDate, r.Id


select e.FirstName, 
		e.LastName, 
		r.Description, 
		CONVERT(DATE, r.OpenDate) AS OpenDate
   from Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id
ORDER BY e.Id, r.OpenDate, r.Id



--08
	select c.Name, COUNT(r.Id) AS ReportsNumber 
	from Categories AS c
	JOIN Reports AS r ON r.CategoryId = c.Id
	GROUP BY c.Name
	ORDER BY  COUNT(r.Id) DESC, c.Name;



	--09

	select c.Name, COUNT(e.Id) AS [Employees Number]
	from Categories AS c
	JOIN Departments AS d ON c.DepartmentId = d.Id
	JOIN Employees AS e ON e.DepartmentId= d.Id
	GROUP BY c.Name
	ORDER BY c.Name



	--10
		SELECT 
			e.FirstName + ' ' + e.LastName AS [Name],
			COUNT(r.UserId) AS [Users Number]
		FROM Employees AS e
		LEFT JOIN Reports AS r ON e.Id = r.EmployeeId
		GROUP BY e.FirstName + ' ' + e.LastName
		ORDER BY [Users Number] DESC, [Name] 




	--11.
		 select r.OpenDate, 
				r.Description, 
				u.Email AS [Reporter Email]

		from Reports AS r
		JOIN Categories AS c ON c.Id = r.CategoryId
		JOIN Departments AS d ON d.Id = c.DepartmentId
		JOIN Users AS u on u.Id = r.UserId
		WHERE (CloseDate IS NULL) 		
		AND Description LIKE '%str%'
		AND LEN(Description) > 20
		AND d.Name IN ('Infrastructure', 'Emergency', 'Roads Maintenance') 
		ORDER BY r.OpenDate, u.Email, r.Id


		--12.
		SELECT c.Name 
		FROM Categories AS c
		JOIN Reports AS r ON r.CategoryId = c.Id
		JOIN Users AS u ON u.Id = r.UserId 
		WHERE DATEPART(DAY, u.BirthDate) = DATEPART(DAY, r.OpenDate)
		AND DATEPART(MONTH, u.BirthDate) = DATEPART(MONTH, r.OpenDate)
		GROUP BY c.Name  
		ORDER BY c.Name



		--13.

			select u.Username FROM Users AS u
			JOIN Reports AS r ON r.UserId = u.Id
			JOIN Categories AS c ON c.Id = r.CategoryId
			WHERE
				(u.Username LIKE '[0-9]%' AND c.Id = SUBSTRING(u.Username, 1, 1))
				
				UNION
			select u.Username FROM Users AS u
			JOIN Reports AS r ON r.UserId = u.Id
			JOIN Categories AS c ON c.Id = r.CategoryId
			WHERE
				(u.Username LIKE '%[0-9]' AND c.Id = SUBSTRING(u.Username, LEN(u.Username), 1))






--14. NOT FINISHED



 DECLARE @num1 INT = 1;
 DECLARE @num2 INT = 1;
 SELECT 
		e.FirstName + ' ' + e.LastName AS [Name],
		(@num1 + ' + ' + @num2 )
		 
		
 FROM Employees AS e
 JOIN Reports AS r ON r.EmployeeId = e.Id
 WHERE DATEPART(Year,r.OpenDate) = '2016' OR DATEPART(Year,r.CloseDate) = '2016'
 GROUP BY e.FirstName + ' ' + e.LastName, e.Id
 ORDER BY [Name], e.Id



 SELECT 
		e.FirstName + ' ' + e.LastName AS [Name],
		COUNT(r.Id)
 FROM Employees AS e
 JOIN Reports AS r ON r.EmployeeId = e.Id
 WHERE DATEPART(Year,r.OpenDate) = '2016' OR DATEPART(Year,r.CloseDate) = '2016'
 ORDER BY e.FirstName + ' ' + e.LastName, e.Id


 --15.


 select d.Name, ISNULL(CAST(AVG(DATEDIFF(DAY, r.OpenDate, r.CloseDate)) AS VARCHAR(MAX)),'no info') 
 FROM Reports AS r
 JOIN Categories AS c ON c.Id = r.CategoryId
 JOIN Departments AS d ON d.Id = c.DepartmentId
 GROUP BY d.Name






--16




--17.
GO
CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT
AS
BEGIN
	DECLARE @Result INT = (
						select ISNULL(COUNT(r.Id),0) from Reports AS r
						WHERE r.EmployeeId = @employeeId AND r.StatusId = @statusId)
	RETURN @Result;
END
GO

SELECT Id, FirstName, Lastname, dbo.udf_GetReportsCount(Id, 2) AS ReportsCount
FROM Employees
ORDER BY Id



SELECT dbo.udf_GetReportsCount(22, 2);

select COUNT(*) from Reports AS r Where EmployeeId = 22 AND StatusId = 2 
	







--18.
GO
CREATE PROC usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
AS
BEGIN

	DECLARE @EmployeeDepartmentId INT =
	(select e.DepartmentId 
		FROM Employees AS e 
		WHERE  e.Id = @employeeId)

	DECLARE @ReportsCategoryDepartmentId INT =
	(select c.DepartmentId FROM Reports AS r 
		JOIN Categories AS c ON c.Id = r.CategoryId
		WHERE  r.Id = @reportId) 
	
	BEGIN TRAN
	--If the department of the employee and the department of the report’s category are the same
	IF(@EmployeeDepartmentId <> @ReportsCategoryDepartmentId)
		BEGIN
			ROLLBACK;
			RAISERROR('Employee doesn''t belong to the appropriate department!',16,1)
			RETURN;	
		END

		UPDATE Reports
		SET EmployeeId = @employeeId
		WHERE Id = @reportId

		COMMIT;

END
GO



EXEC usp_AssignEmployeeToReport 17, 2;
SELECT EmployeeId FROM Reports WHERE id = 2










--19.
GO
CREATE TRIGGER TR_ChangeStatus ON Reports
AFTER UPDATE
AS
BEGIN
		
		UPDATE Reports
		SET StatusId = 3
		WHERE Id IN (SELECT Id FROM inserted)
		AND StatusId IN (SELECT StatusId FROM inserted where StatusId <> 3)
		
END
GO



BEGIN TRAN
	UPDATE Reports
	SET CloseDate = GETDATE()
	WHERE Id IN (5,4,1);
ROLLBACK;





UPDATE Reports
SET CloseDate = GETDATE()
WHERE EmployeeId = 5;



select * from Reports WHERE StatusId = 3

--


















