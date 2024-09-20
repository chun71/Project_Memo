--select * from sys.all_objects
--WHERE [name] like 'SXR%'
--order by modify_date,[name]

SELECT 
ROW_NUMBER() OVER(PARTITION BY a.TABLE_NAME ORDER BY a.TABLE_NAME, b.ordinal_position ) as '序號',
a.TABLE_NAME as '表格名稱',
(
        SELECT
            value
        FROM
            fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', 
                                     a.TABLE_NAME, 'column', default)
        WHERE
            name='MS_Description' 
            and objtype='COLUMN' 
            and objname Collate Chinese_Taiwan_Stroke_CI_AS=b.COLUMN_NAME
    ) as '欄位備註',
    b.COLUMN_NAME               as '欄位名稱',
    b.DATA_TYPE                 as '資料型別',
	CASE 
		WHEN b.CHARACTER_MAXIMUM_LENGTH = -1 then 'MAX' 
		WHEN b.CHARACTER_MAXIMUM_LENGTH is null then '' 
		ELSE CAST( b.CHARACTER_MAXIMUM_LENGTH AS varchar) END as '最大長度',
    CASE 
		WHEN P.COLUMN_NAME is not null THEN 'P' ELSE '' END as 'Key',
    CASE
		WHEN b.IS_NULLABLE = 'YES' THEN 'Y'
		ELSE ''
	END	as '允許空值',
	b.COLUMN_DEFAULT            as '預設值'
    
FROM    INFORMATION_SCHEMA.TABLES  a 
LEFT JOIN INFORMATION_SCHEMA.COLUMNS b ON (a.TABLE_NAME=b.TABLE_NAME)
LEFT JOIN (
	SELECT  K.TABLE_NAME ,
    K.COLUMN_NAME
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C 
	JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS K ON C.CONSTRAINT_NAME = K.CONSTRAINT_NAME 
	AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
	WHERE  C.TABLE_NAME like 'SXR%' AND C.CONSTRAINT_TYPE = 'PRIMARY KEY '
) AS P on b.TABLE_NAME = P.TABLE_NAME AND b.COLUMN_NAME = P.COLUMN_NAME
WHERE
    TABLE_TYPE='BASE TABLE' AND a.TABLE_NAME like 'SXR%'
ORDER BY
    a.TABLE_NAME, b.ordinal_position