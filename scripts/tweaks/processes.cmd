:: (Optionally) you can run interrupt affinity auto script through here
:: powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\..\optional_helpers\interrupt_affinity_auto.ps1"

:: Optimize priorties to processes
:: (CpuPriorityClass) 1 = Low, 2 = Normal, 3 = High, 4 = RealTime, 5 = Below Normal, 6 = Above Normal
:: (IoPriority) 0 = Very Low, 1 = Low, 2 = Normal, 3 = High, 4 = Critical

:: Win processes
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 4 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wininit.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 4 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 1 /f

:: Apps
:: If steam or any other client are using it's own processes that has been set to lower priority as guidelines for their games, you can change yourself or open an issue at this repository.
:: Legends are on the top. An alternative would be to use Process Lasso, where you can set a persisted priority to each game.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Battle.net.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Agent.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Steam.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EpicGamesLauncher.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EADesktop.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QtWebEngineProcess.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QtWebEngineProcess.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamservice.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EABackgroundService.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EABackgroundService.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f

:: Games
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Overwatch.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 3 /f

:: Large Pages (It reduces a little overhead in the RAM management routines (uses less RAM) and reduces PageFaults by a lot)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Intelligent standby list cleaner ISLC.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Overwatch.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\starwarsbattlefrontii.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\bfv.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ModernWarfare.exe" /v UseLargePages /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BF2042.exe" /v UseLargePages /t REG_DWORD /d 1 /f

:: Pre setup settings to some games
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Overwatch\_retail_\Overwatch.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM DISABLEDXMAXIMIZEDWINDOWEDMODE" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Steam\steamapps\common\Overwatch\Overwatch.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM DISABLEDXMAXIMIZEDWINDOWEDMODE" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Origin Games\STAR WARS Battlefront II\starwarsbattlefrontii.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Origin Games\Battlefield V\bfv.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Call of Duty Modern Warfare\ModernWarfare.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%programfiles(x86)%\Steam\steamapps\common\Battlefield 2042\BF2042.exe" /t REG_SZ /d "~ HIGHDPIAWARE DISABLEDWM" /f

:: Specific exe GPU Setting
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "%programfiles(x86)%\Steam\steamapps\common\Overwatch\Overwatch.exe" /t REG_SZ /d "GpuPreference=2;VRROptimizeEnable=0;AutoHDREnable=0;SwapEffectUpgradeEnable=1;" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "%programfiles(x86)%\Overwatch\_retail_\Overwatch.exe" /t REG_SZ /d "GpuPreference=2;VRROptimizeEnable=0;AutoHDREnable=0;SwapEffectUpgradeEnable=1;" /f

:: Set system processes that use cycles to low priority
for %%i in (fontdrvhost lsass svchost spoolsv sppsvc WmiPrvSE) do (
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%i.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul 2>&1
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%i.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f >nul 2>&1
)

:: ====================================================================================================================================

:: Optimize priorities
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ0Priority /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ8Priority /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v ConvertibleSlateMode /t REG_DWORD /d 0 /f
:: Another value said to have good results were 2A value 42 (Short, Fixed , High foreground boost) - https://docs.google.com/spreadsheets/d/1ZWQFycOWdODkUOuYZCxm5lTp08V2m7gjZQSCjywAsl8/edit#gid=762933934
:: But since high foreground, means is prioritizing more the foreground app, it might take from other parts that could be relevant, like input, etc.. I could be wrong.
:: https://docs.google.com/document/d/1ILugrwtHfmisYzI1MdCOhSzBPuLJPi5D7xYJgQ4sxDM/edit#heading=h.emf7opqgiwv8 - Accordingly to this, 0x24 has the lowest latency in both foreground and background.
:: 0x24 or 0x2A
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 0x24 /f

:: Threads Priority in services
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v ThreadPriority /t REG_DWORD /d 31 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v ThreadPriority /t REG_DWORD /d 15 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters" /v ThreadPriority /t REG_DWORD /d 15 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v ThreadPriority /t REG_DWORD /d 15 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v ThreadPriority /t REG_DWORD /d 15 /f

:: Optimize CPU resources and priorities
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v IdleDetectionCycles /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v LazyModeTimeout /t REG_DWORD /d 10000 /f

:: Change split threshold for svchost.exe
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /value') do set /a mem=%%i + 1024000
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d %mem% /f

:: Disable unnecessary autologgers
for %%a in (
    "Circular Kernel Context Logger"
    "CloudExperienceHostOobe"
    "DefenderApiLogger"
    "DefenderAuditLogger"
    "Diagtrack-Listener"
    "LwtNetLog"
    "Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace"
    "NetCore"
    "NtfsLog"
    "RadioMgr"
    "RdrLog"
    "ReadyBoot"
    "SpoolerLogger"
    "UBPM"
    "WiFiSession"
) do (
    REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\%%~a" /v Start /t REG_DWORD /d 0 /f
)

:: Fix Task Manager not responding when exit
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v Start /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v Start /t REG_DWORD /d 1 /f

:: Kernel tweaks
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogProfileOffset /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MaximumSharedReadyQueueSize /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableAutoBoost /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v IdealDpcRate /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MaximumDpcQueueDepth /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MinimumDpcRate /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ThreadDpcEnable /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v AdjustDpcThreshold /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogPeriod /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v SplitLargeCaches /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DistributeTimers /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v InterruptSteeringDisabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v UnlimitDpcQueue /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcQueueDepth /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MaxDynamicTickDuration /t REG_DWORD /d 0xa /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v MaximumDpcRate /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ForceIdleGracePeriod /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableBufferedIoInit /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v XMMIZeroingEnable /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v WatchdogResumeTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v IdleScanInterval /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v IdleDurationExpirationTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DelayCloseSize /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DelayDerefKCBLimit /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v WorkerFactoryThreadIdleTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v PassiveWatchdogTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableLowQosTimerResolution /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcCumulativeSoftTimeout /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DpcWatchdogProfileBufferSizeBytes /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ForceForegroundBoostDecay /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v EnablePerCpuClockTickScheduling /t REG_DWORD /d 0 /f

:: Disable unnecessary device - Viewable on Device Manager
:: NDIS Virtual, Motherboard resources and some WAN Miniport are related to VPN
:: Storage Spaces may be used if you have mirrored disks
powershell -c "$devices = @('ACPI Processor Aggregator','Microsoft Windows Management Interface for ACPI','AMD PSP','AMD SMBus','Base System Device','*Bluetooth*','Composite Bus Enumerator','High precision event timer','Intel Management Engine','Intel SMBus','*Hyper-V*','Microsoft Kernel Debug Network Adapter','Microsoft RRAS Root Enumerator', 'NDIS Virtual Network Adapter Enumerator', '*WAN Miniport*', 'Motherboard resources','Numeric Data Processor','PCI Data Acquisition and Signal Processing Controller','PCI Encryption/Decryption Controller','PCI Memory Controller','PCI Simple Communications Controller','SM Bus Controller','System CMOS/real time clock','System Speaker','System Timer','UMBus Root Bus Enumerator','Remote Desktop Device Redirector Bus','Microsoft GS Wavetable Synth','AURA LED Controller', 'Microsoft Virtual Drive Enumerator', 'Microsoft iSCSI Initiator', 'SMBus', 'UMBus', 'Terminal Server Mouse Driver', 'Terminal Server Keyboard Driver', 'Microsoft Usbccid Smartcard Reader (WUDF)', 'Steelseries GG Component', 'Microsoft Storage Spaces Controller', 'AMD GPIO Controller', 'Sonar APO', 'FiiO DFU', 'Microsoft UEFI-Compliant System', 'Steelseries Sonar Virtual Audio Device'); Get-PnpDevice -FriendlyName $devices -ErrorAction Ignore | Disable-PnpDevice -Confirm:$false -ErrorAction Ignore;"

:: Additional threads can help perf in some scenarios - https://learn.microsoft.com/en-us/previous-versions/tn-archive/bb463205(v=technet.10)#additionaldelayedworkerthreads
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v AdditionalCriticalWorkerThreads /t REG_DWORD /d "%NUMBER_OF_PROCESSORS%" /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v AdditionalDelayedWorkerThreads /t REG_DWORD /d "%NUMBER_OF_PROCESSORS%" /f

:: Tweak I/O worker
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v PassiveIntRealTimeWorkerPriority /t REG_DWORD /d 18 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v CountOperations /t REG_DWORD /d 0 /f

:: Enable threaded dpc on sr-iov
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mlx4_bus\Parameters" /v ThreadDpcEnable /t REG_DWORD /d 1 /f
