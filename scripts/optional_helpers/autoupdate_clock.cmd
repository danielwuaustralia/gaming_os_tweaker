:: Useful if you have a machine with dual boot Windows + Linux, and the clock gets messed up, regardless if you set local time. Or in case it's broken and not keeping up the correct time after disabling the service.
powershell -c "$action = New-ScheduledTaskAction -Execute \"powershell\" -Argument \"-WindowStyle hidden -Command while (!(Test-Connection 1.1.1.1 -Count 1 -Quiet)) { Start-Sleep -Seconds 1 };net start w32time; w32tm /resync; net stop w32time;\"; $delay = New-TimeSpan -Seconds 10; $trigger = New-ScheduledTaskTrigger -AtLogOn -RandomDelay $delay; $principal = New-ScheduledTaskPrincipal -UserID \"LOCALSERVICE\" -RunLevel Highest; Register-ScheduledTask -TaskName \"AutoUpdateClock\" -Action $action -Trigger $trigger -Principal $principal;"
