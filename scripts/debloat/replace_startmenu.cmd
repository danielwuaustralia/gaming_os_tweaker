:: Make sure before you run this, to install Winget + OpenShell (or just OpenShell). Check /optional_helpers/install_apps.cmd

:: If you remove OpenShell while having it run the script, the start menu and taskbar might break (not be there), install it again.
:: One of the options is running the Task Manager (Run new task) and browse and find the executable to install or repair. Restart after.

:: DPC count were reduced by a lot after using OpenShell + disabling these features/executables.

:: -------------------------------------------------------------

cd %windir%\SystemApps

taskkill /f /im SearchApp.exe
move Microsoft.Windows.Search_cw5n1h2txyewy Microsoft.Windows.Search_cw5n1h2txyewy.old

taskkill /f /im StartMenuExperienceHost.exe
move Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy.old

taskkill /f /im TextInputHost.exe
taskkill /f /im SearchHost.exe
move MicrosoftWindows.Client.CBS_cw5n1h2txyewy MicrosoftWindows.Client.CBS_cw5n1h2txyewy.old

taskkill /f /im backgroundTaskHost.exe
taskkill /f /im ctfmon.exe
taskkill /f /im SearchUI.exe
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\System32\backgroundTaskHost.exe %windir%\System32\backgroundTaskHost.exe.old"
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\System32\ctfmon.exe %windir%\System32\ctfmon.exe.old"
move Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe.old

taskkill /f /im RuntimeBroker.exe
taskkill /f /im ShellExperienceHost.exe
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\System32\RuntimeBroker.exe %windir%\System32\RuntimeBroker.exe.old"
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe %windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.old"

taskkill /f /im DataExchangeHost.exe
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\System32\DataExchangeHost.exe %windir%\System32\DataExchangeHost.exe.old"

taskkill /f /im mobsync.exe
call %~dp0\..\optional_helpers\run_minsudo "move %windir%\System32\mobsync.exe %windir%\System32\mobsync.exe.old"

:: Additionals
move Microsoft.XboxGameCallableUI_cw5n1h2txyewy Microsoft.XboxGameCallableUI_cw5n1h2txyewy.old
move Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe.old
move Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy.old
move microsoft.windows.narratorquickstart_8wekyb3d8bbwe microsoft.windows.narratorquickstart_8wekyb3d8bbwe.old