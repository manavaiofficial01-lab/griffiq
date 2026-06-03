$c = [System.IO.File]::ReadAllText("d:\Project\SAM - P\recreate framer into griffiq\index.html")
Write-Output "Total length of index.html: $($c.Length) characters"

Write-Output "`nUnique Framer image URLs found:"
$matches_urls = [regex]::Matches($c, "https://framerusercontent\.com/images/[a-zA-Z0-9_-]+\.(?:png|jpg|jpeg|svg|webp)")
$urls = foreach ($m in $matches_urls) { $m.Value }
$urls | Sort-Object -Unique | Write-Output

Write-Output "`nOccurrences of 'zyvia':"
$matches_zyvia = [regex]::Matches($c, "(?i)zyvia")
$count = 0
foreach ($m in $matches_zyvia) {
    $count++
    $pos = $m.Index
    $start = [Math]::Max(0, $pos - 100)
    $len = [Math]::Min($c.Length - $start, 200)
    $snippet = $c.Substring($start, $len).Replace("`n", " ").Replace("`r", " ")
    Write-Output "Match $count at position $($pos): ... $snippet ..."
}
