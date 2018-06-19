
/*
	Joinove, substringi, common table expressions

*/

use SoftUni

--Inner JOIN vzima vsichki redove koito se machvat t.e. nqmat NULL 
select 
	e.FirstName + ' ' + e.LastName AS FullName, 
	d.Name AS DepartmentName
from Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID;


--LEFT OUTER JOIN vzima vsichi otl1vo nezavisimo dali se matchvat ot dqsno 
	--AKO NE SE MATCHVT SE SLAGA NULL.
--RIGHT OUTER JOIN vzima vsichi otqdsno nezavisimo dali se matchvat ot lqvo
	--AKO NE SE MATCHVT SE SLAGA NULL.

/*
	Imame :

	NEGATED LEFT OUTER JOIN koito e obratno na LEFT JOIN i vrushta vsichki
		redove koito NE sa se matchnali.

	NEGATED RIGHT OUTER JOIN e sushtoto no za RIGHT JOIN.
*/

--FULL OUTER JOIN matchva kakvoto moje, tam kudeto ne moje slaga NULL.

--CROSS JOIN KRASTOSVA VSICHKI REDOVE OT LQVO SUS VSICHKI OT DQSNO. 
--I SE POLUCHAVA KATO OBSHT BROI NA REDOVETE



/*Ako imame igra i iskame vseki rabotnik da igraq sus vseki drug
togava gi krastosvame s CROSS JOIN .*/
select 
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS FullName1, 
	e2.EmployeeID,
	e2.FirstName + ' ' + e2.LastName AS FullName2 
from Employees AS e
CROSS JOIN Employees AS e2
WHERE e.EmployeeID > e2.EmployeeID; /*Pravim tova za da ne se padat edni i sushti igrachi otnovo!*/








--Zd Addresses with Towns
USE SoftUni;

SELECT TOP 50
		   e.FirstName, 
		   e.LastName, 
		   t.Name AS Town, 
		   a.AddressText
	  FROM Employees AS e
	  JOIN Addresses AS a
		ON a.AddressID = e.AddressID
	  JOIN Towns AS t
		ON t.TownID = a.TownID
  ORDER BY e.FirstName, e.LastName;

  /*MNOGO VAJNO: TAKA SE PODREJDAT ZAQVKITE, OTLQVO SA KLUCHOVITE DUMI A OT 
  DQSNO SA DANNITE I MEJDU TEH SE FORMIRA LINIQ KOQTO SE NARICHA REKA !!!!!*/



  --Zd Find all employees in the saled department

  SELECT e.EmployeeID,
  		 e.FirstName,
  		 e.LastName,
  		 d.Name
    FROM Employees AS e
    JOIN Departments AS d
      ON d.DepartmentID = e.DepartmentID
   WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID;


--Zd Rabotnici naeti sled 1/1/1999 ot otdeli Sales i Finance
	 
	SELECT e.FirstName,
		   e.LastName,
		   e.HireDate,
		   d.Name AS DeptName
	  FROM Employees AS e
INNER JOIN Departments AS d
		ON e.DepartmentID = d.DepartmentID
  	 WHERE d.Name IN ('Sales','Finance')
	   AND e.HireDate > '01/01/1999'
  ORDER BY e.HireDate;

  /*VAJNO !!! 
  MOJEM DA FILTRIRAME V SAMOTO JOINVANE NA TABLICITE KATO POLZVAME 'AND' .*/


--Zd Employee Summary top 50

	SELECT TOP 50
			   e.EmployeeID,
			   e.FirstName + ' ' + e.LastName AS EmployeeName,
			   m.FirstName + ' ' + m.LastName AS ManagerName,
			   d.Name AS DepartmentName 
		  FROM Employees AS e
	INNER JOIN Employees AS m
		    ON e.ManagerID = m.EmployeeID
	INNER JOIN Departments AS d
			ON d.DepartmentID = e.DepartmentID
	  ORDER BY e.EmployeeID;	




/*
	SUBQUERIES (Podzaqvki):
	Mojem da vzemem rezultata ot dadeno query i da go polzvame v tablicata.
	V POVECHETO PUTI SE POLZVAT PRI FILTRACIQ, SLED 'WHERE' ILI 
	DIREKTNO SLED FROM!!!

*/


--Zd: Predishna zadacha Min Average salary
SELECT MIN(AverageSalary) AS MinAverageSalary
  FROM (SELECT AVG(e.Salary) AS AverageSalary
	    FROM Employees AS e
	    GROUP BY e.DepartmentID) AS AverageSalariesByDepartment

/* VAJNO !!! :
Pravim si podzaqvka koqto ni hvashta vsichki AVERAGE zaplati za vseki 
departament, davame ime na zaqvkata(AverageSalariesByDepartment) 
i ime na tova koeto hvashta(AverageSalary). 
NAKRAQ IZPOLZVAME IMETATA KOITO SME I DALI V GLAVNATA NI ZAQVKA.*/

--VINAGI SI IMENUVAI PODZAQVKITE !!!


/*
	COMMON TABLE EXPRESSIONS:
	Tova e podzaqvka (SUBQUERY) koqto si ima IME i mojem da q polzvame
	kogato si iskame. POMAGA NI DA NE PISHEM POSTOQNNO EDNa I SUSHTA ZAQVKA.
	SLAGAT SE PREDI PRAVENETO NA QUERY-to !!!!!!!!!!!
*/

--Primer:
WITH CTE_EmployeeInfo (FirstName, LastName, Salary) 
AS
(
	SELECT e.FirstName, e.LastName, e.Salary FROM Employees AS e
)

SELECT * FROM CTE_EmployeeInfo;
/*ZA DA PRORABOTi TRQBVA DA GO POLZVAME INACHE DAVA GRESHKA KATO GO SELEKTNEM
SAMO NEGO !!!*/

--drugo query trqbva i tam da go definirame !!!!!
--SAMOCHE TRQBVA DA SELEKTIRAME I SAZDAVAENTO I !!!!!

/*
	TE NE SA KATO VIEWTATA DA OSTaVAT ZAPAMETENI, 'CTE' IZCHEZVAT SLED KATO 
	GI POLZVAME, NE SE ZAPAZVAT V PAMETTA !!!!!!!!!!!!!!! 

	AKO ISKAME DA GI POLZVAME V DRUGO QUERY TRQQBVA PAK DA GI DEFINIRAME
*/





/*
	Indexi: Narichat se i B-trees:
	Pomagat ni za po burzo tursene na danni, obache zabavqt dobavqneto na n
	novi danni.

	Ima dva vida:
		1.Clustered Indexes - Samite danni ot nashata tablica
		2.Non Clustered Indexes - Durjat se vunshno i sochat kum nashite danni v tablicata.

	Dobavqneto i iztrivaneto na danni ot indexirana tablica stava 
	po bavno. 


	
	CLUSTERED INDEXES:
	
	Clusteriziranite indexi sa samite danni v tablicata.
	Podobrqvat turseneto, polzvaneto na WHERE, ORDER BY i
	GROUP BY.

	MOJE DA IMA MAXIMUM EDIN KLUSTERIZIRAN INDEX ZA EDNA TABLICA.
	AVTOMATICHNO NI GO SUZDAVA KATO SUZDADEM TABLICA, MOJEM DA GO VIDIM 
	V PAPKATA Indexes na dadena tablica.

	POLZVAT SE KATO 'INT', CHESTO PRI 'PRIMARY KEY'

	AKO NQMAME CLUSTERED INDEX NA TABLICATA ZNCHI DANNITE SE 
	PODRJDAT PO NQKAKUV DRUG NACHIN I SE NAMIRAT V (Heap) !!!



	
	NON CLUSTERED INDEXES:
	Te sochat kum dannite v tablicata ni, kato nie mojem da
	gi setvame primerno :
		chisloto 1 da sochi kum bukvata 'a'
		chisloto 2 da sochi kum bukvata 'b'
		. . . 

	MALKO PO BAVNI SA OT CLUSTERED INDEXES
	OBACHE POLZVAT PO MALKO RESURSI OT HARD DISKA,
	ZAPAZVAT SE VUV VUNSHEN FAIL IZVUN BAZATA DANNI !!!

	OCHEVIDNO POLZVA INDEXI ZA DA NAMERI DANNITE ZA TOVA 
	SE POLZVA VURHU CLUSTERED INDEXIRANA TABLICA INACHE
	NQMA PO KAKVO DA SRAVNQVA ZA DA TURSI DANNITE !!!

*/

--Primer:
--Kakuv index e, pishem mu imeto i v koq tablica iskame da go slojim.

/*
	CREATE NONCLUSTERED INDEX
	IX_TableName_WhatToIndex
	ON TableName(WhatToIndex)
*/


--KOGATO NAPRAVIM DADEN INDEX DA tURSI DADENO NESHTO V DADENA TABLICA
--TOVA TURSENE STAVA PO BURZO.
--POLZVAT SE RAZLICHNI INDEXI ZA RAZLICHNI TURSENIQ V DADENA TABLICA.








/*
	SUMMARY:
		1. JOINS: INNER, LEFT, RIGHT, FULL, CROSS - znaem gi
		2. SUBQUERIES - zaqvka v zaqvka
		3. CTE (Common Table Expression) - subquery s ime, pomaga da ne 
			polzvame daden kod mnogo puti, ne ostava v pametta.
		4. INDEXES - Pomagat za turseneto no ne i za dobavqneto i trieneto
			Clutered i Non Clustered
*/



























