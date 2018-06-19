



/*
(CTE) - Common Table Expressions
Te sa podobni na Subqueritata, te sa imenuvani subquerita.
Polzva se kogato imame reusable code da ne pishem edin i sushti kod dva puti


Imenuvat se predi suzdavane na samoto query: 

WITH CTE_Name(ColumnA, ColumnB)
AS
(
	--Subquery goes here
)


CTE e kato VIEW samoche ne ostavq obekt v bazata dokato VIEWto ostavq, CTEto 
se iztriva sled prikluchvaneto na zaqvkata.

*/


--Primer:
    -- Shte selektirame si imenata i imeto na departamenta za vseki rabotnik.

WITH Employees_CTE (FullName, DepartmentName)
AS
(  
	select e.FirstName + ' ' + e.LastName AS Fullname, d.Name
	from Employees AS e
	join Departments AS d
	ON e.DepartmentID = d.DepartmentID
) 
select * from Employees_CTE;
--Sega mojem ot tova Employees_CTE da selektirame kakvoto si iskame.
--ZA DA PRORABOTI TRQBVA DA SELEKTIRAME VSICHKO ZAEDNO t.e. I CTE-to i SELEKTA SLED TOVA !!!

--USE Demo

--Shte reshim predishna zadacha s CTE, tazi s liceto na triugilnika:
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

--SAM YEAHHHHHHHHH !!!!


 --Zd 4 ot DataAggregation : Select the depost group with the lowerest average wand size
 --Use Gringotts
--SHTE Q RESHIM SUS SUBQUERY:


 select DepositGroup from WizzardDeposits
 WHERE MagicWandSize  =	(
							select TOP (1) 
								AVG(MagicWandSize)  
							from WizzardDeposits
							GROUP BY DepositGroup
							Order BY AVG(MagicWandSize)  
						) 
GROUP BY DepositGroup;

 --Suzdadohme si ubqury koeto vrushta minimalnata sredna stoinost na vseki departament
 --i q izpolzvahme v where i nakraq grupirame
 --Mojehme da polzvame WITH TIES
 











































