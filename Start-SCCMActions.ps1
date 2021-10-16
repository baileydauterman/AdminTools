function Start-SCCMActions() {
    [Parameter(Mandatory=$true)]
    $ComputerName

    foreach($computer in $ComputerName) {
        if(Test-Connection $computer -Count 1 -Quiet) {
            Invoke-Command -ComputerName $computer -ScriptBlock {
                $SCCMClient = New-Object -ComObject CPApplet.CPAppletMgr

                foreach ($action in $SCCMClient.GetActions()) {
                    $action.PerformAction()
                }
            }
        }
    }
}