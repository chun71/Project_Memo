--declare @EMPID VARCHAR(6) ='900385'
declare @EMPID VARCHAR(6) ='900714'
DECLARE @TSQL varchar(8000)

SELECT  @TSQL = 
'SELECT EMPID, IDATE, week, content
FROM OPENQUERY(CTS, ''
SELECT EMPID, TO_CHAR(TO_DATE(IDATE,''''YYYYMMDD''''),''''YYYY/MM/DD'''') IDATE, ''''(''''||DECODE(TO_CHAR(TO_DATE(IDATE,''''YYYYMMDD''''),''''D''''),''''1'''',''''��'''',''''2'''',''''�@'''',''''3'''',''''�G'''',''''4'''',''''�T'''',''''5'''',''''�|'''',''''6'''',''''��'''',''''7'''',''''��'''',''''?'''')||'''') '''' WEEK, LISTAGG(SUBSTR(ITIME, 1, 2) || '''':'''' || SUBSTR(ITIME, 3, 2)||'''' (''''||DECODE(ITYPE, ''''A'''', ''''�i'''', ''''D'''', ''''�X'''', ''''E'''', ''''�[�Z�i'''' , ''''F'''', ''''�[�Z�X'''' , ''''��L'''')||'''')'''','''' '''') WITHIN GROUP (ORDER BY ITIME) CONTENT
FROM ACPI38M
WHERE EMPID='''''+@EMPID+'''''
AND IDATE >= TO_CHAR(SYSDATE-24, ''''YYYYMMDD'''') and IDATE !=''''2671208''''
GROUP BY EMPID, IDATE
'') AS ASSETQUERY
ORDER BY IDATE DESC'
Print (@TSQL);

EXEC (@TSQL)