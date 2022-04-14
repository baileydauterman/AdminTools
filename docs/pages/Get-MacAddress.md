# Get-MacAddress

Gets the mac address of local or remote machine.

## Syntax
```powershell
Get-MacAddress
    [[-ComputerName] <string[]>]
```

## Examples

for local machine
```powershell
Get-MacAddress
```

for remote machine
```powershell
Get-MacAddress -ComputerName computer01
```

for remote machines
```powershell
Get-MacAddress -ComputerName $computers.Name
```