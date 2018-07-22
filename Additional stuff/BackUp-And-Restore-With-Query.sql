
BACKUP DATABASE Hotel2
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\Hotel2.bak';

drop database Hotel2;

RESTORE DATABASE Hotel2
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2\MSSQL\Backup\Hotel2.bak';
