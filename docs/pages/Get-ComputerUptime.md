# Get-ComputerUptime

Returns the uptime of a machine in a DateTime object.

## Syntax
```powershell
Get-ComputerTrackingInfo
    [[-Computername] string[]]
```

## Examples

Run on remote machine:
```powershell
Get-ComputerUptime -ComputerName computer01
```

Run locally: 
```powershell
Get-ComputerUptime
```