# Start-SCCMActions

Remotely sends a command to kickoff SCCM actions

## Syntax
```
Start-SCCMActions
    [-ComputerName]
```

## Examples

For one machine
```
Start-SCCMActions -ComputerName computer01
```

for multiple machines
```
Start-SCCMActions -ComputerName $Computers.Name
```
