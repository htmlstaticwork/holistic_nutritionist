$files = Get-ChildItem -Path . -Filter *.html

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

foreach ($file in $files) {
    if ($file.Name -in @('index.html', 'home-2.html', 'about.html', 'services.html', 'programs.html', 'blog.html', 'contact.html', 'login.html', 'signup.html')) {
        continue
    }

    $content = [IO.File]::ReadAllText($file.FullName)

    $matchNavMenu = [regex]::Match($content, '(?s)<ul class="nav-menu">(.*?)</ul>')
    if ($matchNavMenu.Success) {
        $innerHtml = $matchNavMenu.Groups[1].Value
        
        $dropdownMatch = [regex]::Match($innerHtml, '(?s)<li class="dropdown">.*?</div>\s*</li>')
        if (-not $dropdownMatch.Success) { continue }
        $dropdown = $dropdownMatch.Value

        $aboutMatch = [regex]::Match($innerHtml, '<li><a href="about\.html" class="nav-link( active)?">About</a></li>')
        $servicesMatch = [regex]::Match($innerHtml, '<li><a href="services\.html" class="nav-link( active)?">Services</a></li>')
        $programsMatch = [regex]::Match($innerHtml, '<li><a href="programs\.html" class="nav-link( active)?">Programs</a></li>')
        $blogMatch = [regex]::Match($innerHtml, '<li><a href="blog\.html" class="nav-link( active)?">Blog</a></li>')
        $dashboardMatch = [regex]::Match($innerHtml, '<li><a href="dashboard\.html" class="nav-link( active)?">Dashboard</a></li>')
        $contactMatch = [regex]::Match($innerHtml, '<li><a href="contact\.html" class="nav-link( active)?">Contact</a></li>')

        $mobileTogglesMatch = [regex]::Match($innerHtml, '(?s)<!-- Mobile Actions -->.*')
        
        if ($aboutMatch.Success -and $servicesMatch.Success -and $programsMatch.Success -and $blogMatch.Success -and $dashboardMatch.Success -and $contactMatch.Success) {
            
            $newInnerHtml = "`r`n                " + $dropdown + "`r`n                " + $aboutMatch.Value + "`r`n                " + $servicesMatch.Value + "`r`n                " + $programsMatch.Value + "`r`n                " + $blogMatch.Value + "`r`n                " + $contactMatch.Value + "`r`n                " + $dashboardMatch.Value + "`r`n                " + $mobileTogglesMatch.Value
            
            $newInnerHtml = $newInnerHtml.TrimEnd() + "`r`n            "
            $content = $content.Replace($innerHtml, $newInnerHtml)
            
            [IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
            Write-Host "Updated $($file.Name)"
        }
    }
}
