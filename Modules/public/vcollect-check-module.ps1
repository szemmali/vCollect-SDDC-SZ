<# 
.SYNOPSIS
  Script to check powershell module name already exists or  not.

.DESCRIPTION
  If module is imported say that and do nothing
  If module is not imported, but available on disk then import
  If module is not imported, not available on disk, but is in online gallery then install and import
  If module is not imported, not available and not in online gallery then abort

.PARAMETER dir
  One or more folder names separated by commas. 

.EXAMPLE
  vcollect-check-module "CredentialManager"
  vcollect-check-module "VMware.PowerCLI"
  
.LINK
  https://github.com/szemmali/vCollect-SDDC-SZ

.NOTES
  Function by Saddam ZEMMALI
  v1.0 - 06/01/2019

#>
function vcollect-check-module ($m) {
    # If module is imported say that and do nothing
    if (Get-Module | Where-Object {$_.Name -eq $m}) {
        write-host "Module $m "  -f Magenta -NoNewLine  
        write-host "is already imported." -f Green
    } else {
        # If module is not imported, but available on disk then import
        Write-Warning "Module $m is NOT imported (must be installed before starting)."
        if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $m}) {
            Import-Module $m -Verbose
        } else {
            # If module is not imported, not available on disk, but is in online gallery then install and import
            if (Find-Module -Name $m | Where-Object {$_.Name -eq $m}) {
                Install-Module -Name $m -Force -Verbose -Scope CurrentUser
                Import-Module $m -Verbose
            } else {
                # If module is not imported, not available and not in online gallery then abort
                Write-Warning "Module $m not imported, not available and not in online gallery, exiting."
                EXIT 1
            }
        }
    }
}
