

--1. Number of Users for Email Provider

SELECT 
	  SUBSTRING(Email, CHARINDEX('@', Email) + 1, 100) [Email Provider],
	  COUNT(*) AS [Number Of Users]
FROM Users
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email) + 1, 100)
ORDER BY COUNT(*)  DESC, SUBSTRING(Email, CHARINDEX('@', Email) + 1, 100) ASC


--02. All Users in Games
SELECT 
	   g.Name, 
	   gt.Name,
	   u.Username,
	   ug.Level,
	   ug.Cash,
	   c.Name
  FROM Users AS u
  JOIN UsersGames AS ug
	ON ug.UserId = u.Id
  JOIN Games AS g
	ON g.Id = ug.GameId
  JOIN GameTypes AS gt
	ON g.GameTypeId = gt.Id
  JOIN Characters AS c
	ON ug.CharacterId = c.Id
 ORDER BY ug.Level DESC, u.Username, g.Name;


 
 --03. Users in Games with Their Items
 SELECT 
	   u.Username,
	   g.Name,
	   COUNT(i.Id) AS [Items Count],
	   SUM(i.Price) AS [Items Price]
  FROM Users AS u
  JOIN UsersGames AS ug
	ON ug.UserId = u.Id
  JOIN Games AS g
	ON g.Id = ug.GameId
  JOIN UserGameItems AS ugi
	ON ugi.UserGameId = ug.Id
  JOIN Items AS i
	ON i.Id= ugi.ItemId
 GROUP BY u.Username, g.Name
HAVING COUNT(i.Id) >= 10 
 ORDER BY COUNT(i.Id) DESC, SUM(i.Price) DESC, u.Username;


 --04. * User in Games with Their Statistics


 --05. All Items with Greater than Average Statistics
 SELECT
	   i.Name,
	   i.Price,
	   i.MinLevel,
	   s.Strength,
	   s.Defence,
	   s.Speed,
	   s.Luck,
	   s.Mind
  FROM Items AS i
  JOIN [Statistics] AS s
    ON s.Id = i.StatisticId
	WHERE s.Mind > 
	(
		SELECT AVG(s.Mind)
		FROM [Statistics] AS s
	) 
	AND s.Luck > 
	(
		SELECT AVG(s.Luck)
		FROM [Statistics] AS s
	) 
	AND s.Speed >
	(
		SELECT AVG(s.Speed)
		FROM [Statistics] AS s
	) 
	ORDER BY i.Name

	

--06. Display All Items about Forbidden Game Type

	SELECT 
		   i.Name,
		   i.Price,
		   i.MinLevel,
		   gt.Name AS [Forbitten Game Type] 
	  FROM Items AS i
	  FULL JOIN GameTypeForbiddenItems AS gtfi
	    ON gtfi.ItemId = i.Id
	  FULL JOIN GameTypes AS gt
	    ON gtfi.GameTypeId = gt.Id
		ORDER BY gt.Name DESC, i.Name ASC;



-- 07. Buy Items for User in Game



--08. Peaks and Mountains
	SELECT 
		   p.PeakName,
		   m.MountainRange,
		   p.Elevation 
	  FROM Peaks AS p
	  JOIN Mountains AS m
	    ON m.Id = p.MountainId
  ORDER BY p.Elevation DESC, p.PeakName




--09. Peaks with Mountain, Country and Continent

	SELECT 
		   p.PeakName,
		   m.MountainRange,
		   c.CountryName,
		   cc.ContinentName
	  FROM Peaks AS p
	  JOIN Mountains AS m
	    ON m.Id = p.MountainId
	  JOIN MountainsCountries AS mc
	    ON m.Id = mc.MountainId
	  JOIN Countries AS c
	    ON mc.CountryCode = c.CountryCode
	  JOIN Continents AS cc
	    ON c.ContinentCode = cc.ContinentCode
  ORDER BY p.PeakName, c.CountryName;
	  		


--10. Rivers by Country
	
	SELECT 
		   c.CountryName,
		   cc.ContinentName,
		   COUNT(r.Id) AS RiversCount,
		   CASE 
				WHEN (SUM(r.Length) IS NULL)
				THEN ('0')
				ELSE SUM(r.Length) 
		   END AS TotalLength
	  FROM Countries AS c
 FULL JOIN Continents AS cc
	    ON c.ContinentCode = cc.ContinentCode
 FULL JOIN CountriesRivers AS cr
	    ON c.CountryCode = cr.CountryCode
 FULL JOIN Rivers AS r
	    ON cr.RiverId = r.Id
  GROUP BY c.CountryName, cc.ContinentName
  ORDER BY COUNT(r.Id) DESC, SUM(r.Length) DESC, c.CountryName ASC



--11. Count of Countries by Currency

		SELECT 
			   c.CurrencyCode,
			   c.[Description] AS Currency,
			   (
				SELECT 
					   COUNT(*)
				  FROM Countries AS cc
				 WHERE cc.CurrencyCode = c.CurrencyCode
			   ) AS NumberOfCountries
		  FROM Currencies AS c
	  ORDER BY NumberOfCountries DESC, c.[Description] ASC


--12. Population and Area by Continent

	SELECT 
		   c.ContinentName,
		   (
				SELECT SUM(cc.AreaInSqKm) 
				  FROM Countries AS cc
				 WHERE cc.ContinentCode = c.ContinentCode
		   ) AS CountriesArea,
		   (
				SELECT SUM(CAST(cc.[Population] AS BIGINT)) 
				  FROM Countries AS cc
				 WHERE cc.ContinentCode = c.ContinentCode
		   ) AS CountriesPopulation 
      FROM Continents AS c
  ORDER BY CountriesPopulation DESC




--13. Monasteries by Country

--part 1
CREATE TABLE Monasteries
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(100) NOT NULL,
	CountryCode CHAR(2) FOREIGN KEY
	REFERENCES Countries(CountryCode)
)


--part 2
	INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')
	

--part 3
ALTER TABLE Countries
ADD IsDeleted BIT NOT NULL DEFAULT 0;
 

 --part 4
		UPDATE Countries
		SET IsDeleted = 1
		WHERE CountryName IN
		(
  SELECT table2.CountryName FROM 
	(SELECT c.CountryName, 
	        COUNT(r.Id) AS RiverCount
	   FROM Rivers AS r 
	   JOIN CountriesRivers AS cr
		 ON cr.RiverId = r.Id
	   JOIN Countries AS c
		 ON c.CountryCode = cr.CountryCode
      GROUP BY c.CountryName
	  HAVING COUNT(r.Id) > 3) AS table2
		)


--part 5

	SELECT 
	       m.Name,
		   c.CountryName
	  FROM Countries AS c
	  JOIN Monasteries AS m
	    ON c.CountryCode = m.CountryCode
		WHERE c.IsDeleted = 0
		ORDER BY m.Name;




--14. Monasteries by Continents and Countries

--part 1
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'


--part 2
INSERT INTO Monasteries
VALUES
('Hanga Abbey', (select CountryCode 
				  from Countries where CountryName = 'Tanzania'))


--part 3
INSERT INTO Monasteries
VALUES
('Myin-Tin-Daik', (select CountryCode 
				  from Countries where CountryName = 'Myanmar'))


--part 4
	SELECT cc.ContinentName,
		   c.CountryName,
		   COUNT(m.Id) AS MonasteriesCount
	  FROM Monasteries AS m
	  FULL JOIN Countries AS c
	    ON m.CountryCode = c.CountryCode
	  FULL JOIN Continents AS cc
	    ON cc.ContinentCode = c.ContinentCode
  GROUP BY cc.ContinentName, c.CountryName
  ORDER BY COUNT(m.Id) DESC, c.CountryName ASC		    

	