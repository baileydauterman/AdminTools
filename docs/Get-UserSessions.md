# Get-UserSessions

Gets the user sessions on a remote machine

## Syntax
```powershell
Get-UserSessions
    [[-ComputerName] <string[]>]
```

## Examples

for local machine
```powershell
Get-UserSessions
```

for remote machine
```powershell
Get-UserSessions -ComputerName computer01
```

for remote machines
```powershell
Get-UserSessions -ComputerName $computers.Name
```