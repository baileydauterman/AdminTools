# Get-DirectoryLastWriteTime

Gets the last time a file was written in a directory

## Syntax
```powershell
Get-DirectoryLastWriteTime
    [[-Path] <string[]>]
    [-Recurse]
```

## Examples

Run on remote machine: 
```powershell
Get-DirectoryLastWriteTime -ComputerName computer01
```

Run locally:
```powershell
Get-DirectoryLastWriteTime
```