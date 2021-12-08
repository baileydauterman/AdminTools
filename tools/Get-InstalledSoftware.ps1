function Get-InstalledSoftware([Parameter(Mandatory=$true)]$ComputerName) {
    $runspacePool = [runspacefactory]::CreateRunspacePool(1,100)
    runspacePool.Open()

    $runspaces = foreach($computer in $ComputerName) {
        $PSInstance = [powershell]::Create().AddScript({
            param($Computer)

            $ping = Test-Connection -ComputerName $Computer -Count 1 -Quiet
            if($ping) {
                $wsmanstatus =  [bool](Test-WSMan -ComputerName $Computer -ErrorAction SilentlyContinue)
                if($wsmanstatus) {
                    $softwares = Get-CimInstance Win32_Product -ComputerName $Computer | Sort-Object Name
                }
            } else {
                $wsmanstatus = $false
                $softwares = $false
            }

            [PSCustomObject]@{
                Name = $Computer
                Connection = $ping
                WSMan = $wsmanstatus
                SoftwareCount = $softwares.Count
                Softwares = $softwares | SElect-Object Name, Caption, Vendor, Version, IdentifyingNumber
            }
        }).AddParameter('Computer', $computer)

        $PSInstance.RunspacePool = $runspacePool

        [PSCustomObject]@{
            Instance = $PSInstance
            IAsyncResult = $PSInstance.BeginInvoke()
            Argument = $computer
        }
    }

    while ($runspaces | Where-Object {-not $_.IAsyncResult.IsCompleted}) {
        Start-Sleep -Milliseconds 100
    }

    $runspaces | ForEach-Object {
        $_.Instance.EndInvoke($_.IAsyncResult)
    }
}
