
DECLARE @p VARCHAR(MAX);
SET @p = '';

SELECT 
[con_name] , 
LEN([con_name]) AS [LEN], 
DATALENGTH([con_name]) AS [DATALENGTH] 
FROM [TIIReportDB].[dbo].[company] 
WHERE [company_shortname]= @p;

SELECT 
[con_name2] , 
LEN([con_name2]) AS [LEN], 
DATALENGTH([con_name2]) AS [DATALENGTH] 
FROM [TIIReportDB].[dbo].[company] 
WHERE [company_shortname]= @p;
