

/*
	Additional info:

	Mojem da polzvame IDENTITY (101,1) taka zapochva ot 101 i 
	se uvelichava s 1 na vseki nov red.

	CHAR(8) Oznachava tochno 8 sinvola
	VARCHAR(8) Oznachva do 8 sinvola, no moje i po malko

	Kato polzvame ALTER za FK kluchove nqma znachenie dali edna 
	tablica e suzdadena predi druga !!!!!!!!!!!

	Kogato dadem nqkakvo ime na danni i ni go izpishe v sinio, primerno
	Name, mojem da slojim [] za da spre da sveti v sinio: [Name].

	Mojem da polzvame IDENTITY_INSERT mnogo e lesno.
*/

--EXCERCISES:
--use test4


--01. OneToOne Relationship
CREATE TABLE Persons
(
	PersonID INT NOT NULL IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	Salary money,
	PassportID INT NOT NULL UNIQUE
)

CREATE TABLE Passports
(
	PassportID INT PRIMARY KEY IDENTITY(101,1),
	PassportNumber CHAR(8) NOT NULL
)

ALTER TABLE Persons
ADD CONSTRAINT PK_Persons
PRIMARY KEY (PersonID);

--Kato polzvame ALTER za FK kluchove nqma znachenie dali edna 
--tablica e suzdadena predi druga !!!!!!!!!!!
ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID);

--Trqbva purvo da vkarame pasportite predi da vkarvame horata zashtoto 
--togava pasportite nqma da gi ima i nqma da stane zashtoto shte budat NULL !!!!!
INSERT INTO Passports
VALUES 
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

INSERT INTO Persons
VALUES 
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)

INSERT INTO Persons
VALUES 
('Yana1', 60220.00, 101)
--UNIQUE RABOTI !!!!!!!!!

select * from Persons
select * from Passports



--02. OneToMany Relationship
CREATE TABLE Manufacturers
(
	ManufacturerID INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(25) NOT NULL,
	EstablishedOn DATE
	CONSTRAINT PK_Manufacturer PRIMARY KEY (ManufacturerID)
)

CREATE TABLE Models
(
	ModelID INT NOT NULL,
	Name VARCHAR(25) NOT NULL,
	ManufacturerID INT NOT NULL
	CONSTRAINT PK_Models PRIMARY KEY (ModelID)
	CONSTRAINT FK_Models_Manufacturers 
	FOREIGN KEY (ManufacturerID)
	REFERENCES Manufacturers(ManufacturerID)
)


INSERT INTO Manufacturers
VALUES 
('BMW', '07/03/1916'),
('Tesla', '01/01/2003'),
('Lada', '01/05/1966')

INSERT INTO Models
VALUES 
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S',2),
(104, 'Model X',2),
(105, 'Model 3',2),
(106, 'Nova',3)


select * from Manufacturers
select * from Models



--03. ManyToMany Relationship

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
	
)

CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE StudentsExams
(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL
	
	PRIMARY KEY (StudentID, ExamID)

	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO Students
VALUES 
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron')

INSERT INTO Exams
VALUES 
(101, 'SpringMVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g')

INSERT INTO StudentsExams
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)


select * from Exams
select * from Students
select * from StudentsExams




--04 Self-Referencing

CREATE TABLE Teachers
(
	TeacherID INT NOT NULL,
	[Name] VARCHAR(25) NOT NULL,
	ManagerID INT
)

ALTER TABLE Teachers
ADD CONSTRAINT PK_Teachers
PRIMARY KEY (TeacherID);

ALTER TABLE Teachers
ADD CONSTRAINT FK_ManagerID_Teachers
FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID);

/*
	
*/

INSERT INTO Teachers
VALUES 
(101, 'John', NULL),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101)


select * from Teachers


--05. Online Store Database

CREATE DATABASE OnlineStore2;
USE OnlineStore2;

CREATE TABLE ItemTypes
(
	ItemTypeID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Items
(
	ItemID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	ItemTypeID INT NOT NULL FOREIGN KEY
	REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Cities
(
	CityID INT NOT NULL,
	Name VARCHAR(50) NOT NULL
	
	CONSTRAINT PK_Cities PRIMARY KEY (CityID)
)

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Birthday DATE,
	CityID INT NOT NULL,

	CONSTRAINT FK_Customers_Cities 
	FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT NOT NULL FOREIGN KEY 
	REFERENCES Customers (CustomerID)
)

CREATE TABLE OrderItems
(
	OrderID INT,
	ItemID INT

	CONSTRAINT PK_OrderItems
	PRIMARY KEY (OrderID, ItemID),

	CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY (OrderID) 
	REFERENCES Orders (OrderID),

	CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY (ItemID) 
	REFERENCES Items (ItemID)
)


--06. University Database
CREATE DATABASE University2;
USE University2;


CREATE TABLE Majors
(
	MajorID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Students
(
	StudentID INT NOT NULL,
	StudentNumber INT NOT NULL UNIQUE, -- trqbva da e unique
	StudentName VARCHAR(50) NOT NULL,
	MajorID INT NOT NULL

	CONSTRAINT PK_Students PRIMARY KEY (StudentID)
	
	CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID)
	REFERENCES Majors (MajorID)
)

CREATE TABLE Payments
(
	PaymentID INT NOT NULL,
	PaymentDate DATETIME, -- Zashtoto shte ni trqbva i vremeto
	PaymentAmount money,
	StudentID INT NOT NULL

	CONSTRAINT PK_Payments 
	PRIMARY KEY (PaymentID)

	CONSTRAINT FK_Payments_Student
	FOREIGN KEY (StudentID)
	REFERENCES Students (StudentID) 
)

CREATE TABLE Subjects
(
	SubjectID INT PRIMARY KEY,
	SubjectName VARCHAR(50) NOT NULL
)

CREATE TABLE Agenda
(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL

	CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
	
	CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID),
	
	CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID)
	REFERENCES Subjects(SubjectID)  
)



--07. Create an E/R Diagram of the SoftUni Database
--Done it



--08. Create E/R Diagram on Geography Database
--Done it



--09. *Peaks in Rila
--USE Geography;

select * from Peaks

SELECT
	m.MountainRange,
	p.PeakName,
	p.Elevation
FROM Mountains AS m
JOIN Peaks AS p
ON p.MountainId = m.Id
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC



