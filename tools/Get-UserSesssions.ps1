function Get-UserSessions($ComputerName=$null) {
    if($null -eq $ComputerName) {
        [PSCustomObject](query user) -replace "\s{2,22}", "," | ConvertFrom-Csv
    } else {
        if(Test-Connection $ComputerName -Count 1 -Quiet) {
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                [PSCustomObject](query user) -replace "\s{2,22}", "," | ConvertFrom-Csv
            }
        } else {
            Write-Warning "Unable to reach $ComputerName, make sure the machine is online and reachable"
        }
    }
}
