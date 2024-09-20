--declare @EMPID VARCHAR(6) ='900385'
declare @EMPID VARCHAR(6) ='900714'
DECLARE @TSQL varchar(8000)

SELECT  @TSQL = 
'SELECT EMPID, IDATE, week, content
FROM OPENQUERY(CTS, ''
SELECT EMPID, TO_CHAR(TO_DATE(IDATE,''''YYYYMMDD''''),''''YYYY/MM/DD'''') IDATE, ''''(''''||DECODE(TO_CHAR(TO_DATE(IDATE,''''YYYYMMDD''''),''''D''''),''''1'''',''''日'''',''''2'''',''''一'''',''''3'''',''''二'''',''''4'''',''''三'''',''''5'''',''''四'''',''''6'''',''''五'''',''''7'''',''''六'''',''''?'''')||'''') '''' WEEK, LISTAGG(SUBSTR(ITIME, 1, 2) || '''':'''' || SUBSTR(ITIME, 3, 2)||'''' (''''||DECODE(ITYPE, ''''A'''', ''''進'''', ''''D'''', ''''出'''', ''''E'''', ''''加班進'''' , ''''F'''', ''''加班出'''' , ''''其他'''')||'''')'''','''' '''') WITHIN GROUP (ORDER BY ITIME) CONTENT
FROM ACPI38M
WHERE EMPID='''''+@EMPID+'''''
AND IDATE >= TO_CHAR(SYSDATE-24, ''''YYYYMMDD'''') and IDATE !=''''2671208''''
GROUP BY EMPID, IDATE
'') AS ASSETQUERY
ORDER BY IDATE DESC'
Print (@TSQL);

EXEC (@TSQL)