


--  VAJNOOOOO !!!          set dateformat mdy


INSERT INTO Employees(FirstName, LastName, Gender, Birthdate, DepartmentId)
VALUES
('Marlo', 'O’Malley', 'M', '9/21/1958', 1),
('Niki', 'Stanaghan', 'F', '11/26/1969', (Select Id from Departments where Name = 'Emergency')),
('Ayrton', 'Senna', 'M', '03/21/1960 ', (Select Id from Departments where Name = 'Event Management')),
('Ronnie', 'Peterson', 'M', '02/14/1944', (Select Id from Departments where Name = 'Event Management')),
('Giovanna', 'Amati', 'F', '07/20/1959', (Select Id from Departments where Name = 'Roads Maintenance'))

INSERt INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, Description, UserId,	EmployeeId)
VALUES 
((SELECT Id FROM Categories WHERE Name = 'Snow Removal'), (SELECT Id FROM Status WHERE Label = 'waiting'), '04/13/2017', NULL, 'Stuck Road on Str.133', 6, 2),
((SELECT Id FROM Categories WHERE Name = 'Sports Events'), (SELECT Id FROM Status WHERE Label = 'completed'), '09/05/2015', '12/06/2015', 'Charity trail running',3,5),
((SELECT Id FROM Categories WHERE Name = 'Dangerous Building'), (SELECT Id FROM Status WHERE Label = 'in progress'), '09/07/2015', NULL, 'Falling bricks on Str.58', 5, 2),
((SELECT Id FROM Categories WHERE Name = 'Streetlight'), (SELECT Id FROM Status WHERE Label = 'completed'), '07/03/2017', '07/06/2017', 'Cut off streetlight on Str.11', 1,1)




--03 

UPDATE Reports
SET StatusId = 2
WHERE StatusId = 1 AND CategoryId = 4


SELECT COUNT(*) FROM Reports
WHERE StatusId = 2 AND CategoryId = 4;



--04
select * from Status
select * from Reports where StatusId = 4

DELETE FROM Reports WHERE StatusId = 4

begin tran


--05
select Username, Age from Users
Order by Age, Username desc
















