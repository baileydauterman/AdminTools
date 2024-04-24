# Invoke-PingSweep

Sends a mass ping sweep across a specified subnet

## Syntax
```powershell
Invoke-PingSweep
    [-Start]
    [-Stop]
    [-AddMembers]
```

## Examples

Returns path stats for C:\
```powershell
Invoke-PingSweep -Start 192.168.1.0 -Stop 192.168.1.255
```

Ping sweep 192.168.1.0/24 and add null members to the output object of TrackingInfo and Uptime
```powershell
Invoke-PingSweep -Start 192.168.1.0 -Stop 192.168.1.255 -AddMembers @(TrackingInfo, Uptime)
```
