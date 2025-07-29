# preheck.ps1
#
# this file will automate most of the precheck, aside from a few that require user password input. Here are the goals:
#
# #Enable remoteregistry
# #Sets all sleep settings to "never"
# #checks to make sure the windows version is not LTSC
# #Disables wifi and cellular adapters
# #Launches chrome/edge directly to the passwords page for export
# #Launches onedrive for user login
# #Reboot must be done manually after data has been backed up



# Ensure script is run as admin
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
  Write-Warning "Please run this script as Administrator."
  pause
  exit
}

# Enable remoteregistry
function Enable-RemoteRegistry{
  Write-Host "Enabling RemoteRegistry..."
  Set-Service -Name RemoteRegistry -StartupType
  Start-Service -Name RemoteRegistry
  Write-Host "RemoteRegistry has been enabled."
}

# Set Sleep Settings to Never
function Set-SleepSettings {
Write-Host "Setting sleep settings to 'never'"
  #TODO: write sleep setting # Script: Disable-WiFi-Cellular.ps1


# Script: Disable-COTWiFi.ps1

# Set adapter name (exact or partial match)
$targetAdapterName = "COTWiFi"

# Get the adapter with that name
$adapter = Get-NetAdapter | Where-Object { $_.Name -like "*$targetAdapterName*" }

# Disable if it's up
if ($adapter.Status -eq "Up") {
    Disable-NetAdapter -Name $adapter.Name -Confirm:$false
    Write-Output "Disabled adapter: $($adapter.Name)"
} else {
    Write-Output "Adapter is already disabled: $($adapter.Name)"
}ular.ps1

