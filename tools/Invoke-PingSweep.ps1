function Invoke-PingSweep(){
    <#
    .Synopsis
    Extremely fast way to ping hundreds of machines at a time

    .Description
    Using runspaces and a runspace pool we are able to create an extremely fast was to ping machines.
    Comparison of time to complete task in minutes (625 machines on the same network):
        Using Test-Connection           : 50:02.140
        Workflow with ForEach -Parallel : 10:17.312
        Using this function             : 00:21.058
        
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
    PS> Invoke-FastestPingInTheWest -ComputerName $computers -MaxPoolSize $computers.Count

    Name        Connection      
    -----       -----------     
    computer1   True            
    server2     False           
    computer4   True    

    .Example
    PS> Invoke-FastestPingInTheWest -ComputerName $computers -AddMembers "VarToTrack"

    Name        Connection    VarToTrack  
    -----       -----------  -----------
    computer1   True            
    server2     False           
    computer4   True            

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $Start,
        [Parameter(Mandatory=$true)]
        $Stop,
        [Parameter(Mandatory=$false)]
        $AddMembers
    )

    $runspacePool = [runspacefactory]::CreateRunspacePool(1,100)
    $runspacePool.Open()

    # Build IP Range
    # created by Dr. Tobias Weltner, MVP PowerShell
    $ip1 = ([System.Net.IPAddress]$start).GetAddressBytes()
    [Array]::Reverse($ip1)
    $ip1 = ([System.Net.IPAddress]($ip1 -join '.')).Address
    $ip2 = ([System.Net.IPAddress]$stop).GetAddressBytes()
    [Array]::Reverse($ip2)
    $ip2 = ([System.Net.IPAddress]($ip2 -join '.')).Address

    $computers = for ($x=$ip1; $x -le $ip2; $x++)
    {
        $ip = ([System.Net.IPAddress]$x).GetAddressBytes()
        [Array]::Reverse($ip)
        $ip -join '.'
    }
    

    $runspaces = foreach($computer in $computers) {
        $instance = [powershell]::Create().AddScript({
            param(
                $computer,
                $AddMembers
            )

            $outputObj = [PSCustomObject]@{
                Name = $computer
                Connection = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction SilentlyContinue
            }

            if($AddMembers) {
                foreach($m in $AddMembers) {
                    $outputObj | Add-Member -NotePropertyName $m -NotePropertyValue $null
                }
            }

            $outputObj
        }).AddParameter('computer', $computer).AddParameter('AddMembers', $AddMembers)

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

    $runspaces | ForEach-Object {
        $_.Instance.EndInvoke($_.IAsyncResult)
    }

    $runspacePool.Close()
}
