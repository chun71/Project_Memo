
net stop "SQL Server (MSSQLSERVER)"
timeout /t 10

net start "SQL Server (MSSQLSERVER)"
pause