function Test-ServerReboot([Parameter(Mandatory=$true)]$ServerName) {
    Write-Host "[!] Testing $ServerName (Ctrl+C to exit)" -ForegroundColor Yellow

    if([bool](Test-WSMan -ComputerName $ServerName -ErrorAction SilentlyContinue)) {
        Write-Host "[+] $ServerName is fully online" -ForegroundColor Green
    } else {
        Write-Host "[-] $ServerName is not back online yet" -ForegroundColor Red
    }

    Start-Sleep 5
}
