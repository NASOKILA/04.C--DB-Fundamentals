
/*
	Shte razgledame :
	1.Joins
	2.Subqueries
	3.Common Table Expression (CTE)

	CTE - Te sa podobni na subqueritata, tova sa preizpolzvaemi 
	subquerita.
	Imenuvat se predi pisaneto na nasheto query i polse mojem da
	si gi izvikame po vsqko vreme.

	4.Indexes  - T.e. kak da napravim taka che tablicata da raboti 
	po burzo pri tursene i joinvane na tablici

*/

/*
	1.Joins:
	Po nqkoga ni trqbva informaciq ot dve ili poveche tablici 
	zatova polzvame JOIN
	
	Imame 3 vida Joinove: 
	1.InnerJoin
	2.OuterJoin koito moje da e lqv, desen ili pulen
	(Left, Rifght or Full)
	3.CrossJoin

	Nai chesto polzvaniq e InnerJoin i nie shte go polzvame nai chesto.
	Na momenti nqma znachenie dali shte polzvame Inner ili Outer zaradi 
	strukturata na nqkoi bazi danni.

	1.InnerJoin - oznachava da vzemem stoinostite or redovete ot dvete 
	tablici samo ako uslovieto e vqrno i za dvete tablici. 
	
	Obache stoinostite trqbva da suvpadat edin s drug PRIMERNO:
	Imame tablica rabotnici i departamenti i iskame da selektirame vsichki 
	rabotnici i tehnite departamenti, obache ako daden departament e NULL 
	znachi nqma da selektira dadeniq red.


	2.OuterJoin - Razlikata mejdu Left i right e nachina po koito zapisvame 
	tablicite.

	OuterJoin Left - Ozn vzemi stoinostite ot purvata tablica i zakachi na neq 
	tezi ot vtorata, ako nqma dostatuchno zapisi vuv vtorata tablica, 
	se zapisva v purvata NULL.

	OuterJoin Right - Ozn vzemi stoinostite ot vtorata tablica i zakachi na neq 
	tezi ot purvata, ako nqma dostatuchno zapisi v purvata tablica, 
	vuv vtorata se zapisva NULL.
	
	OuterJoin vrushta vsichki stoinosti ot innerJoin vkluchitelno i tezi koito 
	NE suvpadat ot purvata ili ot vtorata tablica nezavisimo Left ili Right.

	OuterJoinFull -	Vrushta vsichki zapisi, kudeto ne moje da zakachi stoinost 
	zakacha NULL


*/


--InnerJoin Primer:

--CREATE DATABASE Test3;
--USE Test3;

CREATE TABLE Departments(
	DepartmentID INT PRIMARY KEY,
	DepartmentName varchar(50)
)

CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY,
	DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
)

INSERT INTO Departments
VALUES
(3,'Sales'),
(4,'Marketing'),
(5,'Purchasing');

INSERT INTO Employees
VALUES
(263,3),
(270, NULL);


SELECT * FROM Employees AS e
INNER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

/*
Pokazva ni samo edno zashtoto v Employees tablicata vtoriq red DepartmentID 
e NULL, i v Employees nqmame dostatuchno danni za Marketing i Purchasing ot 
Departments tablicata. Za tova ni pokazva samo edin zapis. Taka raboti INNER JOIN 
*/

--Mojem da napishem samo JOIN, po default go smqta za INNER JOIN.
SELECT * FROM Employees AS e
JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID



--Left Outer Join
/*
	Vrushta ni purviq red, na vtoriq red vzima kakvoto moje ot dqsnata 
	tablica i go zalepva kum lqvata. Kudeto ne moje, slaga NULL.
*/
SELECT * FROM Employees AS e
LEFT OUTER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Mojem da naishem samo LEFT JOIN



--Right Outer Join
/*
	Vrushta ni purviq red, na vtoriq red vzima kakvoto moje ot lqvata 
	tablica i go zalepva kum dqsnata. Kudeto ne moje, slaga NULL.
*/
SELECT * FROM Employees AS e
RIGHT OUTER JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID

--Mojem da naishem samo RIGHT JOIN



/*
	VAJNO !!! : REDA PO KOITO PISHEM JOIN ZAQVKATA IMA ZNACHENIE !!!
	Ako napishem purvo Departments i posle joinem Employees shte ima razlika:

	SELECT * FROM Departments AS e
	RIGHT OUTER JOIN Employees AS d 
	ON e.DepartmentID = d.DepartmentID
*/



--Full Join:
/*
	Vzima i ot dvet tablici kakvoto moje i kudeto nqma danni dobavq NULL !!!
*/
SELECT * FROM Employees AS e
FULL JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID



--Cross Join:
/*
	Toi suvpada vsichko ot purvata tablica sus vsichko ot vtorata tablica !!!
	NE SE POLZVA CHESTO !!!

	Cross Join NQMA NUJDA OT USLOVIE ZASHTOTO E VSEKI SUS VSEKI.
	Ako iskame obache mojem da go limitirame kato slagame WHERE().
*/

SELECT * FROM Employees AS e
CROSS JOIN Departments AS d 

--Vrushta 6 reda zashtoto v ednata tablica imame 2 a v drugata 3, s.l. 2 po 3 e ravno na 6.




--MOJEM DA ZAKACHAME POVCHE OT 2 TABLICI

--USE Diablo

Select u.Username, g.Name from Users AS u
inner Join UsersGames AS ug 
ON u.Id = ug.UserId
inner Join Games AS g
ON g.Id = ug.GameId
Order by u.Username;

/*
Naraq zakachame i Games.
Nie iskame samo imenata na igrachite i imenata na igrite v 
koito igrae vseki igrach inache tablicata stava mnogo dulga. 
*/


/*
	VAJNO !!! : KAK DA JOINVAME BEZ 'JOIN' ?
	
	Ako selektirame vsichko ot 2 tablici bez JOIN 
	samo s edin SELECT avtomatichno go crossJoinva !!!!!!!!!!
	Sled koeto s WHERE mojem da filtrirame kakto si iskame.
*/

---Use test3

select * from Departments AS d, Employees AS e;
--vrushta ni 6 zapisa zashtoto 3 po 2 e 6 
--OBACHE NIE MOJEM DA FILTRIRAME S WHERE().

select * from Departments AS d, Employees AS e
Where(d.DepartmentID = e.DepartmentID)
--Sega si stana normalen INNER JOIN


--Mojem da dobavqme oshte tablici i usloviq, shte polzvame SoftUni. 
--USE SoftUni

select * from Departments AS d, Employees AS e, EmployeesProjects AS ep
Where(d.DepartmentID = e.DepartmentID AND e.EmployeeID = ep.EmployeeID);
--PROBLEMA E CHE E MNOGO BAVNO PO TOZI NACHIN 




--CrossJoin Example: 
--Shte vzemem tablicata Emplyees i za neq shte zakachim tablicata Employees
-- Shte gi prekrustim za da se orientirame
--Vzimame FirstName ot e1 i LastName ot e2

/* 
	VAJNO !!! : Za da razburkame tablicata trqbva da q podredim po sluchaen red.
	Za tova mojem da polzvame RAND() obache to shte gi podredi samo purviqt put 
	kato runnem zaqvkata vtori put nqma da ima razlika !!!!!!!!

	Za tova e po dobre da polzvame NEWID() koeto gi rzburkva vseki put kogato pusnem 
	zaqvkata.	
*/


select e1.FirstName, e2.LastName From Employees as e1
CROSS JOIN Employees AS e2
order by RAND();

select e1.FirstName, e2.LastName From Employees as e1
CROSS JOIN Employees AS e2
order by NEWID();




--Ima i Self Join
/*
	Polzva se v samoreferirashti se tablici t.e. koito imat FOREIGN KEY koito sochi 
	kum samite tqh.
*/
--USE SoftUni

--Iskame da vidim na vseki rabotnik koi mu e menidgera.
Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name', --konkatenirame gi za da mojemd agi krustim po lesno 
e2.FirstName + ' ' + e2.LastName AS 'Manager name'  --konkatenirame gi za da mojemd agi krustim po lesno
from Employees AS e1  --krushtavame purvata Employees tablica 'e1'
JOIN Employees AS e2  --krushtavame vtorata Employees tablica 'e2'
ON e1.ManagerID = e2.EmployeeID  --uslovieto e ako ManagerID na rabotnika e = na EmployeeID na Menidgera


/*
	VAJNO !!! :
	Mojem da zakachim tablicata sama za sebesi po edna i sushta kolonka !!!
	
	PRIMER: 
	Iskame da vidim spisuk na vsichki rabotnici i vsichki kolegi 
	koito rabotqt v tehniq departament. 
	Shte go napravim kato joinnem po DepartmentID.
	Tova stava sus NERAVNI KOINOVE kudeto polzvame '<>' vmesto '='
	koeto ozn che ne e ravno.
*/

Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name',
e2.FirstName + ' ' + e2.LastName AS 'Colegue name'  
from Employees AS e1  
JOIN Employees AS e2  
ON e1.DepartmentID = e2.DepartmentID  -- kudeto departamentite sa ednakkvi
AND e1.EmployeeID <> e2.EmployeeID -- kudeto IDtata sa razlichni
order by [Employee name];

--Kato runnem zaqvkata vijdame ot lqvo imeto na choveka i ot dqsno 
--imenata na negovite kolegi



--Mojem da namerim vsichki kolegi samo na daden chovek
--Kato dobavim novo uslovie nakraq. 
Select 
e1.FirstName + ' ' + e1.LastName AS 'Employee name',
e2.FirstName + ' ' + e2.LastName AS 'Colegue name'  
from Employees AS e1  
JOIN Employees AS e2  
ON e1.DepartmentID = e2.DepartmentID
AND e1.EmployeeID <> e2.EmployeeID
AND e1.FirstName + ' ' + e1.LastName  = 'Alan Brewer';
-- konkatenirame za da sravnim i FirstName i LastName zaedno sus 'Alan Brewer' !!!
--Ako iskame mojem dapolzvame i WHERE() eno i sushto e !!!




/*
	Vajno!!! Mojem da oburnem usloviqta na JOIN.
	OBACHE REALNO NE VRUSHTAT NISHTO ZASHTOTO TRQBVA DA VURNAT VSICHKI NULL
	STOINOSTI.
*/



--Zd 1. Da pokajem adressna informaciq ot purvite 50 rabotnika ot SoftUni bazata
--podredeni po purvo ime i vtoro ime. 

--use SoftUni

select top(50)                  --vzimame purvite 50
e.FirstName,                    --vzimame purvoto ime ot Employees
e.LastName,						--vzimame vtoroto ime ot Employees
t.Name AS 'Town',							--vzimame imeto na grada ot Towns
a.AddressText					--vzimame adres teksta ot Addresses
from Employees AS e				--vzimame si Employees
Join Addresses as a				--Joinvame si adresite
ON e.AddressID = a.AddressID	--Kudeto adresIDto na rabotnika e = na AdresIDto ot Addresses tablicata	
Join Towns AS t					--Joinvame si Towns
ON a.TownID = t.TownID			--Kudeto townIDto ot Address tablicata e = na townIDto ot Towns zashtoto Towns e svurzano s Addresses
ORDER BY e.FirstName, e.LastName; --Podrejdame gi ASC po purvo ime i posle po vtoto ime.	

--NAPRAVIH GO SAM !!!!!!!!!!!!!   YEAHHHHHHHHHHHHH  :)
      select * from Addresses



--Zd 2. Da namerim vsichki rabotnici koito rabotqt v departamenta Sales ('Prodajbi').
--podredeni po EmployeeID :

select 
	e.EmployeeID, 
	e.FirstName, 
	e.LastName, 
	d.Name 
from Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
	AND d.Name = 'Sales'
ORDER BY e.EmployeeID;

--SAM GO NAPRAVIH !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



--Zd 3. Da pokajem vsichki rabotnici koito sa naeti sled 1/1/1999 i sa ili v departament 
--'Sales' ili vuv 'Finance'. Podredeni po HireDate


Select e.FirstName, e.LastName, e.HireDate, d.Name from Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID 
WHERE(d.Name = 'Sales' OR d.Name = 'Finance')
AND e.HireDate > '1999-01-01 00:00:00'              --Slagame si skobite za da hvane purvo 'OR' i posle 'AND' 
ORDER BY e.HireDate ASC;

--SAM GO NAPRAVIH !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



--Za 4. Da pokajem info za menidjera i departamenta na purvite 50 rabotnika
--sortirani po EmployeeID 

Select TOP (50) 
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS 'EmployeeName',
	m.FirstName + ' ' + m.LastName AS 'ManagerName',
	d.Name AS 'DepartmentName'
from Employees AS e
	JOIN Employees AS m
	ON m.EmployeeID = e.ManagerID
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID;

--SAM !!!!!!!!!!!!!!!!!!!!    :)






