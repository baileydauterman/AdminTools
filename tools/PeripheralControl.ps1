enum ClickType {
    Left
    Right
}

class PeripheralControl {
    <# Define the class. Try constructors, properties, or methods. #>
    PeripheralControl() {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace Win;
    }

    [System.__ComObject]$WShell = [System.__ComObject](New-Object -ComObject WScript.Shell)

    [void]SendKeyPress([string]$Keys) {
        $this.WShell.SendKeys($Keys)
    }

    [void]SendMouseClick([ClickType]$ClickType) {
        switch ($ClickType) {
            [ClickType]::Left  { [Win.U32]::mouse_event(6, 0, 0, 0, 0); }
            [ClickType]::Right { [Win.U32]::mouse_event(24, 0, 0, 0, 0); }
        }
    }

    [void]MoveMousePosition([int]$X, [int]$Y) {
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($X, $Y)
    }

    [PSCustomObject]GetMousePosition(){
        return [System.Windows.Forms.Cursor]::Position | Select-Object X, Y
    }
}
