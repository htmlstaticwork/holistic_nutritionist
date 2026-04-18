$files = Get-ChildItem -Path . -Filter *.html -Recurse
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

$count = 0
foreach ($file in $files) {
    if ($file.Name -eq "404.html") { continue }
    
    $content = [IO.File]::ReadAllText($file.FullName)
    $original = $content
    
    # Replace inline padding for standard subpage headers
    $content = $content -replace 'padding:\s*150px\s+0\s+80px;', 'padding: 130px 0 50px;'
    
    # Wait, some might just be '150px 0 80px' without the semicolon or different spaces
    $content = [regex]::Replace($content, 'padding:\s*150px\s+0\s+80px', 'padding: 130px 0 50px')
    
    # In index.html the main hero section might have a different padding
    # Let's adjust common massive margins like margin-bottom: 5rem; or 4rem; to uniform sizes?
    # Usually standardizing sections is enough.
    
    if ($content -ne $original) {
        [IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
        $count++
    }
}
Write-Host "Total updated: $count"
