
--use SoftUni
select 
	FirstName + ' ' + LastName AS [Full Name], 
	JobTitle 
From Employees
Where DepartmentID = 
	(
	select DepartmentID From Departments
	where Name = 'Sales'
	)
ORDER BY [Full Name];

--use Demo
SELECT
	t1.Id,
	SQRT( t1.s * (t1.s - t1.A) * (t1.s - t1.B) * (t1.s - t1.C) ) AS Area 
FROM (select Id,A, B, C, (A + B + C) / 2 AS s from Triangles) AS t1

--USE SoftUni
select MIN(Average) AS AverageMinSalary from 
(select DepartmentID ,AVG(Salary) AS Average from Employees
Group BY DepartmentID) AS computed;

select DepartmentID ,AVG(Salary) AS ThirdAverage from Employees
Group BY DepartmentID
order by ThirdAverage DESC
offset 2 rows
fetch next 1 row only;

Select * from
(select 
		DepartmentID,
		AVG(Salary) AS ThirdAverage,
		DENSE_RANK() over (order by AVG(Salary)) AS Ranking
		from Employees
Group BY DepartmentID) as t1
where t1.Ranking = 3;
