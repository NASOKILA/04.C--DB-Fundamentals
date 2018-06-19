
/*
MODIFY EXISTING DATA 

UPDATE AND DELETE
*/


/*
DELETE:
Veche znaem kak se polzva, VAJNO E DA NE ZABRAVQME DA
POLZVAME 'WHERE' ZASHTOTO SHTE IZTRIE VSICHKO V TABLICATA

Ako iskame da iztriem vsichki danni v e dna tablica pishem 
TRUNCATE TABLE ImeNaTablica     TO E PO BURZO OT DELETE !!!!!

Ako iskame da iztriem cqlata tablica polzvame DROP 
*/


DELETE FROM People WHERE FirstName = 'Anton';

TRUNCATE TABLE People;

DROP TABLE People;



/*
UPDATE:
Izpolzvame SET i WHERE, Znaem kak se polzva .
Mojem da pravim i po slojni neshta	i da izvurshvame matematicheski 
i stringovi operacii

VAJNO E DA NE ZABRAVQME DA POLZVAME 'WHERE' !!!
*/

UPDATE Cars
SET Model = 'Vectra'
WHERE Id = 6
--AKO ZABRAVIM DA POLZVAME 'WHERE' SHTE PREVURNE VSICHKI MODELI NA KOLI VUV VEKTRA !











