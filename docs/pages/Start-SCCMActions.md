# Start-SCCMActions

Remotely sends a command to kickoff SCCM actions

## Syntax
```powershell
Start-SCCMActions
    [-ComputerName]
```

## Examples

For one machine
```powershell
Start-SCCMActions -ComputerName computer01
```

for multiple machines
```powershell
Start-SCCMActions -ComputerName $Computers.Name
```
