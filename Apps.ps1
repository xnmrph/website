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

Write-Output "App Installation Script"
Write-Output "Please select which apps to install (enter the corresponding numbers, separated by commas):"

for ($i = 0; $i -lt $apps.Count; $i++) {
    Write-Output "$($i+1). $($apps[$i].displayName)"
}

$userInput = Read-Host "Selection:"

$selectedIndices = $userInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }

if ($selectedIndices) {
    $selectedApps = $selectedIndices | ForEach-Object { $apps[$_ - 1] }
    
    Write-Output "Selected apps for installation:"
    
    foreach ($app in $selectedApps) {
        Write-Output $app.displayName
    }
    
    $installConfirmation = Read-Host "Do you want to proceed with the installation? (Y/N)"
    
    if ($installConfirmation -eq "Y" -or $installConfirmation -eq "y") {
        foreach ($app in $selectedApps) {
            Write-Host "Installing: $($app.displayName)"
            winget install --exact --silent $app.name --accept-package-agreements
        }
        
        Write-Host "Installation completed."
    }
    else {
        Write-Host "Installation canceled."
    }
}
else {
    Write-Output "No valid selection entered. Installation canceled."
}
