function Get-InstalledSoftwareRunspace([Parameter(Mandatory=$true)]$ComputerName) {
    $runspacePool = [runspacefactory]::CreateRunspacePool(1,100)
    $runspacePool.Open()

    $runspaces = foreach($computer in $ComputerName) {
        $PSInstance = [powershell]::Create().AddScript({
            param($Computer)

            Get-InstalledSoftware -ComputerName $Computer
            
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
