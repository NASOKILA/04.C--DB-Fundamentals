

--19. *Cash in User Games Odd Rows


--






--22. Number of Users for Email Provider

select * from Users



--23. All User in Games

select 
	g.Name AS Game,
	gt.Name AS [Game Type],
	u.Username,
	ug.Level,
	ug.Cash,
	c.Name AS Character
from Games AS g
JOIN GameTypes AS gt 
ON g.GameTypeId = gt.Id
JOIN UsersGames AS ug
ON g.Id = ug.GameId
JOIN Users AS u
ON ug.UserId = u.Id
JOIN Characters AS c
ON c.Id = ug.CharacterId
Order by ug.Level DESC, u.Username, g.Name;




--24. Users in Games with Their Items

select 
	u.Username,
	g.Name, 
	Count(i.Id) AS [Items Count],
	SUM(i.Price) AS [Items Price]
from Users AS u
JOIN UsersGames AS ug
ON u.Id = ug.UserId
JOIN Games AS g
ON g.Id = ug.GameId
JOIN UserGameItems AS ugi
ON ugi.UserGameId = ug.Id
JOIN Items AS i
ON i.Id = ugi.ItemId
GROUP BY u.Username, g.Name
HAVING Count(i.Id) >= 10
ORDER BY Count(i.Id) DESC, SUM(i.Price) DESC, u.Username;



--25. * User in Games with Their Statistics


--26. All Items with Greater than Average Statistics
--use Diablo

--RABOTI NO NE TRUGVA V JUDJE
select  
	i.Name, 
	i.Price,
	i.MinLevel,
	s.Strength,
	s.Defence,
	s.Speed,
	s.Luck,
	s.Mind
from Items AS i
JOIN [Diablo].[dbo].[Statistics] AS s
ON s.Id = i.StatisticId
WHERE(
s.Mind > (select AVG(Mind) 
FROM [Diablo].[dbo].[Statistics]) AND 
s.Luck > (select AVG(Luck) 
FROM [Diablo].[dbo].[Statistics]) AND
s.Speed > (select AVG(Speed) 
FROM [Diablo].[dbo].[Statistics]))
ORDER BY i.Name;
 
(select AVG(Luck) FROM [Diablo].[dbo].[Statistics]) 
(select AVG(Speed) FROM [Diablo].[dbo].[Statistics]) 


--27. Display All Items with Information about Forbidden Game Type

	select 
		i.Name AS Item, 
		i.Price, 
		i.MinLevel,
		gt.Name AS [Forbidden Game Type]
	from Items AS i
	LEFT JOIN GameTypeForbiddenItems AS gtfi
	ON gtfi.ItemId = i.Id
	LEFT JOIN GameTypes AS gt
	ON gt.Id = gtfi.GameTypeId 
	ORDER BY gt.Name DESC, i.Name;


	--29. Peaks and Mountains
	--use Geography

	Select 
		p.PeakName,
		m.MountainRange,
		p.Elevation 
	from Peaks AS p
	JOIN Mountains AS m
	ON m.Id = p.MountainId
	Order by Elevation DESC, PeakName


	--30. Peaks with Mountain, Country and Continent
	
	Select 
		p.PeakName,
		m.MountainRange AS Mountain,
		c.CountryName,
		cc.ContinentName
	from Peaks AS p
	JOIN Mountains AS m
	ON m.Id = p.MountainId
	JOIN MountainsCountries AS mc
	ON mc.MountainId = m.Id
	JOIN Countries AS c
	ON mc.CountryCode = c.CountryCode
	JOIN Continents AS cc
	ON cc.ContinentCode = c.ContinentCode
	Order by PeakName, ContinentName
	



	--31. Rivers by Country

	select 
		c.CountryName,
		cc.ContinentName,
		COUNT(r.Id) AS [RiversCount],
		CASE 
			WHEN(COUNT(r.Id) = 0)
			THEN '0' 
			ELSE SUM(r.Length) 
		END AS [TotalLength]
	from Countries AS c
	FULL JOIN Continents AS cc
	ON cc.ContinentCode = c.ContinentCode
	FULL JOIN CountriesRivers AS cr
	ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r
	ON r.Id = cr.RiverId
	GROUP BY c.CountryName, cc.ContinentName
	ORDER BY COUNT(r.Id) DESC, [TotalLength] DESC, c.CountryName




	--32. Count of Countries by Currency

	select 
		c.CurrencyCode,
		c.Description AS Curency,
		Count(cc.CountryName) AS NumberOfCountries
	from Currencies AS c
	left JOIN Countries AS cc
	ON c.CurrencyCode = cc.CurrencyCode
	GROUP BY c.CurrencyCode, c.Description
	ORDER BY Count(cc.CountryName) DESC, c.Description 





	--33. Population and Area by Continent
	--use Geography
	
	select 
		cc.ContinentName,
		SUM(c.AreaInSqKm) AS CountriesArea,
		SUM(CAST(Population AS decimal(10))) AS CountriesPopulation
	from Continents AS cc
	FULL JOIN Countries AS c
	ON c.ContinentCode = cc.ContinentCode
	GROUP BY cc.ContinentName
	ORDER BY SUM(CAST(Population AS decimal(10))) DESC





	--34. Monasteries by Country

	CREATE TABLE Monasteries
	(
		Id INT PRIMARY KEY IDENTITY,
		Name varchar(50) NOT NULL,
		CountryCode Char(2) FOREIGN KEY REFERENCES Countries (CountryCode)
	)

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










