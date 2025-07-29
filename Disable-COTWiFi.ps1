# Script: Disable-COTWiFi.ps1

# Set adapter name (exact or partial match)
$targetAdapterName = "cotwifi"

# Get the adapter with that name
$adapter = Get-NetAdapter | Where-Object { $_.Name -like "*$targetAdapterName*" }

# Check if adapter exists
if ($null -eq $adapter) {
    Write-Output "No network adapter found matching '*$targetAdapterName*'."
    return
}

# Disable if it's up
if ($adapter.Status -eq "Up") {
    Disable-NetAdapter -Name $adapter.Name -Confirm:$false
    Write-Output "Disabled adapter: $($adapter.Name)"
} else {
    Write-Output "Adapter is already disabled or not active: $($adapter.Name)"
}


#How to Test: Save as Disable-COTWiFi.ps1
#Run in PowerShell as Administrator
#Output will tell you whether it found and disabled the adapter!
