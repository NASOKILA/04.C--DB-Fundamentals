
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
	SELECT IS_MEMBER('db_owner'); 
	SELECT IS_MEMBER('db_owner'); 
	SELECT IS_MEMBER('db_owner2'); 

	CREATE ROLE ProjectManager;
		
	CREATE LOGIN PM_Nasko
	WITH PASSWORD = 'pass!12';
	
	CREATE USER U_Nasko FOR LOGIN PM_Nasko;
		
	ALTER ROLE ProjectManager
	ADD MEMBER U_Nasko;
		
	GRANT SELECT, 
		  INSERT, 
		  UPDATE 
	ON Bank.dbo.Accounts
	TO ProjectManager;

	DENY DELETE 
	ON Bank.dbo.Accounts
	TO ProjectManager;

	SELECT 
	USER_NAME(), 
	SUSER_NAME(); 
	
	EXECUTE AS LOGIN = 'PM_Nasko';

	SELECT 
	USER_NAME(), 
	SUSER_NAME(); 

	DELETE Accounts
	WHERE Id = 2;
	