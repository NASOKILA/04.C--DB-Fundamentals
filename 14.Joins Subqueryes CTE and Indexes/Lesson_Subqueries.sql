

/*
	Subqueries :

	MALKO PO BAVNI SA OT JOIN, AKO MOJEM DA POLZVAME JOIN SHTE BUDE PO DOBRE !!!!!!!!!!!!!!!

	Shte razgledame i Manipulaciq na querita na mnogo niva

	Subqueritata sa polezni kogato iskame da vzemem neshto ot dadena tablica
	obache polzvaiki uslovie ot druga tablica.

	Primerno iskame vsichki rabotnici v daden departament obache ne znaem IDto na
	departamenta a samo negovoto ime. Mojem da polzvame JOIN ili Subquery.
*/



--use SoftUni

--Nie ne znaem IDto a samo Imeto sledovatelno si pravim zaqvka koqto da namira IDto 
-- i q slagame v WHERE(DepartmentID = (...)) za da namerim tozi departament !!!!!!!

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






--Zd 1. Nameri AREAta na triugulnika po formulata na Heron.
-- Area = koren kvadraten ot ( s(s-a)(s-b)(s-c) )
-- s = (A + B + C) / 2

--use Demo

SELECT
	t1.Id,
	SQRT( t1.s * (t1.s - t1.A) * (t1.s - t1.B) * (t1.s - t1.C) ) AS Area 
FROM (select Id,A, B, C, (A + B + C) / 2 AS s from Triangles) AS t1
--Sled kato si naravim vutreshna tablica mojem ot neq da izvikame 's'   t1.s !!!



--Zd 2. Da namerim nai niskata sredna zaplata za departament

--USE SoftUni

-- da namerim purvo s query AVG na zaplatite za vseki edin departament i da mu dadem ime
-- i polse ot nego selektirame MIN(DadenotoIme)

select MIN(Average) AS AverageMinSalary from 
(select DepartmentID ,AVG(Salary) AS Average from Employees
Group BY DepartmentID) AS computed;


--Za da vzemem trqtata po golemina polzvame 'offset' i 'fetch' sled ORDER BY ... :

select DepartmentID ,AVG(Salary) AS ThirdAverage from Employees
Group BY DepartmentID
order by ThirdAverage DESC
offset 2 rows
fetch next 1 row only;


/*
	VAJNO !!! : ORDER BY ne moje da se polzva v subquerita, viewta, funkcii i dr.
*/

/*
TAKA TAVA GREHKA ZASHTOTO IMAME    ORDER BY  !!!!!!!!!
 
(select DepartmentID ,AVG(Salary) AS ThirdAverage from Employees
Group BY DepartmentID
order by ThirdAverage DESC)

*/

--Zatova shte polzvame DENSE_RANK() over (order by AVG(Salary)) i mahame ORDER BY !!!
Select * from
(select 
		DepartmentID,
		AVG(Salary) AS ThirdAverage,
		DENSE_RANK() over (order by AVG(Salary)) AS Ranking
		from Employees
Group BY DepartmentID) as t1
where t1.Ranking = 3;
--sega veche mojem da slojim vsichko v subquery i da selektirame kakvoto si iskame !!!!!!
--V sluchaq selektirame tam kudeto ranking e = na 3 

/*
	RANK() e kato DENSE_RANK() samoche ako imame dve ravni stoinosti primerno 
	na vtora poziciq i iskame da selektirame vtorata stoinost shte ni gi vurne i dvete,
	t.e. i dvete shte budat vtori i nqma da ima treta a napravo 4ta.
	Dokato DENSE_RANK() ni gi podrejda po red dori i da imame dve ravni ednoto trqbva da
	e predi drugoto.
*/

/*
	ROW_NUMBER E KATO DENSE_RANK()
*/
























