# Test-ConnectionRunspace

Remotely sends a command to kickoff SCCM actions

## Syntax
```powershell
Test-ConnectionRunspace
    [-ComputerName]
```

## Examples

For one machine
```powershell
Test-ConnectionRunspace -ComputerName computer01
```

for multiple machines
```powershell
Test-ConnectionRunspace -ComputerName $Computers.Name
```
