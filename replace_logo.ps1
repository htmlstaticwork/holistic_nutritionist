$files = Get-ChildItem -Path . -Filter *.html -Recurse
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

$count = 0
foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName)
    $original = $content
    
    # 24x24 replacement for nav and footer
    $content = [regex]::Replace($content, '(?s)<img[^>]*src="assets/images/favicon\.svg"[^>]*width:\s*24px[^>]*>', '<i class="fas fa-spa text-primary" style="font-size: 1.4rem; vertical-align: middle; margin-right: 0.3rem;"></i>')
    
    # 40x40 replacement for login and signup
    $content = [regex]::Replace($content, '(?s)<img[^>]*src="assets/images/favicon\.svg"[^>]*width:\s*40px[^>]*>', '<i class="fas fa-spa text-primary" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>')
    
    if ($content -ne $original) {
        [IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
        $count++
    }
}
Write-Host "Total updated: $count"
