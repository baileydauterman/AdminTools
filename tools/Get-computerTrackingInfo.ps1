function Get-ComputerTrackingInfo($ComputerName) {
    if(-not (Test-Connection $ComputerName -Count 1 -Quiet)) {
        throw "$ComputerName : Host offline or unreachable";
    }

    $netConf = Get-NetIPConfiguration | Where-Object InterfaceAlias -eq "Ethernet"

    [PSCustomObject]@{
        Name = $ComputerName
        Uptime = Get-ComputerUptime $ComputerName
        MacAddress = Get-MacAddress $ComputerName
        IPAddress = $netConf.IPv4Address.IPAddress
        IPv4Gateway = $netConf.IPv4DefaultGateway.NextHop
        Users = Get-RemoteUser $ComputerName
    }
}