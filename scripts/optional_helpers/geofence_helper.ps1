<#
GeoFence are just firewall IP blocking of servers / regions you do not want to be connected to. That can solve problems in games that do connect you outside your own region in which some cases are bad, since you are put into high ping servers.

It can work in any game as long as you know the correct .exe location and the ips / ip ranges you want to block. In a multiplayer game, you can usually find the IPs in the support / wiki section, but it can be outdated/incomplete information, therefore some you might have to get yourself directly or look elsewhere.

GeoFilter vs GeoFence - GeoFilter serves the purpose to block anything outside the radius of your own ip location, where GeoFence, you build different fences (radius like) in different locations and block everything that is not inside them. Pretty much concepts of ip blocking.

There are websites that can make it easy in certain games, e.g., Call of Duty
https://cyanlabs.net/free-multi-sbmm-disabler/

Others you have to get the ips yourself.
https://us.battle.net/support/en/article/7871 - https://github.com/foryVERX/Overwatch-Server-Selector

In case you are using Windows Firewall, use this powershell script.
If not and you are using other Firewall solutions, you have to do it yourself, but same concept, IP blocking Inbound and Outbound to Remote Addresses.

You can add single ips or ip range. You can separate each ip or range with comma. To specify a range, you use -, as in 0.0.0.0-255.255.255.255. To update ips if that is ever needed, just change the ips and re-execute the whole script.
Make sure that is the game .exe, not the launcher .exe, sometimes they are in different folders.
Remove the example IPs from @() and put the IP addresses you want to, separating them with comma and inside double quotes.


You only need to alter $GameExeLocation and $IPs

$GameExeLocation = "C:\...\YOUR_GAME.exe";
$IPs = @("123.1.32.2", "1.2.0.0-1.2.255.255");

$GameExeSplit = $GameExeLocation.Split("\");
$RuleName = "$($GameExeSplit[$GameExeSplit.Length - 1])-GeoFence";
Remove-NetFirewallRule -DisplayName "$RuleName-Out" -ErrorAction SilentlyContinue;
Remove-NetFirewallRule -DisplayName "$RuleName-In" -ErrorAction SilentlyContinue;
New-NetFirewallRule -DisplayName "$RuleName-Out" -Direction Outbound -Protocol Any -Action Block -Program $GameExeLocation -RemoteAddress $IPs;
New-NetFirewallRule -DisplayName "$RuleName-In" -Direction Inbound -Protocol Any -Action Block -Program $GameExeLocation -RemoteAddress $IPs;


In cases like Overwatch, if the IPs from the support/wiki are not enough, and you are still being put in high ping servers, you can press Ctrl+Shift+N and you will see the stats, the IP should be above, you can then use the first 2 decimals and build a range yourself. Use .0.0 in the from and .255.255 in the to. e.g., 35.228.0.0-35.228.255.255

You can also whitelist if you want, you Allow instead of Block and only put the IPs/IP-Ranges you want to connect to. Do whatever that which you are able to make it work.

Some games might redirect you to a server that works if the connection fails, others, it might just fail, if they try to put you in a server that is being blocked. You could lose the queue because of it. Be aware before doing this.

There are paid solutions, I would say that they are NOT worth. Since they are probably just doing this, but in a nicer UI.
Also, do not be fooled by VPN, this is not VPN and VPN will not GeoBlock anything unless they are specifically doing it per game inside their own firewall. Make no sense, since you can easily do it yourself.
VPN will only put you as if you were in another location, but that is even worse, latency wise, because if you are being put in different regions servers, that will happen the same to the VPN IP, it will be put to a different server from the VPN location instead.

If the connection fail instead of being redirected to a working server. And if you get temporarily suspended or so, it's because of the game implementation.
If you take Overwatch 2 as example, currently, they provide you with a pool of ips, if that pool does not have an IP that is in the range of the whitelisted, you may get a fail. It's also due to bad implementation in the game.
#>

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------

# If you are using simplewall, currently, the only way is export your profile, by going to File > Export > profile.xml
# I can generate rules based on lists of IPs, the rule that you would add inside <rules_custom></rules_custom> tag. 
# Once you had added there, you only need to import, not partially, but entirely, because it will be the whole config, you lose what you had there, that is overwritting everything. Through File > Import > profile.xml
# A simple implementation were not possible due to simplewall current limit of 256 characters per rule.
# I built this to myself mostly, but to support most, in a complete way, it would require something like a website, to support multiple types of firewall and games, while automating as much as possible.

# Check for dupes - https://iptoolsonline.net/

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------

function Get-Broadcast ($addressAndCidr) {
    function New-IPv4toBin ($ipv4) {
        $BinNum = $ipv4 -split '\.' | ForEach-Object {[System.Convert]::ToString($_,2).PadLeft(8,'0')}
        return $binNum -join ""
    }
    $addressAndCidr = $addressAndCidr.Split("/")
    $addressInBin = (New-IPv4toBin $addressAndCidr[0]).ToCharArray()
    for ($i=0;$i -lt $addressInBin.length;$i++) {
        if ($i -ge $addressAndCidr[1]){
            $addressInBin[$i] = "1"
        } 
    }
    [string[]]$addressInInt32 = @()
    for ($i = 0;$i -lt $addressInBin.length;$i++) {
        $partAddressInBin += $addressInBin[$i] 
        if (($i+1)%8 -eq 0) {
            $partAddressInBin = $partAddressInBin -join ""
            $addressInInt32 += [Convert]::ToInt32($partAddressInBin -join "",2)
            $partAddressInBin = ""
        }
    }
    $addressInInt32 = $addressInInt32 -join "."
    return $addressInInt32
}

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------

# Only alter the 3 below
$GeoFence_IPs_FileName = "Overwatch2" # /gaming_os_tweaker/scripts/configs/geofence
$RegionToConnect = "GBR1"
$GameExePath = "C:\program files (x86)\steam\steamapps\common\overwatch\overwatch.exe"

$GameExeSplit = $GameExePath.Split("\");
$RuleName = "$($GameExeSplit[$GameExeSplit.Length - 1])-GeoFence";
$GeofenceListPath = "$(Split-Path -Path $PSScriptRoot -Parent)\configs\geofence\$($GeoFence_IPs_FileName)_IPs.txt"
$Content = Get-Content -path $GeofenceListPath
$IsFromRegionToConnect = $false
$BlockedIPs = ""
$RulesItems = @();
$TempEndStorage = ""
$WindowsFirewallBlockedIPs = "";
for ($i = 0; $i -lt $Content.Length; $i++) {
    $Line = $Content[$i]
    $IsLineTitle = $Line.StartsWith('#')
    if ($IsLineTitle) {
        $Region = $Line.Trim().Split('-')[2].Trim()
        if ($Region -eq $RegionToConnect) {
            $IsFromRegionToConnect = $true
        } else {
            $IsFromRegionToConnect = $false
        }
        continue
    }
    if ($IsFromRegionToConnect -eq $false) {
		$IP = $Line.Trim() + ';'
        if ($IP.Length -le 1) {
            continue
        }
		$TempItem = $BlockedIPs + $IP
		if ($TempItem.Length -lt 256) {
			$BlockedIPs += $IP
		} else {
			$RulesItems += $BlockedIPs
			$BlockedIPs = ""
            $TempEndStorage = ""
			$BlockedIPs += $IP
		}
    	$TempEndStorage += $IP
	 
		$WFIP = $Line.Trim()
        if ($WFIP.Length -le 1) {
            continue
        }
        if ($WFIP.Contains('/')) {
            $WFIPRightRange = Get-Broadcast -addressAndCidr $WFIP
            $WFIP = "$($WFIP.Split('/')[0])-$WFIPRightRange"
        }
        $IPRange = $WFIP + ','
  		$WindowsFirewallBlockedIPs += $IPRange
    }
}

$WindowsFirewallBlockedIPs = $WindowsFirewallBlockedIPs.Remove($WindowsFirewallBlockedIPs.Length - 1, 1)
if ($TempEndStorage.Length -gt 0) {
    $RulesItems += $TempEndStorage
}

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------

[Environment]::NewLine
Write-Host "simplewall"
[Environment]::NewLine
for ($i = 0; $i -lt $RulesItems.Length; $i++) {
    Write-Host "<item name=""$RuleName-$i"" rule=""$($RulesItems[$i])"" dir=""2"" protocol=""17"" apps=""$GameExePath"" is_block=""true"" is_enabled=""true""/>"
}
[Environment]::NewLine

[Environment]::NewLine
Write-Host "Windows Firewall"
[Environment]::NewLine
Write-Host "Remove-NetFirewallRule -DisplayName ""$RuleName-Out"" -ErrorAction SilentlyContinue;"
Write-Host "Remove-NetFirewallRule -DisplayName ""$RuleName-In"" -ErrorAction SilentlyContinue;"
Write-Host "New-NetFirewallRule -DisplayName ""$RuleName-Out"" -Direction Outbound -Protocol Udp -Action Block -Program ""$GameExePath"" -RemoteAddress $WindowsFirewallBlockedIPs"
Write-Host "New-NetFirewallRule -DisplayName ""$RuleName-In"" -Direction Inbound -Protocol Udp -Action Block -Program ""$GameExePath"" -RemoteAddress $WindowsFirewallBlockedIPs"
[Environment]::NewLine

cmd /c pause
