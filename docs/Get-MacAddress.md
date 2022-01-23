# Get-MacAddress

Gets the mac address of local or remote machine.

## Syntax
```
Get-MacAddress
    [[-ComputerName] <string[]>]
```

## Examples

for local machine
```
Get-MacAddress
```

for remote machine
```
Get-MacAddress -ComputerName computer01
```

for remote machines
```
Get-MacAddress -ComputerName $computers.Name
```