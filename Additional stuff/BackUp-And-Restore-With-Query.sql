



--Backup na baza Hotel2 s query:
BACKUP DATABASE Hotel2
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\Hotel2.bak';

--Iztrivame q 
drop database Hotel2;

--I nakraq q restorvame s query:
RESTORE DATABASE Hotel2
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\Hotel2.bak';



