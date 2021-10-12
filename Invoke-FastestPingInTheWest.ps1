function Invoke-FastestPingInTheWest(){
    <#
    .Synopsis
    Extremely fast was to ping hundreds of machines at a time

    .Description
    Using runspaces and a runspace pool we are able to create an extremely fast was to ping machines.
    A workflow with a foreach takes over 10x longer to ping 200ish machines.
        Author: Bailey Dauterman

    .Example
    PS> $computers = Import-Csv .\a_lot_of_computers.csv
    PS> Invoke-FastestPingInTheWest -ComputerName $computers

    Name        Connection      WSMan
    -----       -----------     -----
    computer1   True            True
    server2     False           False
    computer4   True            False
    #>
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
