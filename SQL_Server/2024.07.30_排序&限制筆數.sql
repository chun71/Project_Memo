
SElECT [companyID],[company_name],[fax]
FROM [TIIReportDB].[dbo].[company]
ORDER BY [companyID]
OFFSET 60 ROWS FETCH NEXT 10 ROWS ONLY;