





--05
		select p.Name, p.Price, p.Description 
		from Products as p
		order by p.Price DESC, p.Name ASC


--06

select i.name, i.Description, i.OriginCountryId from Ingredients AS i
WHere i.OriginCountryId IN (1,10,20)
order by i.Id ASC


--07

select TOP (15) 
		i.Name,
		i.Description,
		c.Name
from Ingredients AS i
JOIN Countries AS c ON c.Id = i.OriginCountryId
WHERE c.Name  IN ('Bulgaria', 'Greece')
ORDER BY i.Name ASC, c.Name ASC



--08

		select TOP 10
				p.Name, 
				p.Description,
				AVG(f.Rate) AS AverageRate,
				COUNT(f.Id) AS FeedbacksAmount
		
		 from Products AS p
		 JOIN Feedbacks AS f ON f.ProductId = p.Id
		 GROUP BY p.Name, p.Description
		 ORDER BY AVG(f.Rate) DESC, COUNT(f.Id) DESC



--09.

		select 
				 f.ProductId,
				 f.Rate,
				 f.Description,
				 c.Id,
				 c.Age,
				 c.Gender
	from Feedbacks AS f
	JOIN Customers AS c ON c.Id = f.CustomerId
	WHERE f.Rate < 5.0
	Order by f.ProductId DESC, f.Rate ASC

	

--10.

			select 
				   CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
				   PhoneNumber,
				   Gender
			from Customers AS c
			LEFT JOIN Feedbacks AS f ON f.CustomerId = c.Id
			WHERE f.Id IS NULL
		
--11.
		select 
				f.ProductId,
				c.FirstName + ' ' + c.LastName AS CustomerName,
				f.Description
		from Customers AS c
		JOIN Feedbacks AS f on f.CustomerId = c.Id
		JOIN Products AS p on p.Id = f.ProductId




		Select 
				f.ProductId,
				c.FirstName + ' ' + c.LastName AS CustomerName,
				f.Description
		  From Feedbacks as f
		JOIN Customers AS c on f.CustomerId = c.Id
		JOIN
		(select 
				c.FirstName + ' ' + c.LastName AS CustomerName,
				
				COUNT(f.CustomerId)  AS Numbers
		 from Feedbacks AS f
		 JOIN Customers AS c on f.CustomerId = c.Id
		 GROUP BY c.FirstName + ' ' + c.LastName 
		 HAVING COUNT(f.CustomerId) >= 3) AS table1
		 ON table1.CustomerName = c.FirstName + ' ' + c.LastName
		 WHERE table1.CustomerName = c.FirstName + ' ' + c.LastName
		 Order BY ProductId, c.FirstName + ' ' + c.LastName, f.Id




--12

		select 
			   c.FirstName,
			   c.Age,
			   c.PhoneNumber
			   
		  from Customers as c
		  JOIN Countries AS cc ON cc.Id = c.CountryId
		  WHERE (c.Age >= 21 AND c.FirstName LIKE '%an%') OR 
		  (cc.Name <> 'Greece' AND SUBSTrING(c.PhoneNumber, 9,2) = 38)
		  ORDER BY c.FirstName, c.Age DESc





	--13.
		
		select * from 
		(select 
				d.Name As DistributorName,
				i.Name as IngredientName,
				p.Name as ProductName,
				AVG(f.Rate) AS AverageRate		
		from Distributors AS d
		JOIN Ingredients AS i ON i.DistributorId = d.Id
		JOIN ProductsIngredients AS [pi] ON [pi].IngredientId = i.Id
		JOIN Products AS p ON p.Id = [pi].ProductId 
		JOIN Feedbacks AS f ON f.ProductId = p.Id
		GROUP BY d.Name, i.Name, p.Name
		HAVING AVG(f.Rate) BETWEEN 5 AND 9
		) as Table1
		ORDER BY Table1.DistributorName, Table1.IngredientName, Table1.ProductName
		




		--14.

		select TOP 1 WITH TIES
				c.Name,
				AVG(f.Rate) AS FeedbackRate
		 from Countries as c
		 JOIN Customers AS cc ON cc.CountryId = c.Id
		 JOIN Feedbacks AS f ON f.CustomerId = cc.Id
		 GROUP BY c.Name
		 Order BY AVG(f.Rate) DESC


		--15

		 select 
				cc.Name,
				BestDistributors.DistributorName
			from		
				(
				select 
					i.Id AS IngredientId,
					ccc.Id AS CountryId,
					ccc.Name AS CountryName,
					dd.Name AS DistributorName
				from Distributors as dd
				JOIN Countries AS ccc ON ccc.Id = dd.CountryId
				JOIN Ingredients AS i ON i.DistributorId = dd.Id
				GROUP BY ccc.Name,dd.Name, ccc.Id, i.Id 
				
				) AS BestDistributors
		JOIN Countries AS cc ON cc.Id = BestDistributors.CountryId
		GROUP BY cc.Name, BestDistributors.DistributorName
		ORDER BY 




		
		


		--16.
		GO
		CREATE VIEW v_UserWithCountries
		AS
		  SELECT 
				 cc.FirstName + ' ' + cc.LastName AS [CustomerName],
				 cc.Age,
				 cc.Gender,
				 c.Name AS CountryName 
			FROM Countries AS c
			JOIN Customers AS cc ON cc.CountryId = c.Id
			
		
		GO

		SELECT TOP 5 *
  FROM v_UserWithCountries
 ORDER BY Age





 --17.
 GO
 CREATE FUNCTION udf_GetRating
 ( @ProductName NVARCHAR(100))
 RETURNS VARCHAR(100)
 BEGIN
	DECLARE @Result VARCHAR(100);

	
	IF((
		Select 
			 AVG(f.Rate) 
			 From Products AS p 
		JOIN Feedbacks AS f ON f.ProductId = p.Id
		Where p.Name = @ProductName) < 5)
		BEGIN
			SET @Result = 'Bad';
		END 
	ELSE IF ((Select 
			 AVG(f.Rate) 
			 From Products AS p 
		JOIN Feedbacks AS f ON f.ProductId = p.Id
		Where p.Name = @ProductName) BETWEEN 5 AND 8)
		BEGIN
			SET @Result = 'Average';
		END
	ELSE IF ((Select 
			 AVG(f.Rate) 
			 From Products AS p 
		JOIN Feedbacks AS f ON f.ProductId = p.Id
		Where p.Name = @ProductName) > 8)
		BEGIN
			SET @Result = 'Good';
		END
		ELSE 
			SET @Result = 'No rating'


	RETURN @Result;
 END
 GO

 SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name)
  FROM Products
 ORDER BY Id



 --18.
 GO
 ALTER PROC usp_SendFeedback 
 (@CustomerId INT, @ProductId INT, @Rate DECIMAL(18,2), @Descrition NVARCHAR(300))
 AS
BEGIN
	BEGIN TRAN
	
	INSERt INtO Feedbacks (Description, Rate, ProductId, CustomerId)
	VALUES
	(@Descrition, @Rate, @ProductId, @CustomerId)

	IF((select COUNT(*) from Feedbacks
		Where CustomerId = @CustomerId) >= 3
		)
	BEGIN
		ROLLBACK;
		RAISERROR('You are limited to only 3 feedbacks per product!', 16,1)
		RETURN;
	END

	COMMIT;
	
END


 EXEC usp_SendFeedback 1, 5, 7.50, 'Average experience';
SELECT * FROM Feedbacks WHERE CustomerId = 1 AND ProductId = 5;


 




 --19.

	GO
	CREATE TRIGGER TR_Delete_Product_Relations ON Products
	INSTEAD OF DELETE
	AS
	BEGIN
		DECLARE @ProductId INT = (select Id FROM deleted);
	
		ALTER TABLE Feedbacks
		DROP CONSTRAINT FK_Feedbacks_Products;

		DELETE FROM Feedbacks 
		WHERE ProductId = @ProductId;

		DELETE FROM ProductsIngredients
		WHERE ProductId = @ProductId;

		DELETE FROM Products 
		WHERE Id = @ProductId;
	END
	GO


select * from Products

begin tran
Delete From Products
where Id = 7
rollback;

/*FK__Feedbacks__Produ__2E1BDC42  table Feedbacks*/


/*FK__ProductsI__Produ__398D8EEE  table ProductsIngredients */





--20.

	SELECT 
		     Table1.ProductName,
			 Table1.ProductAverageRate,
			 Table1.DistributorName

		FROM 
	 (SELECT p.Id AS ProductId, 
			 p.Name AS ProductName,  
			 AVG(f.Rate) AS ProductAverageRate, 
			 d.Name AS DistributorName,
			 c.Name AS DistributorCountry
		FROM Feedbacks AS f
		JOIN Products AS p ON p.Id = f.ProductId
		JOIN ProductsIngredients AS [pi] ON [pi].ProductId = p.Id
		JOIN Ingredients AS i ON i.Id = [pi].IngredientId
		JOIN Distributors AS d ON d.Id = i.DistributorId
		JOIN Countries AS c ON c.Id = d.CountryId
		GROUP BY p.Name, d.Name, c.Name, p.Id
		) AS Table1
		GROUP BY Table1.ProductId, 
			     Table1.ProductName, 
				 Table1.ProductAverageRate,
				 Table1.DistributorName				 
		HAVING COUNT(Table1.DistributorName) = 1
		ORDER BY Table1.ProductId






		WITH CTE AS 
	  
	  (SELECT  
			  p.Id AS ProductId,
			  p.Name AS ProductName,
			  AVG(f.Rate) AS ProductAverageRate,
			  d.Name AS DistributorName,
			  c.Name AS DistributorCountry
		 FROM Products AS p
		 JOIN Feedbacks AS f ON f.ProductId = p.Id
		 JOIN ProductsIngredients AS [ip] ON [ip].ProductId = p.Id
		 JOIN Ingredients AS i ON i.Id = [ip].IngredientId
		 JOIN Distributors AS d ON d.Id = i.DistributorId
		 JOIN Countries AS c ON c.Id = d.CountryId
		 GROUP BY d.Name, p.Name, c.Name, p.Id) 		
		 
	SELECT CTE.ProductName, CTE.ProductAverageRate, CTE.DistributorName, CTE.DistributorCountry FROM CTE
	JOIN
		 (SELECT 
				CTE.ProductName,
				COUNT(DistributorCountry) AS DistributorCount
		 FROM CTE
		 GROUP BY CTE.ProductName) AS DistributorCount
		 ON DistributorCount.ProductName = CTE.ProductName
		 WHERE DistributorCount = 1
		 ORDER BY CTE.ProductId


