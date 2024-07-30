
ALTER TABLE [PLAP].[dbo].[Account] ADD [OldPassword1] VARCHAR(40) NOT NULL DEFAULT '';
ALTER TABLE [PLAP].[dbo].[Account] ADD [OldPassword2] VARCHAR(40) NOT NULL DEFAULT '';

ALTER TABLE [TIIReportDB].[dbo].[account] ADD [password1] VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE [TIIReportDB].[dbo].[account] ADD [password2] VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE [TIIReportDB].[dbo].[account] ADD [password3] VARCHAR(50) NOT NULL DEFAULT '';