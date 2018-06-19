	


/*
	TRANSACTIONS :

	Transakciqta e poredica ot operacii vurhu bazata koito se 
	izpulnqvat kato edno cqlo.
	
	Tezi operacii moje da budat INSERT, DELETE, UPDATE.
	Ideqta e vsichki tezi operacii da se izpulnqt i da prikluchat ednovremenno
	ili v protiven sluchai nito edna operaciq ne se izpulnqva.

	PRIMER:
	Pri obiknoven Bankov prevod se updeitvat dva akaunta,
	ediniq namalqva a drugiq se uvelichava, ako neshto se oburka v koito i da e
	akaunt vsichki operacii se anulirat. 
	Nqma kak da se izpulni samo ednata operaciq.

	Tranzakciqta e kato paket ot operacii koito trqbva da zapochnat i da 
	zavurshat zaedno, ako neshto se oburka vsichki operacii se anulirat i
	dannite sa kakto sa bili predi.
	Vsichki operacii se izvurshvat zaedno.

	Vsichki promeni v Tranzakciqta sa vremenni dokato ne COMMITnem.
	Ako stane nqkakva greshka primerno da padne toka, se polzva ROLLBACK
	koeto anulira vsichki promeni do momenta.


	KAKVO MOJE DA SE OBURKA ?
	1. Da krashne softwera
	2. Da imame nqkolko transakcii ednovremenno
	3. Da padne toka
	

*/

/*

--Sintaxis

	BEGIN TRANSACTION
	
	UPDATE Accounts SET Balance = Balance - @WithdrawableAmount
	WHERE Id = @account
	IF @@ROWCOUNT <> 1      --AKO SME AFEKTIRALI POVECHE OT 1 RED
	BEGIN

		--Hvurlqme greshka

		ROLLBACK
		RAISERROR('Invalid account!', 16, 1)
		RETURN
	END
	

	COMMIT        --Ako vichko e minalo nared komitvame

*/




/*
	ACID :

A - Atomicity : ozn che vsichko shte se izpulni na vednuj
C - Consistency : ozn che predi i sled tranzakciqta vsichki danni sa validni
I - Isolation : ozn che dve tranzakcii ne mogat da si vliaqt edna na druga, te sa izolirani 
D - Durability : ozn che sled komitvane ne mojem da vurnem dannite nazad

*/



/*
	Tranzakciite se polzvat v povecheto sluchai za testvane na neshto.
	AKO ISKAME DA TESTVAME NESHTO V DADENA BAZA BEZ DA IMA PROMQNA NA
	BAZATA POLZVAME TRANZAKCIQ NO AKO KOMITNEM SHTE IMA PROMENI V BAZATA !
	NAKRAQ SLAGAME ROLLBACK !!!!!!!!!!!!!!!!!!

	PRIMER:
*/


BEGIN TRANSACTION

--Kakvito i promeni da pravim tuk nqma znachenie
--zashtoto posle imame rollback

--Mojem da testvame kakvoto ni e kef.

ROLLBACK;



--Kaskadna operaciq e primerno ako imame dve svurzani tablici po Id v mapping tablica
--i kato iztriem edna stoinost ot edna tablica avtomatichno da izchezva i v drugata .



