
  CREATE VIEW v_HighestPeak AS
  SELECT TOP (1) * FROM Peaks 
  ORDER BY Elevation DESC
  
  SELECT * FROM v_HighestPeak 

  SELECT * 
  INTO MyContinents
  FROM Continents

  CREATE SEQUENCE seq_Customers_CustomerID
  AS INT
  START WITH 1
  INCREMENT BY 1
  
  SELECT NEXT VALUE FOR seq_Customers_CustomerID
