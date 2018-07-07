



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


/*USE Diablo*/
/* 25. */
SELECT Name FROM Characters
ORDER BY Name;
