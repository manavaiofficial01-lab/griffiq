$sourcePath = 'd:\Project\SAM - P\ambiguous-posterity-545330.framer.app\skills.html'
$targetPath = 'd:\Project\SAM - P\recreate framer into griffiq\skills.html'

$targetContent = [System.IO.File]::ReadAllText($targetPath)
$startTag = '<!-- Start of bodyEnd -->'
$endTag = '<!-- End of bodyEnd -->'

$startIdx = $targetContent.IndexOf($startTag)
$endIdx = $targetContent.IndexOf($endTag)

if ($startIdx -eq -1 -or $endIdx -eq -1) {
    Write-Error "Error: Could not find bodyEnd comments in target file."
    exit 1
}

$customBlock = $targetContent.Substring($startIdx + $startTag.Length, $endIdx - ($startIdx + $startTag.Length))

$sourceContent = [System.IO.File]::ReadAllText($sourcePath)

# Find the injection point: right before </body>
$bodyEndTag = '</body>'
$bodyEndIdx = $sourceContent.LastIndexOf($bodyEndTag)

if ($bodyEndIdx -eq -1) {
    Write-Error "Error: Could not find </body> in source file."
    exit 1
}

$newContent = $sourceContent.Substring(0, $bodyEndIdx) +
              $startTag +
              $customBlock +
              $endTag + "`n" +
              $sourceContent.Substring($bodyEndIdx)

[System.IO.File]::WriteAllText($targetPath, $newContent, [System.Text.Encoding]::UTF8)
Write-Output "Successfully merged skills.html using local PowerShell script!"
