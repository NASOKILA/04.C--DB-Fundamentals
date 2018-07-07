
  CREATE VIEW v_SomeProjects AS
  SELECT * FROM Projects
  WHERE ProjectID >= 1 AND ProjectID <= 10
  
  GO

  SELECT Name, EndDate FROM v_SomeProjects
