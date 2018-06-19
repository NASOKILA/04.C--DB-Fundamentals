

/*
 S JOIN mojem da izvlichame informaciq ot mapping tablica !!!
*/


--Zd 1. OneToOne
CREATE TABLE Passports(
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber varchar(50)
)

CREATE TABLE Persons(
	PersonID  INT NOT NULL,
	FirstName varchar(50),
	Salary money,
	PassportID INT UNIQUE
)

INSERT INTO Passports
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

INSERT INTO Persons
VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

ALTER TABLE Persons
ADD CONSTRAINT PK_Persons
PRIMARY KEY (PersonID);

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_PassportID
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID);



--Zd 2. OneToMany / ManyToOne
CREATE TABLE Manufacturers(
ManufacturerID INT PRIMARY KEY,
Name varchar(50),
EstablishedOn Date
)

CREATE TABLE Models(
ModelID INT PRIMARY KEY,
Name varchar(50),
ManufacturerID INT,
CONSTRAINT FK_Manufacturers_Models
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers
VALUES
(1,'BMW','07/03/1916'),
(2,'Tesla','01/01/2003'),
(3,'Lada','01/05/1966');

INSERT INTO Models
VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);


--Zd 3. ManyToMany
CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY(1,1),
Name varchar(50)
)

CREATE TABLE Exams(
ExamID INT PRIMARY KEY,
Name varchar(50)
)

CREATE TABLE StudentsExams(
StudentID INT,
ExamID INT,
CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentID, ExamID),
CONSTRAINT FK_StudentsExams_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO Students
VALUES
('Mila'),
('Toni'),
('Ron');

INSERT INTO Exams
VALUES
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g');

INSERT INTO StudentsExams
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);



--Zd 4. Self-Referencing table
CREATE TABLE Teachers
(
	TeacherID INT PRIMARY KEY,
	Name varchar(50),
	ManagerID INT,
	CONSTRAINT FK_Teachers_Managers 
	FOREIGN KEY (ManagerID) REFERENCES Teachers(TeacherID)  
)

INSERT INTO Teachers
VALUES
(101, 'John', NULL),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101);



--Zd 5. Online Store Database

--CREATE DATABASE OnlineStore;
--USE OnlineStore

CREATE TABLE Cities(
	CityID INT PRIMARY KEY IDENTITY(1,1),
	Name varchar(50)
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	Name varchar(50),
	BirthDay Date,
	CityID INT,
	CONSTRAINT FK_Customers_CityID
	FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT,
	CONSTRAINT FK_Orders_CustomerID 
	FOREIGN KEY (CustomerID) 
	REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes(
	ItemTypeID INT PRIMARY KEY IDENTITY(1,1),
	Name varchar(50)
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY IDENTITY(1,1),
	Name varchar(50),
	ItemTypeID INT,
	CONSTRAINT FK_Items_ItemTypeID
	FOREIGN KEY (ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
	OrderID INT,
	ItemID INT,
	CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID),
	CONSTRAINT FK_OrderItems_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_ItemID FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)



--Zd 6. University database

--CREATE DATABASE University;
--USE University;

CREATE TABLE Majors(
	MajorID INT PRIMARY KEY IDENTITY(1,1),
	Name varchar(50)
)

CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY(1,1),
	StudentNumber INT,
	StudentName varchar(50),
	MajorID INT,
	CONSTRAINT FK_Students_MajorID FOREIGN KEY (MajorID) 
	REFERENCES Majors(MajorID)
)


CREATE TABLE Payments(
	PaymentID INT PRIMARY KEY IDENTITY(1,1),
	PaymentData Date,
	PaymentAmount Money,
	StudentID INT UNIQUE,
	CONSTRAINT FK_Payments_StudentID FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID) 
)

CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY IDENTITY(1,1),
	SubjectName varchar(50)
)

CREATE TABLE Agenda(
	StudentID INT,
	SubjectID INT,
	CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
	CONSTRAINT FK_Agenda_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),	
	CONSTRAINT FK_Agenda_SubjectID FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)


--Zd 7 i Zd 8 veche gi videhme !!!


--Zd 9. Peaks in Rila
--USE Geography

SELECT MountainRange, PeakName, Elevation FROM Mountains AS m
JOIN Peaks AS p
ON p.MountainId = m.Id AND m.MountainRange = 'Rila' 
ORDER BY p.Elevation DESC


