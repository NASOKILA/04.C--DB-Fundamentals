
	Select FirstName, LastName, JobTitle
	From Employees
	
	CREATE NONCLUSTERED INDEX					
	IX_Employees_FirstName_LastNme_JobTitle		
	ON Employees(FirstName,LastName)			
	include(JobTitle)
