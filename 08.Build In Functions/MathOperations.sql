



/*
Matematicheski operacii:

Polzvame osnovnite +,-,*,/
Mojem da polzvame i geometrichni operacii kato da namerim liceto na triugulnik 
*/

SELECT 
Id, 
A, 
H,
(A * H)/2 AS Area --nova kolonka za Lice = e na (stranata po visochinata) / 2!
FROM Triangles2


/*
 PI() chisloto 3.14159265...
 ABS(Value) absolutna stoinost
 SQRT(Value) koren kvadraten
 SQUARE(Value) povdigane na stepen

*/



--Zd. Da namerim duljinata nda dedena liniq

SELECT * FROM Lines 
--Imame X1,Y1 koordinati na purvata tochka i 
--X2, Y2 koordinati na vtorata tochka

SELECT
X1,
X2,
Y1,
Y2,
ROUND(SQRT(SQUARE(X1 - X2) + SQUARE(Y1 - Y2)), 2) AS LineLength
FROM Lines 

--Koren kvadraten ot (X1 - X2) na vtora stepen + (Y1 - Y2) 
--na vtora stepen.

--S ROUND() gp pravim da e do vtoriq znak sled desetichnata zapetaq

/*
CONVERT() I CAST() SA GORE DOLO EDNI I SUSHTI PROSTO IMAt RAZLICHEN SINTACIS,
I DVETE PREVRUSHTAT DADENATA KOLONKA DA E S POSOCHENIQT OT NAS TIP DANNI.

S CONVERT() MOJEM DA PROMENQME I DATI.
*/

/*
POWER(Value, Exponent) Vdiga go na koqto stepen si iskame
dokato SQUARE() go vdiga samo na vtora stepen
*/

SELECT POWER(5,3); -- pet na treta stepen e 125

/*
ROUND(Value, Precision) --Veche go znaem, Precision moje da e negativno chislo !
*/
SELECT ROUND(123.456, 1); --123.500
SELECT ROUND(123.456,-1); --120.000 zakruglq nqlqvo ot zapetaqta
SELECT ROUND(123.456, 0); --123.000  pravi go na cqlo chislo


/*
FLOOR(Value) i CEILING(Value) sa sushtite, znaem gi
*/
SELECT FLOOR(25.5); --zakruglq kum po malkoto
SELECT CEILING(25.5); --zakruglq kum po golqmoto
SELECT ROUND(25.51, 0); --zakruglq kum nai blizkoto


/*
Zd. Da presmetnem neobhodimiq broi paleta za da izpratim daden predmet:
Rabotim v Baza Demo, Tablica Products.

BoxCapacity: kazva ni kolko redmeta vlizat v edna kutiq.
PalletCapacity: kazva ni kolko kutii vlizat v edno pale.
*/

SELECT 
Name, 
Id,
Quantity, 
BoxCapacity, 
PalletCapacity,
FLOOR(CAST(Quantity AS float) / BoxCapacity) AS NumbetOfboxes,
CEILING(CEILING(CAST(Quantity AS float) / BoxCapacity) / PalletCapacity) AS NumberOfPallets
FROM Products


/*
SIGN(Value) ni vrushta 0, 1 ili -1 v zavisimost kakvo e chisloto v skobite, negativno, pozitivni ili 0
*/
SELECT 
SIGN(0) AS Neutral,
SIGN(-412) AS Negative,
SIGN(5464) AS Positive;


/*
RAND() generira random chislo
*/
SELECT RAND();

SELECT FLOOR(RAND() * 100);  -- Taka ni generira chislo ot 1 do 100

