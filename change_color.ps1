$htmlFiles = Get-ChildItem -Path . -Filter *.html -Recurse
$cssFiles = Get-ChildItem -Path .\assets\css -Filter *.css -Recurse
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "404.html") { continue }
    
    $content = [IO.File]::ReadAllText($file.FullName)
    $original = $content
    
    $content = $content.Replace("text-accent", "text-primary")
    $content = $content.Replace("bg-accent", "bg-primary")
    $content = $content.Replace("btn-accent", "btn-primary")
    $content = $content.Replace("rgba(245, 158, 11,", "rgba(77, 124, 15,")
    $content = $content.Replace("rgba(251, 191, 36,", "rgba(106, 153, 34,")
    
    if ($content -ne $original) {
        [IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}

foreach ($file in $cssFiles) {
    $content = [IO.File]::ReadAllText($file.FullName)
    $original = $content
    
    $content = $content.Replace("--clr-accent: #F59E0B;", "--clr-accent: #4D7C0F;")
    $content = $content.Replace("--clr-accent-light: #FBBF24;", "--clr-accent-light: #6A9922;")
    $content = $content.Replace("--clr-accent: #FBBF24;", "--clr-accent: #6A9922;")
    
    if ($content -ne $original) {
        [IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated CSS $($file.Name)"
    }
}
Write-Host "Done"
