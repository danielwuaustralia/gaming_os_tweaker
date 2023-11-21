:: (Option1) Use big pagefile(swap) to improve microstuttering
powershell -c "$computerSys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges; $computerSys.AutomaticManagedPagefile = $False; $computerSys.Put()"
powershell -c "$pagefile = Get-WmiObject Win32_PagefileSetting; $pagefile.InitialSize = 32768; $pagefile.MaximumSize = 32768; $pagefile.Put()"

:: (Option2) Disable and remove pagefile - 16GB+ RAM, this is probably the choice. But one should test too, if any problem appears, enable it back.
powershell -c "$computerSys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges; $computerSys.AutomaticManagedPagefile = $False; $computerSys.Put()"
powershell -c "$pagefile = Get-WmiObject Win32_PagefileSetting; $pagefile.InitialSize = 0; $pagefile.MaximumSize = 0; $pagefile.Put()"
powershell -c "$pagefile = Get-WmiObject Win32_PagefileSetting; $pagefile.delete()"

:: Tweak Memory Management Agent - Requires SysMain service to be enabled. By default it's disabled.
powershell Disable-MMAgent -MemoryCompression
powershell Disable-MMAgent -PageCombining
powershell Enable-MMAgent -ApplicationPreLaunch
powershell Enable-MMAgent -ApplicationLaunchPrefetching
powershell Enable-MMAgent -OperationAPI
powershell Set-MMAgent -MaxOperationAPIFiles 1024

:: =================================================================================================================================

:: Disallow drivers to get paged into virtual memory.
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager" /v DisablePagingExecutive /t REG_DWORD /d 1 /f

:: Use big system memory caching to improve microstuttering.
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f

:: Disable fetch feature that may cause higher disk usage.
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableBoottrace /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v SfTracingState /t REG_DWORD /d 0 /f

:: Disable FTH (Fault Tolerant Heap)
REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\FTH\State" /f

:: Disable PageCombining
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePageCombining /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingCombining /t REG_DWORD /d 1 /f

:: Disable IOPageLock
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v IoPageLockLimit /t REG_DWORD /d 0xffffffff /f

:: Free Unused RAM - need testing
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v HeapDeCommitFreeBlockThreshold /t REG_DWORD /d 40000 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v CacheUnmapBehindLengthInMB /t REG_DWORD /d 100 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v ModifiedWriteMaximum /t REG_DWORD /d 20 /f

:: More mem tweaks
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v SystemPages /t REG_DWORD /d 0xffffffff /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v NonPagedPoolQuota /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v NonPagedPoolSize /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v PagedPoolQuota /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v PagedPoolSize /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v SecondLevelDataCache /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v PhysicalAddressExtension /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v SimulateCommitSavings /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v TrackLockedPages /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management" /v TrackPtes /t REG_DWORD /d 0 /f

REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v AlpcWakePolicy /t REG_DWORD /d 1 /f

:: Disable NVME perf throttle
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Classpnp" /v NVMeDisablePerfThrottling /t REG_DWORD /d 1 /f
