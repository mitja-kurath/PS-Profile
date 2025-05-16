function ConvertTo-UnixPath ($windowsPath) {
    $unixPath = $windowsPath.Replace('\', '/')
    if ($unixPath -match "^([A-Za-z]):/(.*)") {
        $driveLetter = $Matches[1].ToLower()
        $remainingPath = $Matches[2]
        return "/$driveLetter/$remainingPath"
    }
    return $unixPath
}

function prompt {
    $currentLocation = Get-Location
    $displayPath = ""

    if ($currentLocation.Provider.Name -eq "FileSystem") {
        $path = $currentLocation.Path
        $displayPath = ConvertTo-UnixPath $path
    } else {
        $providerName = $currentLocation.Provider.Name
        $providerPath = $currentLocation.ProviderPath
        $displayPath = "$($providerName)::$($providerPath)"
    }

    Write-Host ""

    Write-Host $displayPath -ForegroundColor Green

    $timeString = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timeString] " -ForegroundColor Green -NoNewline
    Write-Host "> " -ForegroundColor Green -NoNewline

    return " "
}
