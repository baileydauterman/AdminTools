Add-Type -AssemblyName System.Windows.Forms

function Get-MousePosition {
    [System.Windows.Forms.Cursor]::Position | Select-Object X, Y
}

function Move-MousePosition {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]
        $X,
        [Parameter(Mandatory)]
        [int]
        $Y
    )
    
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($X, $Y)
}

function Send-MouseClick {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet("Left", "Right")]
        $ClickType
    )

    Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace Win;

    switch ($ClickType) {
        "Left"  { [Win.U32]::mouse_event(6, 0, 0, 0, 0); }
        "Right" { [Win.U32]::mouse_event(24, 0, 0, 0, 0); }
    }
}

function Send-KeyPress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Keys
    )

    $wshell = New-Object -ComObject WScript.Shell
    $wshell.SendKeys($Keys)
}
