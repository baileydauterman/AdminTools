function Get-MacAddress([Parameter(Mandatory=$false)]$ComputerName) {
    if($null -eq $ComputerName) {
        return (Get-CimInstance Win32_NetworkAdapter | Where-Object -like "*Ethernet*").MACAddress
    } else {
        if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
           return (Get-CimInstance Win32_NetworkAdapter  -ComputerName $ComputerName | Where-Object -like "*Ethernet*").MACAddress 
        }
        
        Write-Warning "$ComputerName is not reachable"
    }
}