# Get-ComputerTrackingInfo

Gets information needed to track down a machine on the network

## Syntax
```powershell
Get-ComputerTrackingInfo
    [[-Computername] string[]]
```

## Examples

For local machine
```powershell
Get-ComputerTrackingInfo
```

For remote machine
```powershell
Get-ComputerTrackingInfo -Computername computer1
```
For multiple remote machine
```powershell
Get-ComputerTrackingInfo -Computername computer1, computer2
```