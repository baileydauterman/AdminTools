function Get-DirectoryLastWriteTime($Path, [switch]$Recurse) {
    if($Recurse) {
        return (Get-ChildItem -Path $Path -Recurse) | Sort-Object -Property LastWriteTime | Select-Object -First 1
    }

    return (Get-ChildItem -Path $Path) | Sort-Object -Property LastWriteTime | Select-Object -First 1
}