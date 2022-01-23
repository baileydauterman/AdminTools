# Get-ComputerUptime

`Get-ComputerUptime` does exactly like its name implies, you pass a remote computer to the `-ComputerName` parameter. If that machine has the WinRM service enabled and open it will return the uptime of the machine based on the OperatingSytem CIM Instance.

## Examples

Running this command will return the uptime of remote computer computer01 
```
Get-ComputerUptime -ComputerName computer01
```

You can run the command without specifying the computer name and it will run locally.
```
Get-ComputerUptime
```