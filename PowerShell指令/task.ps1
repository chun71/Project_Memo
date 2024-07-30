
# 排程目錄
$taskPath = "CallerSystem"
# 排程工作目錄
$workingDirectory = "D:\CallerSystem\Sys\"
# 帳號
$user = "HCH\BIHSOPD"
# 密碼
$password = '1qaz@WSX3edc'



# 設定 關閉電源選項、停用超過N天執行要停用
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit "00:00:00"



# 排程名稱 同時也是執行目錄位置
$taskName = "emqx"
# 排程執行檔
$executeName = "D:\CallerSystem\emqx\bin\emqx.cmd"

# 觸發時機
$trigger = New-ScheduledTaskTrigger -AtStartup

# 動作
$action = New-ScheduledTaskAction -Execute $executeName -Argument 'start'

# 建立註冊排程
Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings

# 停用排程
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



# 排程名稱 同時也是執行目錄位置
$taskName = "02_MqttService服務(MqttService)"
# 排程執行檔
$executeName = "Bossinfo.Caller.MqttService.exe"

# 觸發時機
$trigger = New-ScheduledTaskTrigger -AtStartup

# 動作
$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

# 建立註冊排程
Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings

# 停用排程
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "04_門診資料同步排程(SyncShiftPatient_Clinic)"
$executeName = "Bossinfo.Caller.Schedule.SyncShiftPatient.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "04_核醫資料同步排程(SyncShiftPatient_NuclearMedicine)"
$executeName = "Bossinfo.Caller.Schedule.SyncShiftPatient.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "04_影醫資料同步排程(SyncShiftPatient_Radiology)"
$executeName = "Bossinfo.Caller.Schedule.SyncShiftPatient.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "04_檢查科資料同步排程(SyncShiftPatient_ExaminationRoom)"
$executeName = "Bossinfo.Caller.Schedule.SyncShiftPatient.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "05_檢查報告排程(CheckPatientStatus)"
$executeName = "Bossinfo.Caller.Schedule.CheckPatientStatus.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "06_資料庫備份(CallerDbShfitBackup)"
$executeName = "Bossinfo.Caller.Schedule.CallerDbShfitBackup.exe"

$trigger = New-ScheduledTaskTrigger -Daily -At 3am

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "07_客戶端設備連線檢查(CheckClientDeviceConnection)"
$executeName = "Bossinfo.Caller.Schedule.CheckClientDeviceConnection.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "08_清除號碼排列舊資料排程(ClearOldNumberSequence)"
$executeName = "Bossinfo.Caller.Schedule.ClearOldNumberSequence.exe"

$trigger = @(
    $(New-ScheduledTaskTrigger -Daily -At 02:00:00),
    $(New-ScheduledTaskTrigger -Daily -At 02:15:00),
    $(New-ScheduledTaskTrigger -Daily -At 02:30:00),
    $(New-ScheduledTaskTrigger -Daily -At 02:45:00)
)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "09_設備開關排程(DeviceSwitchTask)"
$executeName = "Bossinfo.Caller.Schedule.DeviceSwitchTask.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "10_藥局等待人數排程(PharmacyUpdateWaitCount)"
$executeName = "Bossinfo.Caller.Schedule.PharmacyUpdateWaitCount.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "11_排程檢查器(TaskCheck)"
$executeName = "Bossinfo.Caller.Schedule.TaskCheck.exe"

$trigger = New-ScheduledTaskTrigger -AtStartup

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath



$taskName = "15_生醫恢復手術室公播排程(CheckPatSurgicalCondition)"
$executeName = "Bossinfo.Caller.Schedule.CheckPatSurgicalCondition.exe"

$trigger = New-ScheduledTaskTrigger -Once -At 12am -RepetitionInterval (New-TimeSpan -Minutes 1)

$action = New-ScheduledTaskAction -Execute $executeName -WorkingDirectory $workingDirectory$taskName

Register-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Trigger $trigger -Action $action -User $user -Password $password -RunLevel Highest -Settings $settings
Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath


