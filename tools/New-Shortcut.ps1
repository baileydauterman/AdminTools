<#
.SYNOPSIS
    New-Shortcut creates a new shortcut with the given name to the given target location.

.EXAMPLE
    PS> # Create a new shortcut at the default path (User desktop)
    PS> New-Shortcut -Name "SuperCoolShortcut" -ShortcutTarget "\\remoteserver\target.exe"

.EXAMPLE
    PS> # Create a new shortcut at a specified path
    PS> New-Shortcut -Name "SuperCoolShortcut2.lnk" -ShortcutTarget "\\remoteserver\target.png" -Path "C:\temp\shortcuts"
#>
function New-Shortcut {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Name,
        [Parameter(Mandatory)]
        [string]
        $ShortcutTarget,
        [Parameter()]
        [string]
        $Path = [Environment]::GetFolderPath("Desktop")
    )

    if (-not (Test-Path $Path)){
        throw "Destination path for the shortcut does not exist"
        return
    }

    if (-not $Name.EndsWith(".lnk")) {
        $Name = "$Name.lnk"
    }

    $Path = [System.IO.Path]::Combine($Path, $Name)
    $WshShell = New-Object -comObject WScript.Shell

    $Shortcut = $WshShell.CreateShortcut($Path)
    $Shortcut.TargetPath = $ShortcutTarget
    $Shortcut.Save()
}
