



SELECT 
Id, 
A, 
H,
(A * H)/2 AS Area 
FROM Triangles2

SELECT * FROM Lines 

SELECT
X1,
X2,
Y1,
Y2,
ROUND(SQRT(SQUARE(X1 - X2) + SQUARE(Y1 - Y2)), 2) AS LineLength
FROM Lines 


SELECT POWER(5,3); 

SELECT ROUND(123.456, 1); 
SELECT ROUND(123.456,-1); 
SELECT ROUND(123.456, 0); 


SELECT FLOOR(25.5); 
SELECT CEILING(25.5); 
SELECT ROUND(25.51, 0); 


SELECT 
Name, 
Id,
Quantity, 
BoxCapacity, 
PalletCapacity,
FLOOR(CAST(Quantity AS float) / BoxCapacity) AS NumbetOfboxes,
CEILING(CEILING(CAST(Quantity AS float) / BoxCapacity) / PalletCapacity) AS NumberOfPallets
FROM Products


SELECT 
SIGN(0) AS Neutral,
SIGN(-412) AS Negative,
SIGN(5464) AS Positive;


SELECT RAND();

SELECT FLOOR(RAND() * 100);  
