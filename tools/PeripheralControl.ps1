enum ClickType {
    Left
    Right
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace Win;

class PeripheralControl {
    [System.__ComObject]$WShell = [System.__ComObject](New-Object -ComObject WScript.Shell)

    <#
    Send a key or a string of multiple keys to be sent to the os
    #>
    [void]SendKeyPress([string]$Keys) {
        $this.WShell.SendKeys($Keys)
    }

    <#
    Send a mouse click event. Left or Right based on ClickType enum
    #>
    [void]SendMouseClick([ClickType]$ClickType) {
        switch ($ClickType) {
            [ClickType]::Left  { [Win.U32]::mouse_event(6, 0, 0, 0, 0); }
            [ClickType]::Right { [Win.U32]::mouse_event(24, 0, 0, 0, 0); }
        }
    }

    <#
    Move mouse to an X, Y coordinate
    #>
    [void]MoveMousePosition([int]$X, [int]$Y) {
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($X, $Y)
    }

    <#
    Get current X,Y coordinate of the mouse
    #>
    [PSCustomObject]GetMousePosition(){
        return [System.Windows.Forms.Cursor]::Position | Select-Object X, Y
    }
}
