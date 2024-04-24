function Resolve-DhcpServer() {
    foreach($server in (Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Where-Object DHCPServer -ne $null ).DHCPServer ) {
        [PSCustomObject]@{
            Name = (Resolve-DnsName $server).NameHost
            IP = $server
        }
    }
}
