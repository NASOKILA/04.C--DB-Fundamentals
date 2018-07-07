--use Geography;
--Select all peaks in Rila
select 
	m.MountainRange,
	p.PeakName,
	p.Elevation
from Mountains AS m
JOIN Peaks AS p
ON p.MountainId = m.Id 
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC;