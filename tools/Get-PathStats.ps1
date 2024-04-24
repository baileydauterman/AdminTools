function Get-PathStats() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,Position=0)]
        $Path="."
    )

    $ErrorActionPreference = "SilentlyContinue"

    if($path -eq ".") {
        $path = Get-Location
    }

    if(Test-Path $Path) {
        $folders = Get-ChildItem -Path "$Path" -Directory -ErrorAction SilentlyContinue
        foreach ($folder in $folders) {
            $subfolders = Get-ChildItem -Path $folder.FullName -ErrorAction SilentlyContinue -Force -Recurse

            if ($subfolders.Length -gt 0) {
                $pathSize = [math]::Round(($subfolders | Measure-Object -Property Length -Sum ).Sum / 1GB,3)
            } else {
                $pathSize = 0.0
            }

            [PSCustomObject]@{
                Name = $folder.FullName
                "Size(GB)" = $pathSize
                SubFolders = @($subfolders.FullName)
            }
        }  
    } else {
        throw "Path does not exist, make sure you typed it correctly."
    }
}
