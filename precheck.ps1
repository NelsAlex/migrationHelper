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
# #print full hostname to the console for contractor to verify with the smartsheet
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
function enableRemoteRegistry{
  Write-Host "Enabling RemoteRegistry..."
  Set-Service -Name RemoteRegistry -StartupType
  Start-Service -Name RemoteRegistry
  Write-Host "RemoteRegistry has been enabled."
}

# Set Sleep Settings to Never
function setSleepSettings {
  Write-Host "Setting sleep settings to never..."
  powercfg /change standby-timeout-ac 0
  powercfg /change standby-timeout-dc 0
  powercfg /change monitor-timeout-ac 0
  powercfg /change monitor-timeout-dc 0
}

#Checks the windows version for LTSC
function isLTSC{
    # Get the edition from the registry
    $edition = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").EditionID

    # Check for LTSC variants
    if ($edition -match "LTSC|LTSB") {
        Write-Output "LTSC Windows version discovered. Please remove from migration and reimage."
    } else {
        Write-Output "This is NOT an LTSC version of Windows."
    }
}

function disableWifiCellular{
  #TODO: Feyza, you can put your code in this block
}

#Launches Chrome and Edge to the password backup pages
function passwordBackup{
  #Variables
  $chromePath = "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
  $edgePath = "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
  $passwordExportURL = "chrome://settings/passwords"

  #Open browsers to correct path
  if(Test-Path $chromePath){
    Start-Process -FilePath $chromePath -ArgumentList $passwordExportURL
  } else{
    Write-Warning "Chrome not found at expected path: $chromePath"
  }

  if(Test-Path $edgePath){
    Start-Process -FilePath $edgePath -ArgumentList $passwordExportURL
  } else{
    Write-Warning "Edge not found at the expected path: $edgePath"
  }
  }


function launchOnedrive{
  #is this even necessary? idk
}

function printHostname{
  #TODO: output hostname to cmd
}




