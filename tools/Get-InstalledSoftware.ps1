function Get-InstalledSoftware([Parameter(Mandatory=$false)]$ComputerName) {

    $ping = Test-Connection -ComputerName $ComputerName -Count 1 -Quiet
    if($ping) {
        $wsmanstatus =  [bool](Test-WSMan -ComputerName $ComputerName -ErrorAction SilentlyContinue)
        if($wsmanstatus) {
            $softwares = Get-CimInstance Win32_Product -ComputerName $ComputerName | Sort-Object Name
        }
    } else {
        $wsmanstatus = $false
        $softwares = $false
    }

    [PSCustomObject]@{
        Name = $ComputerName
        Connection = $ping
        WSMan = $wsmanstatus
        SoftwareCount = $softwares.Count
        Softwares = $softwares | Select-Object Name, Caption, Vendor, Version, IdentifyingNumber
    }
}