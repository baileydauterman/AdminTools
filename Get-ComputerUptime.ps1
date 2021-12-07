function Get-ComputerUptime($ComputerName) {
    if($null -eq $ComputerName) {
        return (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    } elseif(Test-Connection $ComputerName -Count 1 -Quiet) {
        return (Get-Date) - (Get-CimInstance Win32_OperatingSystem -ComputerName $ComputerName).LastBootUpTime
    } 

    Write-Warning "Unable to reach $ComputerName, make sure the machine is online and reachable."
}