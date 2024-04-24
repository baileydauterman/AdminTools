function Get-WindowsUpdateHistory {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $searcher = (New-Object -ComObject Microsoft.Update.Session).CreateUpdateSearcher()
    }
    
    process {
        $searcher.QueryHistory(0, $searcher.GetTotalHistoryCount()) | Select-Object Title, Description,
        @{
            name="Operation"
            expression={switch($_.operation) {
                1 {'Install'}
                2 {'Uninstall'}
                3 {'Other'}}}
        }, 
        @{
            name="Status"
            expression={switch($_.resultcode){
                1 {'In Progress'}
                2 {'Success'}
                3 {'Success with Errors'}
                4 {'Failed'}
                5 {'Aborted'}}
            }
        },
        Date
    }
    
    end {
        
    }
}