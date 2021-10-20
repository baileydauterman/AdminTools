function Invoke-FastestPingInTheWest(){
    <#
    .Synopsis
    Extremely fast way to ping hundreds of machines at a time

    .Description
    Using runspaces and a runspace pool we are able to create an extremely fast was to ping machines.
    A workflow with a foreach takes over 10x longer to ping 200ish machines.
        Author: Bailey Dauterman

    .Example
    PS> $computers = Import-Csv .\a_lot_of_computers.csv
    PS> Invoke-FastestPingInTheWest -ComputerName $computers

    Name        Connection  
    -----       ----------- 
    computer1   True       
    server2     False       
    computer4   True        

    .Example
    PS> Invoke-FastestPingInTheWest -ComputerName $computers -TestWSman $true

    Name        Connection      WSMan
    -----       -----------     -----
    computer1   True            True
    server2     False           False
    computer4   True            False

    .Example
    PS> Invoke-FastestPingInTheWest -ComputerName $computers -TestWSman $true -MaxPoolSize 200

    Name        Connection      WSMan
    -----       -----------     -----
    computer1   True            True
    server2     False           False
    computer4   True            False

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $ComputerName,
        [Parameter(Mandatory=$false)]
        $TestWSman=$false,
        [Parameter(Mandatory=$false)]
        $MaxPoolSize = 100
    )

    $runspacePool = [runspacefactory]::CreateRunspacePool(1,$MaxPoolSize)
    $runspacePool.Open()

    $runspaces = foreach($computer in $ComputerName) {
        $instance = [powershell]::Create().AddScript({
            param($Computer)

            $ping = Test-Connection -ComputerName $Computer -Count 1 -Quiet
            if($ping -and $TestWSman) {
                $wsman = [bool](Test-WSMan -ComputerName $Computer -ErrorAction SilentlyContinue)
            } elseif(!($TestWSman)) {
                $wsman = $null
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

    $runspacePool.Close()

    return $output
}
