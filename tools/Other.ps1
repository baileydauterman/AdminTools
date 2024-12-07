function Write-File() {
    param(
        [long]
        $Size,
        [string]
        $Path,
        [int]
        $Buffer = 16Mb
    )

    if (Test-Path $Path) {
        [System.IO.File]::Create($Path)
    }

    $fileInfo = [System.IO.FileInfo]::new($Path)
    $stream = $fileInfo.OpenWrite()
    $char = [byte][char]"9"
    $bufferArray = [byte[]]::new($Buffer)
    [array]::Fill($bufferArray, $char)

    while ($Size -gt 0) {
        $stream.Write($bufferArray, 0, $bufferArray.Length)
        $Size -= $Buffer
    }

    $stream.Close()
}

function Max-CPU {
    for ($i = 0; $i -lt 20; $i++) {
        Start-Job -ScriptBlock {
            function fibonacci($n) {
                if ($n -lt 2) {
                    $n
                }
                else {
                    (fibonacci ($n - 1)) + (fibonacci ($n - 2))
                }
            }
            fibonacci([long]::MaxValue)
        }
    }

    $jobs = Get-Job

    while ($jobs | Where-Object Finished -ne $true) {
        Start-Sleep 15
        $jobs = Get-Job
    }
}
