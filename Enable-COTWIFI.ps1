# Script: Enable-COTWiFi.ps1

$targetAdapterName = "COTWiFi"
$adapter = Get-NetAdapter | Where-Object { $_.Name -like "*$targetAdapterName*" }

if ($null -eq $adapter) {
    Write-Output "No network adapter found matching '*$targetAdapterName*'."
    return
}

if ($adapter.Status -eq "Disabled") {
    Enable-NetAdapter -Name $adapter.Name -Confirm:$false
    Write-Output "Enabled adapter: $($adapter.Name)"
} else {
    Write-Output "Adapter is already enabled: $($adapter.Name)"
}
