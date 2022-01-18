function Resolve-DhcpServer() {

    foreach($server in (Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true").DHCPServer ) {
        if ($server -ne $null) {
            [PSCustomObject]@{
                Name = (Resolve-DnsName $server).NameHost
                IP = $server
            }
        }
    }
}
