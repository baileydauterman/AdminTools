function Start-StayAwake {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $wshell = New-Object -ComObject "WScript.Shell"
    }
    
    process {
        while ($true) {
            Clear-Host
            $wshell.SendKeys("{NUMLOCK}")
            $wshell.SendKeys("{NUMLOCK}")

            Write-Host $(Get-Date)

            Start-Sleep 35
        }
    }
    
    end {
        
    }
}