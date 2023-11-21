:: Go to this url https://privacy.sexy/ > Privacy Over Security > Disable Windows Defender (only), Uncheck Windows Firewall in case you are going to use that.
:: Now download the file, rename to (disable_windows_defender)
:: Put in this same folder as this file, and run this file (remove_windows_defender)
:: Wait, once is finish, do a reboot and done

:: PS: On recent Win11 versions, you might need to manually disable Tamper Protection through the UI, before running the script.

:: You might need to be in safemode, check /optional_helpers/safeboot_toggle.cmd
:: If you go to safemode, run this script and services.cmd from this same folder. Both are required to completely disable/remove windows defender.

:: Soon, privacy.sexy could have predictable url for each script, so that could be automated into a script to download the latest version automatically and run it, and delete afterwards.

call %~dp0\..\optional_helpers\run_minsudo "start "" ..\debloat\disable_windows_defender.cmd"

exit