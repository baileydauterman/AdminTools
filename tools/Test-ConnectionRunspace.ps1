function Test-ConnectionRunspace(){
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
    PS> Test-ConnectionRunspace -ComputerName $computers

    Name        Connection  
    -----       ----------- 
    computer1   True       
    server2     False       
    computer4   True        

    .Example
    PS> Test-ConnectionRunspace -ComputerName $computers -MaxPoolSize $computers.Count

    Name        Connection      
    -----       -----------     
    computer1   True            
    server2     False           
    computer4   True    

    .Example
    PS> Test-ConnectionRunspace -ComputerName $computers -AddMembers "VarToTrack"

    Name        Connection    VarToTrack  
    -----       -----------  -----------
    computer1   True            
    server2     False           
    computer4   True            

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $ComputerName,
        [Parameter(Mandatory=$false)]
        $MaxPoolSize = 100,
        [Parameter(Mandatory=$false)]
        $AddMembers
    )

    $runspacePool = [runspacefactory]::CreateRunspacePool(1,$MaxPoolSize)
    $runspacePool.Open()

    $runspaces = foreach($computer in $ComputerName) {
        $instance = [powershell]::Create().AddScript({
            param(
                $Computer,
                $AddMembers
            )

            $outputObj = [PSCustomObject]@{
                Name = $Computer
                Connection = Test-Connection -ComputerName $Computer -Count 1 -Quiet -ErrorAction SilentlyContinue
            }

            if($AddMembers) {
                foreach($m in $AddMembers) {
                    $outputObj | Add-Member -NotePropertyName $m -NotePropertyValue $null
                }
            }

            $outputObj
        }).AddParameter('Computer', $computer).AddParameter('AddMembers', $AddMembers)

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
