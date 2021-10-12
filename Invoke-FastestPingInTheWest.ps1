function Invoke-FastestPingInTheWest(){
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $ComputerName
    )

    $runspacePool = [runspacefactory]::CreateRunspacePool(1,100)
    $runspacePool.Open()

    $runspaces = foreach($computer in $ComputerName) {
        $instance = [powershell]::Create().AddScript({
            param($Computer)

            $ping = Test-Connection -ComputerName $Computer -Count 1 -Quiet
            if($ping) {
                $wsman = [bool](Test-WSMan -ComputerName $Computer -ErrorAction SilentlyContinue)
            } else {
                $wsman = $false
            }

            New-Object PSObject -Property @{
                Name = $Computer
                Connection = $ping
                WSMan = $wsman
            }
        }).AddParameter('Computer', $computer)

        $instance.RunspacePool = $runspacePool

        New-Object PSObject -Property @{
            Instance = $instance
            IAsyncResult = $instance.BeginInvoke()
            Argument = $computer
        }
    }

    while($runspaces | Where-Object { -not $_.IAsyncResult.IsCompleted }) {
        Start-Sleep -Milliseconds 50
    }

    $output = @()

    $runspaces | ForEach-Object {
        $output += $_.Instance.EndInvoke($_.IAsyncResult)
    }

    return $output
}