
/*
	Shte govorim za vruzki mejdu bazzite.

	Predi praveneto na bazite trqbva purvo da se planira mnogo vreme.
	KAK SE PLANIRA:
	1. Kakvo shte ima v bazata.
	2. Kakvi kolonki i poleta shte ima.
	3. Primary key za vsqka tablica.
	4. Vruzki.
	5. Definirane drugi nehta kato unikalnost.
	6. Testvane na tabliite.


	1.Kakvo shte ima v bazata (Identification of Entities)
	Poluchavame obqsnenie ot klienta za kakvo shte pravi tazi baza,
	kakvo shte ima i dr.


	Kak da izberem glaven kluch ?
	Trqbva da e INT, pishem PRIMARY KEY koeto trqva da e na purvata
	kolonka i IDENTITY za da narastva avtomatichno.

	Za da napravim vruzka mejdu dve tablici po nqkoga e nujno da suzdavame
	treta tablica.

	Shte napravim primer mejdu studenti, kursove i gradove.
	Purvo mejdu studenti u kursove, qsno e che vruzkata shte bude MANY TO MANY
	(mnogo kum mnogo) i kum gradovete pak MANY TO MANY.
	Ako ima samo edin grad stava MANY TO ONE.

	ZA PLANIRANETO SE PRAVQT I INTERVIUTA ZA POVECHE INFORMACIQ ZA PRAVENETO NA 
	BAZATA I VRUZKITE KUM NEQ.

	Pri vruzka s dve tablici i dvete imat PRIMARY KEY no za vruzkata, ednata 
	ima FOREIGN KEY koito suvpada s PRIMARY KEY  ot drugata tablica.

	PRAVENETO NA VRUZKI STAVA I PRI SUZDAVANETO NA TABLICI.
	STAVA S POLZVANETO NA CONSTRAINT-i:
	PRIMER S Peaks i Mountains TABLICITE:

	CONSTRAINT FK:Peaks_Mountains
	FOREIGN KEY (MountainID)
	REFEREBCES Mountains(MountainID)

	TRQBVA OBACHE I DVETE TABLICI VECHE DA SA SUZDADENI.



	VAJNOOOOOOOOOOOOOO !!!!!!!!!!!!!!!!!!!!:
	Pri pravene na vruzka MANY-TO-MANY se suzdava specialna tablica koqto se kazva 
	MAPPING TABLICA koqto sudurja v neq IDtata i na dvete tablici !!!!!
	Ako primerno ima v MAPPING TABLICA  kombinaciq ot kluchove da kajem 1 i 4 , i ako nqkoi se opita 
	da vuvede pak 1 i 4 togava shte dade greshka zashtoto tazi kombinaciq veche 
	sushtestvuva.



	KASKADNI OPERACII:
	Ako imame MAPPING TABLICA ot tablicite Employees i Projects, i ako iztriem 
	edin red ot primerno Project primerno red s Id 4, togava v MAPPING TABLICATA 
	se iztrivat vsichki poleta koito imat ProjectID 4. TOVA E KASKADNA OPERACIQ!!!


	VAJNO !!! :
	Pri praveneto na vrzka ONE-TO-ONE trqbva da imame UNIQUE za da ne se povtarqt IDtata !



	PRI REALEN PROEKT AKO ISKAME DA NAPRAVIM PROMQNA NA BAZATA NE MOJEM OSOBENO AKO BAZATA
	SE POLZVA OT PRILOJENIE V MOMENTA.
	PROMENITE SE PRAVQT NA OTDELEN SURVER I SUS QUERY, SLED KATO SME SIGURNI CHE 
	VSICHKO RABOTI, ZNACHI TOGAVA GO PRILAGAME NA NASHATA ISTINSKA RABOTESHTA BAZA.
	
	NA MNOGO MESTA AKO PRAVIM PROMQNI NA BAZATA TQ HTE E ZAKLUCHI I VSICHKI SHTE IZPISHTQT
	ZASHTOTO TRQBVA DA CHAKAT DOKATO SE OTKLUCHI.




*/


--Suzdavame si nova baza
CREATE DATABASE Test2;


--OneToMany:
--Edin vruh moje da ima samo edna planina 
--obache edna planina moje da ima mnogo vurhove

--Pravim si tablicata Mountains
CREATE TABLE Mountains(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

--Suzdavame si tablica Peaks
--Suzdavame si i Foreign Key FK_Mountains_Peaks
CREATE TABLE Peaks(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50),
MountainId INT NOT NULL,
CONSTRAINT FK_Mountains_Peaks
FOREIGN KEY (MountainId)
REFERENCES Mountains(Id)
)

--MountainId trqbva da e ot tip INT kakto e Id-to na Mountains
--AKO OTIDEM V PAPKATA Keys NA TABLICATA Peaks SHTE GO VIDIM FK-to

--Mojemd da si napravim konstrainta i otvun tablicata:
/*
ALTER TABLE Peaks
ADD CONSTRAINT FK_Mountains_Peaks
FOREIGN KEY (MountainId)
REFERENCES Peaks(Id);
*/

--Insertvame si neshto v Mountains
INSERT INTO Mountains
VALUES
('Rila'),
('Stara planina'),
('Pirin'),
('Rodopite');

--Vkarvame si i nqkolko vurhove
INSERT INTO Peaks
VALUES
('Musala',1),
('Vihren',3),
('Botev',2),
('Alada',4);


--ManyToMany RELATION:
--pravim si dve tablici :
create table Employees(
Id int primary key identity(1,1),
FirstName varchar(50),
LastName varchar(50),
Salary money
)

create table Projects(
Id int primary key identity(1,1),
Name varchar(255) not null,
Description varchar(max),
StartDate Date Default GETDATE(),
EndDate Date 
)
--Ako ne dadem stoinost na StartDate shte bude segashnata data
--dokato EndDate moje i da e NULL

--sega trqbva da naprvim vruzkata mejdu tqh
-- Konstraintite shte gi naprvim na sushtiq red t.e. inline, obache taka 
--konstraintite a bez ime !!!!
Create table EmployeesProjects(
EmplyeeId int foreign key references Employees(Id),
ProjectId int foreign key references Projects(Id),
constraint PK_EmployeeId_ProjectId
primary key (EmplyeeId, ProjectId)
)
-- pravim primary key da sa i dvete koloni kakto i foreign key
-- realno ako poglednash v Keys papkata ima samo edin PK samoche e
-- kombinaciq i ot dvete.



--ZA DA VKARAME DANNI V EmployeesProjecta TRQBVA PURVO DA IMA DANNI V
--DVETE DABLICI Employees I Projects.

insert into Employees
values 
('Atanas', 'Kambitov', 500),
('Asen', 'Kambitov', 200),
('Petur', 'Doklev', 1500);

insert into Projects(Name,Description)
values
('FirstProject', 'This is the description...'),
('SecondProject', 'This is the description...'),
('ThirdProject', 'This is the description...');
--Slagame samo ime i deskription


--Sega veche mojem da slagame i v EmployeesProject tablicata
insert into EmployeesProjects
values
(1,3),
(2,2),
(3,1);




/*
Shte razgledame ONE-TO-ONE vruzka:
*/

--Suzdavame dve tablici Cars i Drivers

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY(1,1),
Model varchar(50)
)

--za da napravim vruzkata shte slojim FK v Drivers
--VAJNO : Pri ONE-TO-ONE trqbva da ima UNIQUE zaduljitelno
--za da nqma dvama shofiori koito da sochat kum edna i sushta kola.
CREATE TABLE Drivers(
Id INT PRIMARY KEY IDENTITY(1,1),
Name varchar(50) NOT NULL,
CarId INT UNIQUE,
CONSTRAINT FK_Cars
FOREIGN KEY (CarId)
REFERENCES Cars(Id)
)


--Vkarvame si danni:
--Hubavo e purvo da vkarame kolite
insert into Cars
values
('Opel'),
('Reno'),
('BMW'),
('Smart');

--dobavqme si i shofiori
insert into Drivers
values
('Toni',1),
('Asi', 4),
('Petre',2),
('Naso',3);


select * from Drivers
select * from Cars

/*
Shte napravim baza football. 
Trqbva da imame otbori, ligi, igrachi i manigeri. 
Igrachite trqba da imat purvo ime, vtoro ime i salary.
Trqbva da napravim vruzkite pravilno.
*/

CREATE DATABASE Football;

CREATE TABLE Teams(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

CREATE TABLE Leagues(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

--Vruzkata mejdu Leagues i Teams e ManyToMany zashtoto v edna liga moje
--da ima mnogo otbori i edin otbor moje da uchastva v mnogo ligi.
--PRI OneToOne ni trqbva treta MAPPING tablica koqto da subira dvete.
CREATE TABLE LeaguesTeams(
LeagueId INT,
TeamId INT,

CONSTRAINT PK_LeagueId_TeamId
PRIMARY KEY (LeagueId, TeamID),

CONSTRAINT FK_Teams
FOREIGN KEY (TeamId) 
REFERENCES Teams(Id),

CONSTRAINT FK_Leagues
FOREIGN KEY (LeagueId) 
REFERENCES Leagues(Id)
)
--Tozi put kluchovete gi pravim s konstrainti, pravim PK i dva FK !


CREATE TABLE Players(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PlayerNumber INT,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Salary Decimal(8,2) default 0,
	TeamId INT,
	CONSTRAINT FK_Teams_Players
	FOREIGN KEY (TeamId)
	REFERENCES Teams(Id) 
)
--Za parite sme dali 0 po default, mojem da polzvame MONEY kato tip!
--Imame vruzka OneToMany kum Otborite zatova modificirame Players


CREATE TABLE Managers(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Salary Decimal(8,2) default 0,
	TeamId INT UNIQUE NOT NULL,
	CONSTRAINT FK_Teams_Managers
	FOREIGN KEY (TeamId)
	REFERENCES Teams(Id) 
)
--Pri vruzka OneToOne s Managers i Teams, slagame UNIQUE i NOT NULL
--zshtoto nqma kak da ima otbor bez menidger.

--SHTE PROPUSNEM INSERTVANETO !!!!

/*
VAJNO !!! : 
Po principp e dobra praktika purvo da si pravim tablicite i posle 
s ALTER TABLE :

    ALTER TABLE TableName
	ADD CONSTRAINT FK_ThisTable_ReferencedTable
	FOREIGN KEY ...
	REFERENCES ...

*/


/*
VAJNO !!! : 
Ne mojem da imame dva klucha s edno i sushto ime nezavisimo v koi tablici,
tezi pravila vajat za cqlata baza. 
Primerno ne mojem da imame FK_Teams v tablicata Teams i FK_Teams v 
tablicata Players.  SHTE NI DADE GRESHKA !!!!!!!!!!!!!!!!!!!!!
*/



/*
VAJNO!!! : 

KAKVO E SAMOREFERIRASHTA SE TABLICA ?

V Softuni bazata, v Employees tablicata vijdame che ima 
kolona ManagerId.
Obache v bazata nqmame tablica Managers.
V sluchaq menidgerite sa rabotnici i sa v tablicata Employees,
sledovateno Id-to na manidgerite sochi kum Id-to na sushtata tablica
Employees za tova se naricha SAMOREFERIRASHTA SE TABLICA  !!!!!!!!!!!

VAJNO !!! :
Sochi oznachava referira t.e. pri suzdavane to na tozi FK pishe :
REFERENCES Employees(Id)
*/ 



/*
WITH CHECK oznachava da pravi proverka na dadeno neshto, noje da e 
primerno CONSTRAINT, da se podsigurqva za dannite koito vkarvame.
NE GO PISHEM ZASHTOTO E PO DEFAULT !!!
*/



/*
Shte razgledame JOIN-s s koeto mojem da izvajdame danni ot 
svurzanite tablici:
Tablicite se svurzvat po nqkakva stoinost sus JOIN, ima 
specialna lekciq za tova.
Trqbva da imame dve tablici svurzani po nqkakva logicheska 
proverka s JOIN, i kogato tazi logicheska proverka dade 'true'
i za dvete tablici znachi te se joinvat v edna virtualna tablica.
*/

--Zd. V bazata Geography da namerim vsichki vurhove koito sa v Rila planina
--kato izpishem imaeto na planinata i na vurha i visochinata 
--i nakraq trqbva da gi sortirame po elevation.

USE Geography

SELECT 
MountainRange, PeakName, Elevation 
FROM Mountains
JOIN Peaks ON
Peaks.MountainId = Mountains.Id AND MountainRange = 'Rila'
ORDER BY Elevation DESC;
--Predposledniq red e uslovieto, kazali sme Id-to na Peaks da e 
--sushtoto kato tova na Mountains i imeto na planinata da e 'Rila' !


/*
KASKADNI OPERACII (Cascade Operations)


KATO TRIE ILI UPDEITVAME NQKAKVA taBLICA DA SE DELETVAT ILI UPDEITVAT DANNITE
I V DRUGA TABLICA AKO DVETE SA SVURZANI !!!!!!!!!!!!!!!

Pri deletvane ili updatvene na dannite v nashata baza trqbva da osigurim 
operaciite takache da sa pravilni bez da ostavqt dupki v kolonite, t.e. da 
nqma koloni sus stoinost NULL.

Kaskadnata operaciq moje da e Delete ili Update

Kaskadnata operaciq NE se polzva za logichesko iztrivane t.e. koeto oznachava
dizaktivirane i kogato iskame da zapazim istoriqta.

Pozva se kato napishem ON DELETE CASCADE ili ON UPDATE CASCADE vuv 
Constraint FK_... sled REFRENCES
Samoche Idto ne trqbva da ima IDENTITY !!!!!!!!!!!!!!!!!!!

*/

--Primer s DELETE:

CREATE TABLE Products
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50)
)

CREATE TABLE Store
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50),
	ProductId INT,

	CONSTRAINT FK_Store_Products
	FOREIGN KEY (ProductId)
	REFERENCES Products(Id) ON DELETE CASCADE
)

--Sega kogato iztriem neshto ot Product shte se iztriqt vsichki redove v Store koito sa go imali !!!
--Dobavihme danni chrez interfaisa !!!
--Sega shte testvame dali shte proraboti.

--Triem produkta Bread
DELETE FROM Products
WHERE Name = 'Bread';

--sega vijdame che v Store go nqma BreadStore znachi raboti !!!
SELECT * FROM Store


/*
Cascade Update e kogato prosto promenim stoinostta na daden red v malkata tablica,
togava vsichki redove v drugata tablica koito sa imali tova Id ot purvta tablica
trqbva i te da se promenat !!!!!!!!!!!

Nai bezopsno e da se polzva zaedno s UNIQUE !!!!!!!!!!!!!!

NE SE POLZVA KOGATO PRIMARY KEY E IDENTITY !!!!!!!!!!!!!!!!!!!!!

Ako Primary Key NE e IDENTITY znachi mojem da go promenqme.
BLAGODARENIE NA PROCEDURI I TRIGERI MNOJEM DA PRESKOCHIM Cacade Update.

Pozva se kato napishem ON UPDATE CASCADE vuv Constraint FK_... sled REFRENCES
Samoche Idto ne trqbva da ima IDENTITY

VAJNO !!! :
NE POLZVAI CASCATE UPDATE KOGATO IMASH IENTITY NA PRIMARY KEY !!!!!!!!!!


*/




--Primer s UPDATE:

CREATE TABLE Owners
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50)
)

CREATE TABLE Factory
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50),
	OwnerId INT,

	CONSTRAINT FK_Factory_Owner
	FOREIGN KEY (OwnerId )
	REFERENCES Owners(Id) ON UPDATE CASCADE
)

--Sega kogato Updatnem neshto ot Owners trqbva vuv Factory da se promenqt redove.
--Dobavihme danni chrez interfaisa !!!
--Sega shte testvame dali shte proraboti.

--Dobavihme si danni ot interfaisa
--Promenqme produkta


--Promenqme Idto na 11 na Atanas
UPDATE Owners
SET Id = 11
WHERE Name = 'Atanas';

--sega vijdame che vuv Factory Idto e promeneno, znachi raboti !!!
SELECT * FROM Factory


--Vmesto ON UPDATE CASCADE mojem da napishem ON UPDATE NO ACTION
--koeto nqma da ni pozvoli da pravim promqni no v nashiqt sluchai nqma da proraboti.

-- Imame i UPDATE CASCADE SET NULL koeto pri promqna shte setne promenenoto na NULL
-- Mojem i da go polzvame pri DELETE: DELETE CASCADE SET NULL i kogato iztriem neshto
-- to da ne se maha a da stava NULL.

-- Imame i SET DEFAULT koeto ako imame setnata DEFAULT stoinost, pri update ili delete da
-- slojim neq


/*
Za da vidim diagramata na bazata davame dqsno kopche na Database Didagrams i davame 
New Database Diagram, selektirame koito tablici iskame, davame Close i ni izlizat vsichki 
podredeni i svurzani.
*/

/*
LOGICAL DELETE:
Tova e kogato ne iskame da triem neshto a prosto go markirame kato iztrito.
S drugi dumi go dezaktivirame. 
*/

















