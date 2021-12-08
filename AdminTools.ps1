# Load functions as .\tools into memory
Get-ChildItem -Path "$PSScriptRoot\tools\" -Filter *.ps1 -Recurse | ForEach-Object { . $_.FullName}