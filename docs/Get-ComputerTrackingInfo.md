# Get-ComputerTrackingInfo

Gets information needed to track down a machine on the network

## Syntax
```powershell
Get-ComputerTrackingInfo
    [[-Computername] string[]]
```

## Examples

Returns path stats for C:\
```powershell
Get-ComputerTrackingInfo
```

for specified dir
```powershell
Get-ComputerTrackingInfo -Path C:\Users
```
