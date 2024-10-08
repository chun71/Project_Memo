/****** SSMS 中 SelectTopNRows 命令的指令碼  ******/
SELECT 
     [sJOB].[name] AS '作業名稱'
    , [sCAT].[name] AS [JobCategory]
    ,CASE
	 WHEN [sJOB].[description] = '沒有可用的描述。' THEN ''
	 ELSE [sJOB].[description]
	 END AS '作業描述'
    , CASE [sJOB].[enabled]
        WHEN 1 THEN 'Yes'
        WHEN 0 THEN 'No'
      END AS '作業是否啟用'
    , [sJOB].[date_created] AS '創建時間'
    , CASE
        WHEN [sSCH].[schedule_uid] IS NULL THEN 'No'
        ELSE 'Yes'
      END AS '排程是否啟用'
    , [sSCH].[name] AS '排程名稱'
FROM
    [msdb].[dbo].[sysjobs] AS [sJOB]
    LEFT JOIN [msdb].[sys].[servers] AS [sSVR]
        ON [sJOB].[originating_server_id] = [sSVR].[server_id]
    LEFT JOIN [msdb].[dbo].[syscategories] AS [sCAT]
        ON [sJOB].[category_id] = [sCAT].[category_id]
    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sJSTP]
        ON [sJOB].[job_id] = [sJSTP].[job_id]
        AND [sJOB].[start_step_id] = [sJSTP].[step_id]
    LEFT JOIN [msdb].[sys].[database_principals] AS [sDBP]
        ON [sJOB].[owner_sid] = [sDBP].[sid]
    LEFT JOIN [msdb].[dbo].[sysjobschedules] AS [sJOBSCH]
        ON [sJOB].[job_id] = [sJOBSCH].[job_id]
    LEFT JOIN [msdb].[dbo].[sysschedules] AS [sSCH]
        ON [sJOBSCH].[schedule_id] = [sSCH].[schedule_id]
where [sCAT].[name] = '[Uncategorized (Local)]'　and [sJOB].[enabled] = '1'
order by [sJOB].[name]