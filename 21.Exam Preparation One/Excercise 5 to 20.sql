



use WMS;

--05. Part 2 Clients by Name
	SELECT c.FirstName, 
		   c.LastName, 
		   c.Phone 
	  FROM Clients AS c
  ORDER BY c.LastName ASC, ClientId ASC



--06. Job Status
	SELECT 
		   j.Status, 
		   j.IssueDate 
	  FROM Jobs AS j
	 WHERE Status <> 'Finished'
	 ORDER BY j.IssueDate ASC , j.JobId ASC



--07. Mechanic Assignments
	  SELECT 
			 m.FirstName + ' ' + m.LastName AS Mechanic,
			 j.Status,
			 j.IssueDate
	    FROM Mechanics AS m
	    JOIN Jobs AS j
	      ON j.MechanicId = m.MechanicId
	ORDER BY m.MechanicId, j.IssueDate, j.JobId




--08. Current Clients
	 SELECT 
			c.FirstName + ' ' + c.LastName AS Client, 
			DATEDIFF(DAY, j.IssueDate, '2017-04-24 00:00:00') AS [Days going],
			j.Status
	   FROM Clients AS c
	   JOIN Jobs AS j
	     ON j.ClientId = c.ClientId
	  WHERE j.Status <> 'Finished'


	

--09. Mechanic Performance
	
	
		  SELECT 		 
				 m.FirstName + ' ' + m.LastName AS Mechanic,
				 AVG( DATEDIFF(DAY, j.IssueDate, FinishDate))AS [Average Days]
			FROM Mechanics AS m
			JOIN Jobs AS j
			  ON j.MechanicId = m.MechanicId
		   WHERE j.Status = 'Finished'
		GROUP BY m.FirstName + ' ' + m.LastName, m.MechanicId 
		ORDER BY m.MechanicId;
	



--10. Hard Earners

	SELECT TOP 3
		   	 m.FirstName + ' ' + m.LastName AS Mechanic,
			 COUNT(j.Status) AS Jobs
	  FROM Mechanics AS m
	  JOIN Jobs AS j
	    ON j.MechanicId = m.MechanicId 
	 WHERE j.Status <> 'Finished' 
	 GROUP BY m.FirstName + ' ' + m.LastName, m.MechanicId 
	 HAVING COUNT(j.Status) > 1
	 ORDER BY COUNT(j.Status) DESC, m.MechanicId ASC		  



--11. Available Mechanics

		 SELECT m.FirstName + ' ' + m.LastName AS Mechanic
		   FROM Mechanics AS m
		  WHERE m.MechanicId NOT IN (SELECT j.MechanicId 
									  FROM Jobs AS j
									 WHERE Status IN ('In Progress', 'Pending') 
									   AND MechanicId IS NOT NULL)
		  ORDER BY m.MechanicId





--12. Parts Cost
		 
		 
		 
		 --PONQKOGA V TESTOVETE ISKA '0' A NASHETO NE DAVA REZULTAT
		 --ZATOVE GO SLAGAME V CASE END STATEMENT		
		  SELECT 
				 CASE
					WHEN (SUM(p.Price * op.Quantity) IS NULL)
					THEN '0'
					ELSE SUM(p.Price * op.Quantity)
				 END AS [Parts Total]
				 
			FROM Parts AS p
			JOIN OrderParts AS op
			  ON op.PartId = p.PartId
			JOIN Orders AS o
			  ON o.OrderId = op.OrderId
			  WHERE DATEDIFF(WEEK,o.IssueDate, '2017-04-24' ) <= 3
								
		
			  


--13.	Past Expenses

		
			  SELECT j.JobId,
					CASE
						WHEN (SUM(p.Price * op.Quantity) IS NULL)
						THEN '0'
						ELSE SUM(p.Price * op.Quantity)
					END AS Total 
			  FROM Jobs AS j
			  LEFT JOIN Orders AS o
				ON o.JobId = j.JobId
			 LEFT JOIN OrderParts AS op 
				ON op.OrderId = o.OrderId
			  LEFT JOIN Parts AS p
				ON p.PartId = op.PartId
			 WHERE Status = 'Finished'
			  GROUP BY j.JobId
			  ORDER BY SUM(p.Price) DESC, JobId ASC;
			  


--14.	Model Repair Time

		SELECT 
			 j.ModelId,
			 m.Name,
			 CAST(AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate)) AS VARCHAR(100)) + ' days' 
			 AS [Average Service Time]		
		FROM Jobs AS j
		JOIN Models AS m
		  ON m.ModelId = j.ModelId 
	   WHERE j.ModelId IN (SELECT 
							m.ModelId
						FROM Models AS m)
		 AND Status = 'Finished'
	GROUP BY j.ModelId, m.Name
	ORDER BY AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate)) ASC
		
				


--15. Faultiest Model

	SELECT TOP 1
    	 m.Name,
		 COUNT(*) AS [Times Serviced],
					(SELECT ISNULL(SUM(p.Price * op.Quantity), 0)
					   FROM Jobs AS j
					   JOIN Orders AS o ON o.JobId = j.JobId
					   JOIN OrderParts AS op ON o.OrderId = op.OrderId
					   JOIN Parts AS p ON p.PartId = op.PartId
					  WHERE j.ModelId = m.ModelId) AS [Parts Total]
	FROM Models AS m
	 JOIN Jobs AS j
	ON j.ModelId = m.ModelId
	GROUP BY m.Name, m.ModelId
	ORDER BY COUNT(*) DESC
	




--16. Missing Parts


		 SELECT p.PartId,
			    p.Description,
				SUM(pn.Quantity) AS Required,
				AVG(p.StockQty) AS [In Stock],
				ISNULL(SUM(op.Quantity),0) AS Ordered
			FROM Parts AS p
			JOIN PartsNeeded AS pn ON p.PartId = pn.PartId
			JOIN Jobs AS j ON j.JobId = pn.JobId
			LEFT JOIN Orders AS o ON o.JobId = j.JobId
			LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
			WHERE j.Status <> 'Finished'
			GROUP BY p.PartId, p.Description
			HAVING SUM(pn.Quantity) > AVG(p.StockQty) + ISNULL(SUM(op.Quantity), 0)
			ORDER BY p.PartId




--17.Cost of Order
GO
ALTER FUNCTION udf_GetCost(@JobId INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
	DECLARE @Result DECIMAL(4,2);

	IF(@JobId NOT IN (SELECT JobId FROM Jobs))
	BEGIN
		RETURN 0;
	END

	ELSE
	BEGIN
		SET @Result = (
	    SELECT 
		 	  SUM(p.Price * op.Quantity) 
		 FROM Jobs AS j 
		 JOIN Orders AS o
		   ON o.JobId = j.JobId
		 JOIN OrderParts AS op
		   ON op.OrderId = o.OrderId
		 JOIN Parts AS p
		   ON p.PartId = op.PartId
		WHERE j.JobId = @JobId) 
	END
	
	IF(@Result IS NULL)
	BEGIN 
		SET @Result = 0;
	END
		 	
	RETURN @Result;
END
GO

select dbo.udf_GetCost(3)




--18. Place Order
GO
CREATE PROC usp_PlaceOrder 
@JobId INT, @SerialNum VARCHAR(MAX), @Quantity INT
AS
BEGIN
	
END
GO

select * from Orders AS o
JOIN Jobs AS j ON j.JobId = o.JobId
WHEre o.JobId = 1



select * from Orders






--19.	Detect Delivery
GO
CREATE TRIGGER TR_DeliveryDetector ON Orders
AFTER UPDATE
AS
BEGIN
		
		IF((select Delivered from deleted) = 0 AND (select Delivered from inserted) = 1)
			BEGIN 
					
					/*Idto na parcheto i poruchkata i stokata koqto trqbva da insertnem v stockquantity na tov parche*/
				   SELECT *
					FROM OrderParts AS op
				   WHERE OrderId IN (select OrderId from inserted)
				   

				   
					/*/*Parchetata koito trqbva da mu updeitnem stokata*/
					select * from Parts
					where PartId IN (select PartId 
									from OrderParts 
									where OrderId = (select OrderId 
													 from inserted))
					*/
					
				  
				 /*Samo quantities koito trqbva da dobavim kum stokata*/ 
				DECLARE @QuantityOfOrderedParts TABLE(
					PartId INT NOT NULL,
					Quantity INT NOT NULL
				)

				INSERT INTO @QuantityOfOrderedParts 
					SELECT op.PartId, op.Quantity 
					FROM OrderParts AS op
				   WHERE OrderId IN (select OrderId from inserted)
			
				
				/*Idtata na koito trqbva da dobavim qunatities*/
				DECLARE @PartIdsOfOrderedParts TABLE (
					PartId INT NOT NULL
				)
				INSERT INTO @PartIdsOfOrderedParts 
					select PartId 
					from OrderParts 
					where OrderId IN (select OrderId from inserted)
			

					
			
					/*Updeitvame si stokata*/
					UPDATE Parts
					SET StockQty += qop.Quantity
					FROM Parts AS p
					JOIN @QuantityOfOrderedParts AS qop
					ON qop.PartId = p.PartId


				
			END
		ELSE
			BEGIN
				RETURN;
			END

END
GO

--testvame
UPDATE Orders
SET Delivered = 0
WHERE OrderId IN (21)





--20. Vendor Preference

		
		select m.FirstName + ' ' + m.LastName AS [Mechanic],
			   v.Name,
			   SUM(op.Quantity) AS parts,
			   CAST(CAST(CAST(COUNT(*) AS DECIMAL(6,2)) * 100 / Table1.TotalPartsCount AS INT) AS VARCHAR(100)) + '%' AS Preference

		  from Mechanics as m
		  JOIN Jobs as j on j.MechanicId = m.MechanicId
		  JOIN Orders as o on o.JobId = j.JobId
		  JOIN OrderParts as op on op.OrderId = o.OrderId
		  JOIN Parts as p on op.PartId = p.PartId
		  JOIN Vendors as v on v.VendorId = p.VendorId
		  JOIN 
		  
		(select 
			   m.FirstName + ' ' + m.LastName AS [Mechanic],
			   COUNT(p.PartId) AS TotalPartsCount
		  from Mechanics as m
		  JOIN Jobs as j on j.MechanicId = m.MechanicId
		  JOIN Orders as o on o.JobId = j.JobId
		  JOIN OrderParts as op on op.OrderId = o.OrderId
		  JOIN Parts as p on op.PartId = p.PartId
		  JOIN Vendors as v on v.VendorId = p.VendorId
		  GROUP BY m.FirstName + ' ' + m.LastName) AS Table1
		  ON Table1.Mechanic = m.FirstName + ' ' + m.LastName	  
		  GROUP BY v.Name, m.FirstName + ' ' + m.LastName,
			Table1.TotalPartsCount  
		  ORDER BY m.FirstName + ' ' + m.LastName ASC, 
			SUM(op.Quantity) DESC, 
			v.Name ASC



			Table1.TotalPartsCount














































