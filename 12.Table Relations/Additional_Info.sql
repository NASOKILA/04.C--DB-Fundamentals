
/*
	Clutered index
	. . .



	Jira: podobno e na kanban
	Tova e issue tracking platforma koqto razpredelq rabotata 
	(Task, zadacha, problem)na razlichni programisti, dava vreme.

	Task Managment e podobno na Jira i kanban



	VAJNO !!! : 
	IDENTITY AVTOMATICHNO NI UVELICHAVA Idto, DORI I DA IZTRIEM 
	DANNI BROQCHUT PRODULJAVA OT TAM KUDETO E BIL.
	TOVA STAVA AKO NI HVURLI EXEPTION ILI DADE NQKAKVA GRESHKA,
	AKO PRIMERNO NIE NAPRAVIM SINTAKTICHNA GRESHKA BROQCHUT NQMA 
	DA PRODULJI NAPRED.
	MOJEM DA RESETNEM TOZI BROQCH S:

	DBCC CHECKIDENT('tableName', RESEED);



	Vruzki:
	Vruzkata mejdu tablici stava s PRIMARY KEY i FOREIGN KEY.
	
	OneToMany: Edna durjava ima mnogo gradove i mnogo gradove imt edna durjava
		STAVA PO STANDARTNIQ NACHIN
	OneToOne: Edin shofior ima edna kola i obratnoto
		POLZVAME UNIQUE
	ManyToMany: Mnogo proekti imat mnogo rabotnici i obratnoto
		POLZVAME MAPPING TABLE

	VAJNO !!! : 
	AKO NAPISHEM PRIMARY KEY BEZ DA GO SLAGAME V CONSTRAINT
	TO PAK SHTE SI IMA KONSTRAINT SAMOCHE SHTE IMA AVTOMATICHNO 
	SUZDADENO IME.
	SUSHTOTO VAJI I ZA FOREIGN KEY.
	I DVATA NACHINA SA PRAVILNI !!!!!!!!!!!!!!!!!!!!!!!!
*/


/*
	Pri pulnene na tablica koqto ima foreign key ne trqbva da mojem da slagame NULL
	stoinosti i da slagame id-ta koito ne sushtestvuvat.
*/



--JOIN:
--use Geography;

--Select all peaks in Rila
select 
	m.MountainRange,
	p.PeakName,
	p.Elevation
from Mountains AS m
JOIN Peaks AS p
ON p.MountainId = m.Id 
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC;






























