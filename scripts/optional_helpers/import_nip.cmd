:: Import Nvidia Profile Inspector config
:: This nip has been greatly optimized to reduce input lag as much as possible, some machines may not get the desired result with it.
:: As I read that some config that I use there has caused jitter/stutter in other machines. Even though here I have no issue, but very good responsiveness.
taskkill /f /im "nvcplui.exe" >nul 2>&1

pushd "%~dp0"
pushd ..\
"tools\nvidiaProfileInspector\nvidiaProfileInspector.exe" "configs\apps\low_latency.nip" -silentImport
