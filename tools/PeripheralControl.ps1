enum ClickType {
    Left
    Right
}

class PeripheralControl {
    PeripheralControl() {
        Add-Type -AssemblyName System.Windows.Forms
        $this.MouseEvent = [WinNative.User32](New-Object -TypeName W.U32)
    }

    [WinNative.User32]$MouseEvent
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
            [ClickType]::Left  { $this.MouseEvent::mouse_event(6, 0, 0, 0, 0); }
            [ClickType]::Right { $this.MouseEvent::mouse_event(24, 0, 0, 0, 0); }
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
