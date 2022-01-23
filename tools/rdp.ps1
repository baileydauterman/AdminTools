function rdp {
    [CmdletBinding()]
    param (
        # machine to rdp into
        [Parameter(Mandatory=$true, Position=0)]
        [string]
        $ComputerName
    )
    
    begin {
        if(-not (Test-Connection $ComputerName -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
            throw "Machine unreachable"
            return
        }
    }
    
    process {
        Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "$env:userprofile\documents\default.rdp /v:$ComputerName"
    }
    
    end {
        
    }
}