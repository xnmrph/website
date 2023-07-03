$apps = @(
    @{name = "Valve.Steam"; displayName = "Steam" }, 
    @{name = "Microsoft.Edge" ; displayName = "Microsoft Edge" },
    @{name = "Microsoft.PowerToys" ; displayName = "Microsoft PowerToys" }, 
    @{name = "CodecGuide.K-LiteCodecPack.Standard" ; displayName = "K-Lite Codec Pack Standard" }, 
    @{name = "Microsoft.VisualStudioCode" ; displayName = "Visual Studio Code" }, 
    @{name = "OBSProject.OBSStudio" ; displayName = "OBS Studio" }, 
    @{name = "Spotify.Spotify" ; displayName = "Spotify" }, 
    @{name = "Discord.Discord" ; displayName = "Discord" }, 
    @{name = "7zip.7zip" ; displayName = "7-Zip" }, 
    @{name = "Elgato.WaveLink"  ; displayName = "Elgato WaveLink" },
    @{name = "Bitwarden.Bitwarden" ; displayName = "Bitwarden" },
    @{name = "Avidemux.Avidemux" ; displayName = "Avidemux" },
    @{name = "RiotGames.Valorant" ; displayName = "Valorant" }
)

# ANSI escape sequences for color
$colorGreen = "`e[32m"
$colorCyan = "`e[36m"
$colorYellow = "`e[33m"
$colorReset = "`e[0m"

Write-Output "${colorCyan}App Installation Script${colorReset}"
Write-Output "Please select which apps to install (enter the corresponding numbers, separated by commas):"

for ($i = 0; $i -lt $apps.Count; $i++) {
    Write-Output "$($colorYellow)$($i+1). $($apps[$i].displayName)${colorReset}"
}

$userInput = Read-Host "Selection:"

$selectedIndices = $userInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }

if ($selectedIndices) {
    $selectedApps = $selectedIndices | ForEach-Object { $apps[$_ - 1] }
    
    Write-Output "${colorGreen}Selected apps for installation:${colorReset}"
    
    foreach ($app in $selectedApps) {
        Write-Output "$($colorGreen)$($app.displayName)${colorReset}"
    }
    
    $installConfirmation = Read-Host "Do you want to proceed with the installation? (Y/N)"
    
    if ($installConfirmation -eq "Y" -or $installConfirmation -eq "y") {
        foreach ($app in $selectedApps) {
            Write-Host "${colorCyan}Installing: $($app.displayName)${colorReset}"
            winget install --exact --silent $app.name --accept-package-agreements
        }
        
        Write-Host "${colorGreen}Installation completed.${colorReset}"
    }
    else {
        Write-Host "${colorYellow}Installation canceled.${colorReset}"
    }
}
else {
    Write-Output "${colorYellow}No valid selection entered. Installation canceled.${colorReset}"
}
