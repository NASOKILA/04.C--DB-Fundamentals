


  CREATE VIEW v_HighestPeak AS
  SELECT TOP (1) * FROM Peaks 
  ORDER BY Elevation DESC
  
  SELECT * FROM v_HighestPeak 

  --Vzimme vsichko ot Continents i go slagame v nova baza MyContinents
  SELECT * 
  INTO MyContinents
  FROM Continents

  CREATE SEQUENCE seq_Customers_CustomerID
  AS INT
  START WITH 1
  INCREMENT BY 1
  
  SELECT NEXT VALUE FOR seq_Customers_CustomerID
  --Tova ni vrushta sledvashata stoinost
  --Polezno e ako iskame primerno da imame dve tablici v koito id-to da ne se povtarq












