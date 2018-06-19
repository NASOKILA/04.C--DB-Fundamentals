


/*
	V SQL ima dva vida securiry roli:
	
	Fixed SERVER Roles - primerno daden chovek ima dadena rolq i 
		moje da napravi samo opredeleni neshta vurhu bazata. 
	
	Fixed DATABASE Roles - t.e. koi do koq baza ima dostup



	ROLI:
	Rolqta e neshto kato privilegiq koqto ti dava da pravish dadeni neshta vurhu bazata.

	FIXED SECURITY ROLES:
	1.sysadmin: moje da pravi vsichko v SQL servera, minava vsichki proverki.
	
	2.dbcreator: moje da suzdava bazi i da pipa po tqh

	3.securityadmin: ima dostup do koi kakvo moje da pravi vurhu bazite na celiq server.
		dava i maha roli da drugite

	4.bulkadmin: moje da importva danni ot vunshni failove

	5.datawriter: moje da dobavq danni kum bazata


	VAJNO !!!
	bulkadmina moje da pravi samo tova.
	--S BULK INSERT mojem da vkarvame mnogo stoinosti navednuj v tablica.


	FIXED DATABASE ROLES:

	1.db_owner: moje da pravi vsichko no samo v tazi baza

	2.db_securityadmin: toi e kato securityadmin samoche samo v 
		tazi baza, dava roli na	drugite.

	3.e.db_accessadmin: otgovarq za dostupa do bazata NE SE POLZVA MNOGO 

	4.db_backupoperator: moje da backupva bazi no ne moje da gi restorva
		NE SE POLZVA MNOGO


	IMA OSHTE MNOGO ROLI KOITO NE SE POLZVAT MNOGO.

	VAJNO !!! : IS_MEMBER ni kazva kakva ni e rolqta:
	SELECT IS_MEMBER('role_name');
	ako vurne 1 znchi tova e nashata rolq
	ako vurne 2 znchi tova NE e nashata rolq
	ako vurne NULL znchi tazi rolq ne sushtestvuva

	*/
	SELECT IS_MEMBER('db_owner'); --vrushta 1 
	SELECT IS_MEMBER('db_owner'); --vrushta 1 
	SELECT IS_MEMBER('db_owner2'); --vrushta NULL
	--sushto taka ni otgovarq dali dadena rolq sushtestvuva
	





	/*
		Mojem da si suzdavame nie sobstveni roli, t.e. 
		da limitirame daden chovek da otgovarq tochno za tova koeto
		nie iskame, i da slagame nqkolko roli na edin chovek.
	
	
		--Ima specialen poster, internet koito gi ima vsichki roli v SQL server
	


	CUSTOM ROLE PERMITIONS: 
	tezi gi ima v postera, NQMA DA RAZGLEJDAME 
	
	*/


	
	
	--VAJNO !!! :
	
	--KAK SE SUZDAVA ROLQ
	CREATE ROLE ProjectManager;
		--Mojem da vidim vsichki roli v papka Security/Roles/Database Roles

	--Mojem da suzdavame LOGIN s ime i parola koito shte se polzva ot daden USER 
	CREATE LOGIN PM_Nasko
	WITH PASSWORD = 'pass!12';
		--V papka logins mojem da gi vidim vsichki logini.

	--Suzdavame USER i mu zakachame LOGINA
	CREATE USER U_Nasko FOR LOGIN PM_Nasko;
		--V papka users mojem da gi vidim vsichki useri.

	--Dobavqme USER kum dadenata ROLQ:
	ALTER ROLE ProjectManager
	ADD MEMBER U_Nasko;
		

	--Sega mojem da dadem na USERA s rolq ProjectManager 
	--nqkakvi permitioni kum dadena tablica ot dadena baza:
	GRANT SELECT, 
		  INSERT, 
		  UPDATE 
	ON Bank.dbo.Accounts
	TO ProjectManager;

	--AKO SLOJIM 'REVOKE' VMESTO 'GRANT' MU MAHAME TEZI PREVILEGII, NO 
	--NE E KATO 'DENY' IMA MALKA RAZLIKA


	--Sega ste mu zabranim da iztriva:
	DENY DELETE 
	ON Bank.dbo.Accounts
	TO ProjectManager;


	--Sega vijdame che Usera s tazi rolq moje da INSERTVA i 
	--SELECTVA i UPDEITVA no ne moje da TRIE ot Bank.dbo.Accounts

	--TOVA MOJEM DA GO VIDIM KATO CUKNEM NA ROLQTA V PAPKATA Database Roles
	--POSLE DAVAME 'SECURABLES' GORE V LQVO I VIJDAME TABLICA
	--NA KOQTO AKO PISHE dbo ZNACHI IMA RAZRESHENIE ZA TOVA.

	
	--DA TESTVAME:
	
	--taka vijdame koi user polzvame
	SELECT 
	USER_NAME(), --ime na usera koito polzvame
	SUSER_NAME(); --Ime na logina
	

	--Taka smenqvame usera i pochvame da polzvame PM_Nasko
	EXECUTE AS LOGIN = 'PM_Nasko';


	SELECT 
	USER_NAME(), 
	SUSER_NAME(); 
	
	--VAJNO !!! :
	--AKO ISKAME DA SE VURNEM S PREDISHNIQ USER PROSTO SMENQVAME QUERYto !!!

	/*
	Vijdame che Usera s tazi rolq moje da INSERTVA i 
	SELECTVA i UPDEITVA no ne moje da TRIE ot 
	Bank.dbo.Accounts
	*/

	DELETE Accounts
	WHERE Id = 2;
	--Kazva ni ce nqmame previlegii 









/*
	SUMMARY:  KAKVO VIDQHME ?
	
	1.Tranzakcii ROLLBACK, COMMIT, 
	2.Triggery AFTER, INSTEAD OF,  deleted i inserted tablici, 
	3.ACID
	4.Database Security ROLI, USERI, LOGINI, PRIVILEGII, CUStoM ROLI, OT NAS SUZDADENI, i dr.
*/





