# Get-DirectoryLastWriteTime

Gets the last time a file was written in a directory

## Syntax
```powershell
Get-DirectoryLastWriteTime
    [[-Path] <string[]>]
    [-Recurse]
```

## Examples

Running this command will return the uptime of remote computer computer01 
```powershell
Get-DirectoryLastWriteTime -ComputerName computer01
```

You can run the command without specifying the computer name and it will run locally.
```powershell
Get-DirectoryLastWriteTime
```