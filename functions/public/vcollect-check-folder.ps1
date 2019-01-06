<# 
.SYNOPSIS
  Script to check Folder name already exists or  not.

.DESCRIPTION
  check if folder name already exist if not will be created

.PARAMETER dir
  One or more folder names separated by commas. 

.EXAMPLE
  vcollect-check-folder "vCollect-Storage"

.LINK
  https://github.com/szemmali/vCollect-SDDC-SZ

.NOTES
  Function by Saddam ZEMMALI
  v1.0 - 06/01/2019

#>
function vcollect-check-folder ($dir) {

    if(!(Test-Path -Path $report\$dir )){
        New-Item -ItemType directory -Path $report\$dir
        Write-Host "New Storage folder created" -f Magenta
        New-Item -Path $report\$dir -Name $dateF -ItemType "directory"
        Write-Host "New Work folder created"   -f Magenta
    }
    else{
      Write-Host "Storage Folder already exists" -f Green
      New-Item -Path $report\$dir -Name $dateF -ItemType "directory"
      Write-Host "New Work folder created"  -f Magenta
    }    
}