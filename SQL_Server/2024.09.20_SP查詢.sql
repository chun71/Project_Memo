--查詢預存程序or檢視中特定文字
SELECT DISTINCT o.name, c.* FROM syscomments c
	INNER JOIN sysobjects o ON c.id=o.id
	WHERE (o.xtype = 'P'           --查SP
	OR o.xtype = 'V')              --查View
	And (o.name LIKE '%特定文字%'  --查SP或View名稱
	OR c.text LIKE '%特定文字%')   --查SP或View內含文字