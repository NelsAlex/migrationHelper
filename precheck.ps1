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
  #TODO: write sleep setting logic
}
