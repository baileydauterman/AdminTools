Add-Type -AssemblyName System.Windows.Forms
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace Win;

function Get-Screens {
    $screens = [System.Windows.Forms.Screen]::AllScreens
    [pscustomobject]@{
        Name   = $screens.DeviceName
        Width  = $screens.Bounds.Width
        Height = $screens.Bounds.Height
    }
}

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

    switch ($ClickType) {
        "Left"  { [Win.U32]::mouse_event(6, 0, 0, 0, 0); }
        "Right" { [Win.U32]::mouse_event(24, 0, 0, 0, 0); }
    }
}

function Send-KeyPress {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Keys,
        [Parameter()]
        [switch]
        $WithShift,
        [Parameter()]
        [switch]
        $WithControl,
        [Parameter()]
        [switch]
        $WithAlt
    )

    $wshell = New-Object -ComObject WScript.Shell
    $prefix = ""

    if ($WithShift) {
        $prefix += "+"
    }

    if ($WithControl) {
        $prefix += "^"
    }

    if ($WithAlt) {
        $prefix += "%"
    }

    Write-Host "$($prefix)$($Keys)"
    $wshell.SendKeys("$($prefix)$($Keys)")
}

function Send-SpecialKeyPress {
    param (
        [Parameter()]
        [ValidateSet("Backspace", "Break", "CapsLock", "Clear", "Delete", "Insert", "LeftArrow", "RightArrow", "UpArrow",
                     "DownArrow", "End", "Enter", "Escape", "Help", "Home", "NumLock", "PageDown", "PageUp", "PrintScreen",
                     "ScrollLock", "Tab", "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","F13","F14","F15",
                     "F16")]
        $SpecialKeys
    )
    
    
    foreach($key in $SpecialKeys) {
        switch ($key) {
            "PageUp"   { $key = "PGUP" }
            "PageDown" { $key = "PGDN" }
            "PrintScreen" { $key = "PRTSC"}
            "LeftArrow" { $key = "LEFT" }
            "RightArrow" { $key = "RIGHT" }
            "UpArrow" { $key = "UP" }
            "DownArrow" { $key = "DOWN" } 
        }

        $key = "{$key}"
        $wshell.SendKeys($key)
    }
}
