# Get-InstalledSoftwareRunspace

Gets the last time a file was written in a directory

## Syntax
```powershell
Get-InstalledSoftwareRunspace
    [[-ComputerName] <string[]>]
```

## Examples

Best if used on a list of machines, for a single machine look at [Get-InstalledSoftware](/docs/Get-InstalledSoftware.md)
```powershell
$computers = Import-Csv .\computers.csv
Get-InstalledSoftwareRunspace -ComputerName $computers.Name
```