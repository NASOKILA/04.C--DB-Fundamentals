



/*USE Geography*/
/* 22. */
SELECT PeakName FROM Peaks
ORDER BY PeakName;

/* 23. */
SELECT TOP (30) CountryName, Population FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC; 


/* 24. */
SELECT
CountryName, CountryCode,
CASE
WHEN ISNULL(CurrencyCode, 'USD') = 'EUR' THEN 'Euro'
ELSE 'Not Euro' 
END AS Currency
FROM Countries
ORDER BY CountryName;

/*MOJEM DA GO NAPISHEM I TAKA:

SELECT
CountryName, 
CountryCode,
CASE CurrencyCode                   --Tuk posochvame s koq kolona raborim v CASE-a
WHEN 'EUR' THEN 'Euro'
ELSE 'Not Euro' 
END AS Currency
FROM Countries
ORDER BY CountryName;

*/

--Ako CurrencyCode e NULL go pravim na USD, posle ako e EUR togava pod Currency kolonka 
--pishem 'Not Euro' inache pishem 'Euro', posle podrejdame vsichko po CountryName



/*USE Diablo*/
/* 25. */
SELECT Name FROM Characters
ORDER BY Name;




