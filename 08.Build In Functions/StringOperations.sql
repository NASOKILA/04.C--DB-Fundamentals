
SELECT 
CustomerID, 
FirstName, 
LastName, 
LEFT(PaymentNumber, 6) + REPLICATE('*', LEN(PaymentNumber) - 6)
AS PaymentNumber
FROM Customers;


SELECT 
Name,
Quantity,
UPPER(BoxCapacity),
PalletCapacity
FROM Products


SELECT TOP(1) REVERSE(Name) FROM Products


SELECT TOP(5) 
STUFF(Name, 1, 0, 'Naso '),  
Quantity, 
BoxCapacity
FROM Products


SELECT LEFT('Pesho'+ '**********', 10);

SELECT RIGHT('0000000' + '123', 10);

SELECT RIGHT('0000000' + CAST(123 AS varchar), 10);

SELECT FORMAT(22, 'd10');


SELECT Id
      ,Name
      ,Quantity
  FROM Products
  WHERE LEFT(Name, 2) = 'Pe'
