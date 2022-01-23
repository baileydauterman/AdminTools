# Get-InstalledSoftwareRunspace

Gets the last time a file was written in a directory

## Syntax
```powershell
Get-InstalledSoftwareRunspace
    [[-ComputerName] <string[]>]
```

## Examples

Use a list of computers for this command it is inefficient to run on one machine 
```powershell
Get-InstalledSoftwareRunspace -ComputerName $computers.Name
```