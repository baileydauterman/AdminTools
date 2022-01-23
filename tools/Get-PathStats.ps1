function Get-PathStats() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,Position=0)]
        $Path="."
    )

    if($path -eq ".") {
        $path = Get-Location
    }

    if(Test-Path $Path) {
        $folders = Get-ChildItem -Path "$Path" -Directory -ErrorAction SilentlyContinue
        foreach ($folder in $folders) {
            $subfolders = Get-ChildItem -Path $folder.FullName -ErrorAction SilentlyContinue -Force -Recurse

            [PSCustomObject]@{
                Name = $folder.FullName
                "Size(GB)" = [math]::Round(($subfolders | Measure-Object -Property Length -Sum ).Sum / 1GB,3)
                SubFolders = @($subfolders.FullName)
            }
        }  
    } else {
        throw "Path does not exist, make sure you typed it correctly."
    }
}
