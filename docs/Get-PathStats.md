# Get-PathStats

Gets the path statistics for file path. Includes: FullName, Size(GB), SubFolders

## Syntax
```powershell
Get-PathStats
    [-Path C:\]
```

## Examples

Returns path stats for C:\
```powershell
Get-PathStats
```

for specified dir
```powershell
Get-PathStats -Path C:\Users
```
