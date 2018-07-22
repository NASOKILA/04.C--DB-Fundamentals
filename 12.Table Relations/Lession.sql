
CREATE DATABASE Test2;

CREATE TABLE Mountains(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

CREATE TABLE Peaks(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50),
MountainId INT NOT NULL,
CONSTRAINT FK_Mountains_Peaks
FOREIGN KEY (MountainId)
REFERENCES Mountains(Id)
)

INSERT INTO Mountains
VALUES
('Rila'),
('Stara planina'),
('Pirin'),
('Rodopite');

INSERT INTO Peaks
VALUES
('Musala',1),
('Vihren',3),
('Botev',2),
('Alada',4);

create table Employees(
Id int primary key identity(1,1),
FirstName varchar(50),
LastName varchar(50),
Salary money
)

create table Projects(
Id int primary key identity(1,1),
Name varchar(255) not null,
Description varchar(max),
StartDate Date Default GETDATE(),
EndDate Date 
)

Create table EmployeesProjects(
EmplyeeId int foreign key references Employees(Id),
ProjectId int foreign key references Projects(Id),
constraint PK_EmployeeId_ProjectId
primary key (EmplyeeId, ProjectId)
)

insert into Employees
values 
('Atanas', 'Kambitov', 500),
('Asen', 'Kambitov', 200),
('Petur', 'Doklev', 1500);

insert into Projects(Name,Description)
values
('FirstProject', 'This is the description...'),
('SecondProject', 'This is the description...'),
('ThirdProject', 'This is the description...');

insert into EmployeesProjects
values
(1,3),
(2,2),
(3,1);

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY(1,1),
Model varchar(50)
)

CREATE TABLE Drivers(
Id INT PRIMARY KEY IDENTITY(1,1),
Name varchar(50) NOT NULL,
CarId INT UNIQUE,
CONSTRAINT FK_Cars
FOREIGN KEY (CarId)
REFERENCES Cars(Id)
)

insert into Cars
values
('Opel'),
('Reno'),
('BMW'),
('Smart');

insert into Drivers
values
('Toni',1),
('Asi', 4),
('Petre',2),
('Naso',3);

select * from Drivers
select * from Cars

CREATE DATABASE Football;

CREATE TABLE Teams(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

CREATE TABLE Leagues(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL
)

CREATE TABLE LeaguesTeams(
LeagueId INT,
TeamId INT,

CONSTRAINT PK_LeagueId_TeamId
PRIMARY KEY (LeagueId, TeamID),

CONSTRAINT FK_Teams
FOREIGN KEY (TeamId) 
REFERENCES Teams(Id),

CONSTRAINT FK_Leagues
FOREIGN KEY (LeagueId) 
REFERENCES Leagues(Id)
)

CREATE TABLE Players(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PlayerNumber INT,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Salary Decimal(8,2) default 0,
	TeamId INT,
	CONSTRAINT FK_Teams_Players
	FOREIGN KEY (TeamId)
	REFERENCES Teams(Id) 
)

CREATE TABLE Managers(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Salary Decimal(8,2) default 0,
	TeamId INT UNIQUE NOT NULL,
	CONSTRAINT FK_Teams_Managers
	FOREIGN KEY (TeamId)
	REFERENCES Teams(Id) 
)

USE Geography

SELECT 
MountainRange, PeakName, Elevation 
FROM Mountains
JOIN Peaks ON
Peaks.MountainId = Mountains.Id AND MountainRange = 'Rila'
ORDER BY Elevation DESC;

CREATE TABLE Products
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50)
)

CREATE TABLE Store
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50),
	ProductId INT,

	CONSTRAINT FK_Store_Products
	FOREIGN KEY (ProductId)
	REFERENCES Products(Id) ON DELETE CASCADE
)

DELETE FROM Products
WHERE Name = 'Bread';

SELECT * FROM Store

CREATE TABLE Owners
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50)
)

CREATE TABLE Factory
(
	Id INT PRIMARY KEY NOT NULL,
	Name varchar(50),
	OwnerId INT,

	CONSTRAINT FK_Factory_Owner
	FOREIGN KEY (OwnerId )
	REFERENCES Owners(Id) ON UPDATE CASCADE
)

UPDATE Owners
SET Id = 11
WHERE Name = 'Atanas';

SELECT * FROM Factory
