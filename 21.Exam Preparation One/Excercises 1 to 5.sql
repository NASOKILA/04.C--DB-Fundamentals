


--01. DDL

CREATE DATABASE WMS;

USE WMS;

CREATE TABLE Clients
(
	ClientId INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone CHAR(12) NOT NULL,	
)


CREATE TABLE Mechanics
(
	MechanicId INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Address VARCHAR(255) NOT NULL
)

CREATE TABLE Models
(
	ModelId INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Jobs
(
	JobId INT PRIMARY KEY IDENTITY(1,1),
	ModelId INT NOT NULL FOREIGN KEY REFERENCES Models(ModelId),
	Status VARCHAR(11) NOT NULL 
		CHECK (Status IN ('Pending', 'In Progress', 'Finished')) --Avaliable things
		DEFAULT 'Pending',
	ClientId INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
	MechanicId INT FOREIGN KEY REFERENCES Mechanics(MechanicId),
	IssueDate DATE NOT NULL,
	FinishDate DATE
)

CREATE TABLE Orders 
(
	OrderId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	JobId INT NOT NULL FOREIGN KEY REFERENCES Jobs(JobId),
	IssueDate DATE,
	Delivered BIT NOT NULL DEFAULT 0
)


CREATE TABLE Vendors
(
	VendorId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Parts
(
	PartId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	SerialNumber VARCHAR(50) NOT NULL UNIQUE,
	Description VARCHAR(255),
	Price DECIMAL(6, 2) NOT NULL CHECK(Price > 0),--Up to 9999,99 and less than 0 !!!
	VendorId INT NOT NULL FOREIGN KEY REFERENCES Vendors(VendorId),
	StockQty INT NOT NULL CHECK(StockQty >= 0) DEFAULT 0
)

CREATE TABLE OrderParts
(
	OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId),
	PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT NOT NULL CHECK(Quantity > 0) DEFAULT 1,
	CONSTRAINT PK_Orders_Parts PRIMARY KEY (OrderId, PartId)
)

CREATE TABLE PartsNeeded
(
	JobId INT NOT NULL FOREIGN KEY REFERENCES Jobs(JobId),
	PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT NOT NULL CHECK(Quantity > 0) DEFAULT 1,
	CONSTRAINT PK_Jobs_Parts PRIMARY KEY (JobId, PartId)
)


--Part two: Import the data from the DataSet File we have from the resourses.




--02.Insert:
INSERT INTO Clients(FirstName, LastName, Phone)
VALUES
('Teri', 'Ennaco', '570-889-5187'),
('Merlyn', 'Lawler', '201-588-7810'),
('Georgene', 'Montezuma', '925-615-5185'),
('Jettie', 'Mconnell', '908-802-3564'),
('Lemuel', 'Latzke', '631-748-6479'),
('Melodie', 'Knipp', '805-690-1682'),
('Candida', 'Corbley', '908-275-8357')

INSERT INTO Parts(SerialNumber, Description, Price,VendorId)
VALUES
('WP8182119', 'Door Boot Seal', '117.86', (SELECT 
												  v.VendorId 
											 FROM Vendors AS v
											WHERE v.Name = 'Suzhou Precision Products'
										  )),
('W10780048','Suspension Rod','42.81',( SELECT 
											   v.VendorId 
										  FROM Vendors AS v
										 WHERE v.Name = 'Shenzhen Ltd.'
									  )),	
('W10841140', 'Silicone Adhesive', '6.77', (SELECT 
												   v.VendorId 
											  FROM Vendors AS v
											 WHERE v.Name = 'Fenghua Import Export'
										   )),
('WPY055980', 'High Temperature Adhesive', '13.94', (SELECT 
															v.VendorId 
													   FROM Vendors AS v
													  WHERE v.Name = 'Qingdao Technology'
													))	
													


--03. Update

UPDATE Jobs
SET Status = 'In Progress'
WHERE MechanicId IS NULL

UPDATE Jobs
SET MechanicId = 3
WHERE MechanicId IS NULL



--04. Delete

DELETE FROM  OrderParts
WHERE OrderId = 19;

DELETE FROM Orders
WHERE OrderId = 19;



--05. Part 1: Run the DataSet File again to start over AND USE A NEW QUERY WINDOW.































