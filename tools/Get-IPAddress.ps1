function Get-IPAddress() {
    Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, AddressFamily
}