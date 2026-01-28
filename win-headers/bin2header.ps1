param(
    [Parameter(Mandatory=$true)][string]$InputFile,
    [Parameter(Mandatory=$true)][string]$OutputFile,
    [Parameter(Mandatory=$true)][string]$ArrayName
)

$bytes = [System.IO.File]::ReadAllBytes($InputFile)
$count = $bytes.Length

$sb = [System.Text.StringBuilder]::new()
[void]$sb.AppendLine("/* Auto-generated from $InputFile */")
[void]$sb.AppendLine("#ifndef MAGIC_EMBEDDED_H")
[void]$sb.AppendLine("#define MAGIC_EMBEDDED_H")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("static const unsigned char ${ArrayName}[] = {")

for ($i = 0; $i -lt $count; $i += 16) {
    $line = "    "
    $end = [Math]::Min($i + 16, $count)
    for ($j = $i; $j -lt $end; $j++) {
        $line += "0x{0:x2}" -f $bytes[$j]
        if ($j -lt $count - 1) {
            $line += ", "
        }
    }
    [void]$sb.AppendLine($line)
}

[void]$sb.AppendLine("};")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("static const size_t ${ArrayName}_size = $count;")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("#endif /* MAGIC_EMBEDDED_H */")

[System.IO.File]::WriteAllText($OutputFile, $sb.ToString())
Write-Host "Generated $OutputFile with $count bytes"
