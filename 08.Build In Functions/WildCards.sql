
SELECT 
EmployeeID,
FirstName,
LastName
FROM Employees
WHERE FirstName LIKE('%to') 

SELECT 
EmployeeID,
FirstName,
LastName
FROM Employees
WHERE FirstName LIKE('Te[tn]%')
