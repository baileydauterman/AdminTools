Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Namespace WinNative -Name User32

# Load functions as .\tools into memory
Get-ChildItem -Path "$PSScriptRoot\tools\" -Filter *.ps1 -Recurse | ForEach-Object { . $_.FullName}
