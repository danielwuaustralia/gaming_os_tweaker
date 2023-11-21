%~dp0\..\tools\DeviceCleanupCmd -s *

:: Another way that may force remove devices even those that might be connected, yet are with a unknown status.
:: Get-PnpDevice | Where Status -eq Unknown | ForEach { &pnputil /remove-device $_.InstanceId }