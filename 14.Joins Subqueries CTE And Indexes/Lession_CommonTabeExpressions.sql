
WITH Employees_CTE (FullName, DepartmentName)
AS
(  
	select e.FirstName + ' ' + e.LastName AS Fullname, d.Name
	from Employees AS e
	join Departments AS d
	ON e.DepartmentID = d.DepartmentID
) 
select * from Employees_CTE;

--USE Demo
With CTE_Heron(A, B, C, S)
AS
(
	select A,B,C,
	(A + B + C) / 2 AS S 
	from Triangles
) 
Select 
SQRT(S * (S-A)*(S-B)*(S-C)) AS Area
 from CTE_Heron

 --DataAggregation : Select the depost group with the lowerest average wand size
 --Use Gringotts
 select DepositGroup from WizzardDeposits
 WHERE MagicWandSize  =	(
							select TOP (1) 
								AVG(MagicWandSize)  
							from WizzardDeposits
							GROUP BY DepositGroup
							Order BY AVG(MagicWandSize)  
						) 
GROUP BY DepositGroup;
