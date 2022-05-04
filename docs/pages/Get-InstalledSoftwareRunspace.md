# Get-InstalledSoftwareRunspace

Gets multiple computers installed software

## Syntax
```powershell
Get-InstalledSoftwareRunspace
    [[-ComputerName] <string[]>]
```

## Examples

Best if used on a list of machines, for a single machine look at [Get-InstalledSoftware](Get-InstalledSoftware.md)
```powershell
$computers = Import-Csv .\computers.csv
Get-InstalledSoftwareRunspace -ComputerName $computers.Name
```