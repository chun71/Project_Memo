--�d�߹w�s�{��or�˵����S�w��r
SELECT DISTINCT o.name, c.* FROM syscomments c
	INNER JOIN sysobjects o ON c.id=o.id
	WHERE (o.xtype = 'P'           --�dSP
	OR o.xtype = 'V')              --�dView
	And (o.name LIKE '%�S�w��r%'  --�dSP��View�W��
	OR c.text LIKE '%�S�w��r%')   --�dSP��View���t��r