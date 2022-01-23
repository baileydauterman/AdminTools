# Get-PathStats

Gets the path statistics for file path. Includes: FullName, Size(GB), SubFolders

## Syntax
```powershell
Get-PathStats
    [-Path "."]
```

## Examples

Returns path stats for current working directory
```powershell
Get-PathStats
```

for specified directory
```powershell
Get-PathStats -Path C:\Users
```
