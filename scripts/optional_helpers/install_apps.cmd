
:: (IMPORTANT)
:: Know that :: are considered a comment, so the command wont run if that on the left side of it, unless you get the command by itself and run, or remove it from before the command, then you can run the file.
:: But only do so for commands, and not the explaining text, otherwise that will break the script.

:: Might need a restart after first run, and run again after.

:: ----------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------

:: Install Winget through this or use https://github.com/microsoft/winget-cli/releases with .msixbundle file
powershell "If(-not(Get-InstalledModule WingetTools -ErrorAction silentlycontinue)){ Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.201' -Force -Scope AllUsers; Install-Module WingetTools -Confirm:$False -Force }"

:: You can update them all by running
:: winget upgrade --all

:: You can find apps by using
:: winget search whatyouwant

:: https://winget.run/
:: https://winstall.app/

:: You can make it run automatically in every windows startup by running this command once
:: powershell -c "$action = New-ScheduledTaskAction -Execute \"powershell\" -Argument \"-WindowStyle hidden -Command winget upgrade --all\"; $trigger = New-ScheduledTaskTrigger -AtLogOn; $principal = New-ScheduledTaskPrincipal -UserID "LOCALSERVICE" -RunLevel Highest; Register-ScheduledTask -TaskName \"AutoUpdateWingetApps\" -Action $action -Trigger $trigger -Principal $principal;"

:: ----------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------

:: Alternative option, Chocolatey.
powershell -c "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

:: Upgrade all
:: choco upgrade all -y

:: https://community.chocolatey.org/packages

:: ----------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------

:: You can install Windows Store apps by using their id
:: https://apps.microsoft.com/store/detail/netflix/9WZDNCRFJ3TJ
:: winget install -e --id 9WZDNCRFJ3TJ

:: You can turn microsoft store links into directly urls
:: https://store.rg-adguard.net/

:: Send feedback / bug report to Microsoft with Feedback Hub
:: winget install -e --id 9NBLGGH4R32N --accept-source-agreements --accept-package-agreements

winget install -e --id Microsoft.VCRedist.2015+.x64 --accept-source-agreements --accept-package-agreements
winget install -e --id Microsoft.VCRedist.2015+.x86 --accept-source-agreements --accept-package-agreements

winget install -e --id Microsoft.DirectX --accept-source-agreements --accept-package-agreements

:: Replace native Windows Menu
:: winget install -e --id Open-Shell.Open-Shell-Menu

:: Replace every other browser
winget install -e --id Brave.Brave --accept-package-agreements

winget install -e --id 7zip.7zip
:: winget install -e --id M2Team.NanaZip

:: Replace Notepad
:: winget install -e --id Notepad++.Notepad++
winget install -e --id VSCodium.VSCodium
:: winget install -e --id Microsoft.VisualStudioCode

:: Replace Paint
:: winget install -e --id dotPDNLLC.paintdotnet

:: Replace Calculator, or if you want it back.
:: winget install -e --id Qalculate.Qalculate
:: winget install Calculator --accept-package-agreements

:: Screenshot and more
:: winget install -e --id Flameshot.Flameshot :: Simpler, less bloated in internal and external config
:: winget install -e --id ShareX.ShareX

:: Voice + Chat
winget install -e --id Discord.Discord

:: Replace any other Media Player
winget install -e --id clsid2.mpc-hc
winget install -e --id Nevcairiel.LAVFilters
winget install -e --id VideoLAN.VLC

:: Torrent
winget install -e --id qBittorrent.qBittorrent

:: Gaming
:: winget install -e --id Valve.Steam
:: winget install -e --id EpicGames.EpicGamesLauncher
:: choco install ubisoft-connect -y
:: choco install ea-app -y
:: winget install -e --id OBSProject.OBSStudio

:: Test DPC and interrupt latency
winget install -e --id Resplendence.LatencyMon

:: New Powershell
:: winget install -e --id Microsoft.PowerShell

:: Install Terminal
winget install -e --id Microsoft.WindowsTerminal

:: Video transcoder / encoder
:: winget install -e --id HandBrake.HandBrake
:: winget install -e --id Microsoft.DotNet.DesktopRuntime.6

:: Replace File Explorer
:: choco install files -y

:: Test to find WHEA errors
:: choco install occt -y

:: Audio Player
:: choco install foobar2000 -y

:: One of the best tunneling tools to lower ping/use better routes for MMORPGs
:: https://www.exitlag.com/

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Security :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: DO NOT download executables you dont know to be safe or decently safe. Check them before. You can use https://www.virustotal.com/ if online. Or scan with an good antimalware. You can also isolate it from your enviromnent by using a Sandbox environment like Sandboxie.

:: https://www.privacytools.io/
:: https://www.kaspersky.com.br/downloads/free-virus-removal-tool
:: https://www.kaspersky.com/anti-ransomware-tool
:: https://www.malwarebytes.com/adwcleaner

:: Replace Windows Firewall - I recommend at least simplewall as alternative, you have much more control and better visibility than Windows option, and more security.
choco install simplewall -y
:: winget install -e --id Safing.Portmaster
:: winget install -e --id GlassWire.GlassWire
:: winget install -e --id BiniSoft.WindowsFirewallControl

:: Protection against many types of malware and more
:: winget install -e --id Bitdefender.Bitdefender
:: winget install -e --id Malwarebytes.Malwarebytes
:: choco install avirafreeantivirus
:: choco install avastfreeantivirus

:: Sandbox environment
:: winget install -e --id Sandboxie.Plus

:: Browser Extensions
:: https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
:: https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp
:: https://chrome.google.com/webstore/detail/decentraleyes/ldpochfccmkkmhdbclfhpagapcfdljkj
