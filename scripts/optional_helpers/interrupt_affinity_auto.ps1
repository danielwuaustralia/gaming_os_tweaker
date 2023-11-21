<#
  It should be very easy and straight forward to alter in the script whatever choice you would want to test, to be automatically done.
  Check $devices below in the file. All changes should be through it.

  This script are able to replace Interrupt Affinity Policy Tool and MSI Tool.
  It's based on pre-choices in attempt to reduce latency / DPC avg / input lag in every worth aspect. You can still change values to test if something else works better for you.

  Decimal/Hex values were used instead of Binary, hence why Interrupt Affinity Policy Tool will not recognize the core assigned. LatencyMon should show though.

  Script applies same core to each category, if you have 2 GPUs, it will assign same core to both. Script could evolve later, but wont be for now.
  I put the same class of devices in the same core, it could be that they are on a different parent, that could be a problem, mainly for USB devices.

  Beware: Audio USB and Keyboard might be on the same parent as Mouse, so the parent being the same, it would lose the core assigned of one to the other. Recommended to plug into a different device controller.

  Current Choices:
    - Reset all interrupt affinity related options
    - Enable MSI to everything that supports
    - See everything else below on $devices.

  In the pre-choice I optionally disabled MSI in the Mouse (parent), because in some cases it's an option to consider, but not for other devices imho. Since legacy interrupts may have a simple interrupt implementation leading to lower latency, since the MSI does not have instant processing.
  I would say for Mouse is worth considering IRQ/Legacy Interrupt vs MSI-X, but not MSI, since MSI-X is also known to have lower latency, but since it's still MSI, it might also not have instant processing, not that the legacy implementation does.
  It will be based on what works for you. MSI-X should work very well for Ethernet, even more so if you are able to get RSS Queues working, network.cmd script should be able to help with that. 

  https://electronics.stackexchange.com/a/76878 

  I suppose if there were a Polling alternative to MSI, it could be even better, as it could able to process faster than interrupts, leading to lower latency, since MSI are not instant processing, if you check the url above this.
  DevicePriority to High seems to help in lowering latency (even if minor) as it take priority in processing.
  https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/techpaper/vmw-tuning-latency-sensitive-workloads-white-paper.pdf - Mid Page 8
	
  ---------------------------

  If a device has both MSI and MSI-X, MSI-X will take precedence and hard limit is the size of the vector. Regardless of the value set, it will be capped on that limit, this is based on a documentation.
  https://docs.kernel.org/PCI/msi-howto.html#using-msi

  Even though there are cases of driver manufactors setting a higher limit, nothing is proven that they are in fact bypassing that hard limit. But still it could be a possibility as if setting the vector size, but it's not been confirmed.

  I read somewhere that setting a higher limit value than the hard limit of the device could be detrimental to the device performance, I have not confirmed, so, it's just information at this point. A possible way would be just to set the limit to the hard limit of the device and leave as that.
  This would collaborate with the argument of the a different value overwriting the default hard limit, but again, not confirmed.

  ---------------------------

  In case you get problems running the script in Win11, you can run the command to allow, and after, another to set back to a safe or undefined policy

  You can check the current policy settings
  Get-ExecutionPolicy -List

  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Confirm:$false -Force
  Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser -Confirm:$false -Force

  ---------------------------

  DevicePolicy: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ne-wdm-_irq_device_policy
  DevicePriority: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ne-wdm-_irq_priority
  GroupPolicy: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/miniport/ns-miniport-_group_affinity
  MessageNumberLimit: https://forums.guru3d.com/threads/windows-line-based-vs-message-signaled-based-interrupts-msi-tool.378044/page-26#post-5447998
  AssignmentSetOverride: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/interrupt-affinity-and-priority#about-kaffinity
  MSISupported: Enable MSI
#>

# Start as administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

function Reset-Affinity-And-MSI-Tweaks {
	Write-Host "Resetting Affinity and MSI tweaks!"
	[Environment]::NewLine

	[PsObject[]]$allPnpDeviceIds = @()
	Get-WmiObject Win32_VideoController | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }
	Get-WmiObject Win32_USBController | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }
	Get-WmiObject Win32_NetworkAdapter | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }
	Get-WmiObject Win32_IDEController | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }
	Get-WmiObject Win32_SoundDevice | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }
	Get-WmiObject Win32_DiskDrive | Where-Object PNPDeviceID -Match "PCI\\VEN*" | Select-Object -ExpandProperty PNPDeviceID | ForEach { $allPnpDeviceIds += $_ }

	foreach ($devicePath in $allPnpDeviceIds) {
		$affinityPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$devicePath\Device Parameters\Interrupt Management\Affinity Policy"
		$msiPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$devicePath\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
		Remove-ItemProperty -Path $affinityPath -Name "AssignmentSetOverride" -Force -ErrorAction Ignore
		Remove-ItemProperty -Path $affinityPath -Name "DevicePolicy" -Force -ErrorAction Ignore
		Remove-ItemProperty -Path $affinityPath -Name "DevicePriority" -Force -ErrorAction Ignore
		Set-ItemProperty -Path $msiPath -Name "MSISupported" -Value 1 -Force -Type Dword -ErrorAction Ignore
	}
}

function Is-Empty-Str {
	param ([string] $value)
	[string]::IsNullOrWhiteSpace($value)
}

function Is-Even {
	param ([int] $value)
	$value % 2 -eq 0
}

function Apply-IRQ-Priotity-Optimization {
	param ([string] $IRQValue)

	$IRQSplit = $IRQValue.Trim().Split(" ")
	foreach ($IRQ in $IRQSplit) {
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "IRQ$($IRQ)Priority" -Value 1 -Force -Type Dword -ErrorAction Ignore
	}
}

function Get-Prioritized-Devices {
	param ([PsObject[]] $devices)

	$enabledClasses = $devices | Where-Object { $_.Enabled -eq $true } | ForEach-Object { $_.Class }
	$enabledUSBClasses = $devices | Where-Object { $_.Enabled -eq $true -and $_.isUSB -eq $true } | ForEach-Object { $_.Class }

	$allDevices = Get-PnpDevice -PresentOnly -Class $enabledClasses -Status OK
	$prioritizedDevices = $allDevices | ForEach-Object {
		$device = $_
		$priorityDevice = $devices | Where-Object { $_.Class -eq $device.Class}
		return [PsObject]@{
			Class = $device.Class;
			FriendlyName = $device.FriendlyName;
			InstanceId = $device.InstanceId;
			Priority = $priorityDevice.Priority;
			Enabled = $priorityDevice.Enabled;
			isUSB = $priorityDevice.isUSB
		}
	} | Sort-Object { $_.Priority }
	return $prioritizedDevices
}

function Get-Devices-Data {
	param ([PsObject[]] $prioritizedDevices)

	[PsObject[]]$devicesData = @()
	for ($i=0; $i -lt $prioritizedDevices.Length; $i++) {
		$childDevice = $prioritizedDevices[$i]
		$childDeviceName = $childDevice.FriendlyName
		$childDeviceInstanceId = $childDevice.InstanceId
		$childPnpDevice = Get-PnpDeviceProperty -InstanceId $childDeviceInstanceId

		$childPnpDeviceLocationInfo = $childPnpDevice | Where KeyName -eq 'DEVPKEY_Device_LocationInfo' | Select -ExpandProperty Data
		$childPnpDevicePDOName = $childPnpDevice | Where KeyName -eq 'DEVPKEY_Device_PDOName' | Select -ExpandProperty Data

		$parentDeviceInstanceId = $childPnpDevice | Where KeyName -eq 'DEVPKEY_Device_Parent' | Select -ExpandProperty Data

		$parentDevice = $null
		$parentDeviceName = ""
		$parentDeviceLocationInfo = ""
		$parentDevicePDOName = ""
		do {
			$parentDevice = Get-PnpDeviceProperty -InstanceId $parentDeviceInstanceId
			if (!$parentDevice) {
				continue
			}
			$parentDeviceName = $parentDevice | Where KeyName -eq 'DEVPKEY_NAME' | Select -ExpandProperty Data
			if ([string]::IsNullOrWhiteSpace($parentDeviceName)) {
				continue
			}
			$parentDeviceLocationInfo = $parentDevice | Where KeyName -eq 'DEVPKEY_Device_LocationInfo' | Select -ExpandProperty Data
			$parentDevicePDOName = $parentDevice | Where KeyName -eq 'DEVPKEY_Device_PDOName' | Select -ExpandProperty Data
			if ($childDevice.IsUSB -and !$parentDeviceName.Contains('Controller')) {
				$parentDeviceInstanceId = $parentDevice | Where KeyName -eq 'DEVPKEY_Device_Parent' | Select -ExpandProperty Data
			}
		} while (!$parentDeviceName.Contains('Controller') -and $childDevice.IsUSB)

		if ([string]::IsNullOrWhiteSpace($parentDeviceName)) {
			continue
		}

		$parentDeviceAllocatedResource = Get-CimInstance -ClassName Win32_PNPAllocatedResource | Where-Object { $_.Dependent.DeviceID -like "*$parentDeviceInstanceId*" } | Select-Object @{N="IRQ";E={$_.Antecedent.IRQNumber}}

		$devicesData += [PsObject]@{
			ChildDeviceName = $childDeviceName;
			ChildDeviceInstanceId = $childDeviceInstanceId;
			ChildDeviceLocationInfo = $childPnpDeviceLocationInfo;
			ChildDevicePDOName = $childPnpDevicePDOName;
			ParentDeviceName = $parentDeviceName;
			ParentDeviceInstanceId = $parentDeviceInstanceId;
			ParentDeviceLocationInfo = $parentDeviceLocationInfo;
			ParentDevicePDOName = $parentDevicePDOName;
			ClassType = $childDevice.Class;
			ParentDeviceIRQ = $parentDeviceAllocatedResource.IRQ
		}
	}
	return $devicesData
}

function Min-Cores-Pre-Check {
	param ([int] $coresAmount)

	$MIN_CORES_ALLOWED = 4
	if ($coresAmount -lt $MIN_CORES_ALLOWED) {
		Write-Host "To apply Interrupt Affinity tweaks, you must have $MIN_CORES_ALLOWED or more cores"
		[Environment]::NewLine
		exit
	}
}

function Build-Cores-Mask {
	param ([int] $amount)

	[System.Collections.ArrayList]$coresMask = @()
	$tempDecimalValue = 1;
	for ($i=0; $i -lt $amount; $i++) {
		# https://poweradm.com/set-cpu-affinity-powershell/
		[void]$coresMask.Add(@{ Core = $i; Decimal = $tempDecimalValue; })
		$tempDecimalValue = $tempDecimalValue * 2
	}
	return $coresMask
}

function Build-Cores-To-Be-Used {
	param ([int] $amount, [PsObject[]] $devicesData)

	$coresMask = Build-Cores-Mask -amount $amount
	$isHyperThreadingActive = Is-Hyperthreading-Active
	[System.Collections.ArrayList]$coresToBeUsed = @()
	foreach ($item in $devicesData) {
		for ($i=1; $i -le $amount; $i++) {
			$core = if ($isHyperThreadingActive) { if (Is-Even -value $i) { $i } else { $i+1 } } else { $i }
			if (!($coresToBeUsed | Where-Object { $_.Core -eq $core })) {
				if (!($coresToBeUsed | Where-Object { $_.ClassType -eq $item.ClassType })) {
					$coreMask = $coresMask | Where-Object { $_.Core -in ($core) }
					[void]$coresToBeUsed.Add(@{ Core = $core; Decimal = $coreMask.Decimal; ClassType = $item.ClassType })
				}
			}
		}
	}
	return $coresToBeUsed
}

function Get-Processor-Counts {
	$processorCounts = Get-WmiObject Win32_Processor | Select NumberOfCores, NumberOfLogicalProcessors
	$coresAmount = $processorCounts.NumberOfCores
	$threadsAmount = $processorCounts.NumberOfLogicalProcessors
	return @{ CoresAmount = $coresAmount; ThreadsAmount = $threadsAmount }
}

function Is-Hyperthreading-Active {
	$Counts = Get-Processor-Counts
	return $Counts.ThreadsAmount -gt $Counts.CoresAmount
}

function Get-Cores-Values {
	$Counts = Get-Processor-Counts
	$isHyperThreadingActive = Is-Hyperthreading-Active
	if ($isHyperThreadingActive) { return $Counts.ThreadsAmount } else { return $Counts.CoresAmount }
}

function Show-Device-Information {
	param ([PsObject] $item, [int] $coreAssigned)

	$ChildDeviceLocationInfo = if (Is-Empty-Str -value $item.ChildDeviceLocationInfo) { "None" } else { $item.ChildDeviceLocationInfo }
	Write-Host "Assigned to Core $($coreAssigned)"
	Write-Host "Device: $($item.ChildDeviceName) - $($item.ChildDeviceInstanceId)"
	Write-Host "Location Info: $ChildDeviceLocationInfo"
	Write-Host "PDO Name: $($item.ChildDevicePDOName)"
	Write-Host "Parent Device: $($item.ParentDeviceName) - $($item.ParentDeviceInstanceId)"
	Write-Host "Location Info: $($item.ParentDeviceLocationInfo)"
	Write-Host "PDO Name: $($item.ParentDevicePDOName)"
	[Environment]::NewLine
}

function Apply-Interrupt-Affinity-Tweaks {
	param ([PsObject[]] $devicesData, [System.Collections.ArrayList] $coresToBeUsed)

	Write-Host "Started applying Interrupt Affinity tweaks!"
	[Environment]::NewLine

	foreach ($item in $devicesData) {
		$deviceItem = $devices | Where-Object { $_.Class -eq $item.ClassType }

		if ($deviceItem.IRQPrioritization -eq $true) {
			Apply-IRQ-Priotity-Optimization -IRQValue $item.ParentDeviceIRQ
		}

		$parentAffinityPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($item.ParentDeviceInstanceId)\Device Parameters\Interrupt Management\Affinity Policy"
		$childAffinityPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($item.ChildDeviceInstanceId)\Device Parameters\Interrupt Management\Affinity Policy"
		$parentMsiPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($item.ParentDeviceInstanceId)\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
		$childMsiPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($item.ChildDeviceInstanceId)\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"

		Set-ItemProperty -Path $parentAffinityPath -Name "DevicePolicy" -Value 4 -Force -Type Dword -ErrorAction Ignore
		Set-ItemProperty -Path $childAffinityPath -Name "DevicePolicy" -Value 4 -Force -Type Dword -ErrorAction Ignore

		if ($deviceItem.MSI -eq $false) {
			if ($deviceItem.IsParentDevice -eq $true) {
				Set-ItemProperty -Path $parentMsiPath -Name "MSISupported" -Value 0 -Force -Type Dword -ErrorAction Ignore
			} else {
				Set-ItemProperty -Path $childMsiPath -Name "MSISupported" -Value 0 -Force -Type Dword -ErrorAction Ignore
			}
		}

		if ($deviceItem.DevicePriority -gt 0) {
			if ($deviceItem.IsParentDevice -eq $true) {
				Set-ItemProperty -Path $parentAffinityPath -Name "DevicePriority" -Value $deviceItem.DevicePriority -Force -Type Dword -ErrorAction Ignore
			} else {
				Set-ItemProperty -Path $childAffinityPath -Name "DevicePriority" -Value $deviceItem.DevicePriority -Force -Type Dword -ErrorAction Ignore
			}
		}

		if ($deviceItem.MSILimit) {
			if ($deviceItem.IsParentDevice -eq $true) {
				Set-ItemProperty -Path $parentMsiPath -Name "MessageNumberLimit" -Value $deviceItem.MSILimit -Force -Type Dword -ErrorAction Ignore
			} else {
				Set-ItemProperty -Path $childMsiPath -Name "MessageNumberLimit" -Value $deviceItem.MSILimit -Force -Type Dword -ErrorAction Ignore
			}
		}

		$coreData = $coresToBeUsed | Where-Object { $item.ClassType -eq $_.ClassType }

		Set-ItemProperty -Path $parentAffinityPath -Name "AssignmentSetOverride" -Value $coreData.Decimal -Force -Type Qword -ErrorAction Ignore
		Set-ItemProperty -Path $childAffinityPath -Name "AssignmentSetOverride" -Value $coreData.Decimal -Force -Type Qword -ErrorAction Ignore

		Show-Device-Information -item $item -coreAssigned $coreData.Core
	}

	Write-Host "Finished!"
	[Environment]::NewLine
}

# ------------------------------------------------------

# All changes should only be through this $devices array.
# Priority are just what comes before (lower number) the next, as to use the cores available. DevicePriority is what you use for the device.
# DevicePriority - 0 = Undefined, 1 = Low, 2 = Normal, 3 = High
$devices = @(
	[PsObject]@{Class = 'Display'; Priority = 1; Enabled = $true; Description = 'GPU'; isUSB = $false; MSILimit = $null; MSI = $true; DevicePriority = 0; IsParentDevice = $false; IRQPrioritization = $false},
	[PsObject]@{Class = 'Mouse'; Priority = 2; Enabled = $true; Description = 'Mouse'; isUSB = $true; MSILimit = 2048; MSI = $false; DevicePriority = 3; IsParentDevice = $true; IRQPrioritization = $true},
	[PsObject]@{Class = 'Net'; Priority = 3; Enabled = $true; Description = 'LAN / Ethernet'; isUSB = $false; MSILimit = 2048; MSI = $true; DevicePriority = 3; IsParentDevice = $false; IRQPrioritization = $true},
	[PsObject]@{Class = 'Media'; Priority = 4; Enabled = $false; Description = 'Audio'; isUSB = $true; MSILimit = $null; MSI = $true; DevicePriority = 0; IsParentDevice = $false; IRQPrioritization = $false},
	[PsObject]@{Class = 'Keyboard'; Priority = 5; Enabled = $false; Description = 'Keyboard'; isUSB = $true; MSILimit = 2048; MSI = $true; DevicePriority = 0; IsParentDevice = $true; IRQPrioritization = $true}
)

# ------------------------------------------------------

$Counts = Get-Processor-Counts

Min-Cores-Pre-Check -coresAmount $Counts.CoresAmount

Reset-Affinity-And-MSI-Tweaks

$PrioritizedDevices = Get-Prioritized-Devices -devices $devices
$DevicesData = Get-Devices-Data -prioritizedDevices $PrioritizedDevices

$CoresValues = Get-Cores-Values

$CoresToBeUsed = Build-Cores-To-Be-Used -devicesData $DevicesData -amount $CoresValues

Apply-Interrupt-Affinity-Tweaks -devicesData $DevicesData -coresToBeUsed $CoresToBeUsed

cmd /c pause
