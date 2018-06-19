

/*

	Indecite uskorqvat rabotata na nashata baza.
	Mnogo sa polezni kogato imame mnogo danni i tursim v tqh.
	Te sa nachin na podrejdane i organizirane na dannite v edna tablica.

	Ima dva vida:
	
	1.Clustered - koito e vgraden v samata tablica, dannite sa podredeni po 
		nachina na sortirane na klucha. Tova sas samite danni, mojem da polzvame 
		WHERE, ORDER BY i GROUP BY.
		Moje da ima samo 1 Clusteriziran index za edna tablica !!!
		Ako edna tablica nqma index znachi dannite v neq ne sa podredeni, 
		tova se naricha (Heap).
	
	2.NON-Clustered - Tuk nqma danni imame samo indexa, imame i link kum 
	CLUSTERIZIRANIQ INDEX koito durji dannite.



	Dobavqneto i premahvaneto na zapisi v indexirani tablici stava po bavno !!!!!!	

	VAJNO !!! : AKO IMAME PRIMARY KEY TO AVTOMATIHNO NI ZUZDAVA INDEX !!!!!!!!!!!

	PRIMER:

	CREATE NONCLUSTERED INDEX				--Kakuv shte bude
	IX_Employees_FirstName_LastName			--Ime
	ON Employees(FirstName, LastName)		--Ot Koq tablica i koi koloni

	

	CREATE CLUSTERED INDEX					--Kakuv shte bude
	IX_Employees_Id							--Ime
	ON Employees(Id)						--Ot Koq tablica i koi koloni


	
	MNOGOOOOOOO VAJNOOOO !!!!!
	Kato dadem CTRL + M vijdame Execution Plana (Mojem da go pusnem ot meniuto gore)
	kato posochim na Indexa vijdame pod Estimated CPU Cost za kolko vreme procesora
	e izvurshil operaciqta !!!!!!!Q



	VAJNO : 
	CLUSTERED INDEX ni e nujen samo ako tursim po ID !!!
	Ako tursim po neshto drugo ni trqbva NON CLUSTERED INDEX !!!


	*/

	Select FirstName, LastName, JobTitle
	From Employees
	
	--Mojem dapozvame include() ako iskame da dobavim kolonka:
	
	CREATE NONCLUSTERED INDEX					--Kakuv shte bude
	IX_Employees_FirstName_LastNme_JobTitle		--Ime
	ON Employees(FirstName,LastName)			--Ot Koq tablica i koi koloni
	include(JobTitle)

	/*
		VAJNOOOO !!!!!
		Kato dadem CTRL + M vijdame Execution Plana (Mojem da go pusnem ot meniuto gore)
		kato posochim na Indexa vijdame pod Estimated CPU Cost che operaciqta sega 
		e izvurhena ot procesora za 0,0004793. I ot gore pishe oshte danni.
	*/


	--POMNI CHE PRI VKARVANE NA DANNI V TABLICA KOQTO IMA INDEXI NESHTATA STAVAT MNOGO PO BAVNO !!!
	--TOVA E CENATA NA INDEXITE.
	




















