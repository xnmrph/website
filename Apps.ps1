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
    @{name = "Eugeny.Tabby" ; displayName = "Tabby" },
    @(name = "ThaUnknown.Miru" ; displayName = "Miru-Anime"),
    @{name = "FACEITLTD.FACEITAC" ; displayName = "FACEIT AC" },
    @{name = "RiotGames.Valorant" ; displayName = "Valorant" }
)

function Write-ColorText {
    param(
        [Parameter(Mandatory = $true)]
        [String]$Text,

        [ConsoleColor]$Color = "White"
    )
    $originalColor = $host.UI.RawUI.ForegroundColor
    Write-Host $Text -ForegroundColor $Color
    $host.UI.RawUI.ForegroundColor = $originalColor
}

function Write-ColorLine {
    param(
        [Parameter(Mandatory = $true)]
        [String]$Text,

        [ConsoleColor]$Color = "White"
    )
    Write-ColorText $Text $Color
    Write-Host
}

Write-ColorLine "App Installation Script" -Color "Yellow"
Write-ColorText "Please select which apps to install (enter the corresponding numbers, separated by commas):" -Color "Cyan"
Write-ColorText "0. Install all apps" -Color "Cyan"
Write-Host

for ($i = 0; $i -lt $apps.Count; $i++) {
    Write-ColorText ("{0}. {1}" -f ($i+1), $apps[$i].displayName) -Color "Yellow"
}

$userInput = Read-Host "Selection"

$selectedIndices = $userInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }

if ($selectedIndices) {
    if ($selectedIndices -contains "0") {
        $selectedApps = $apps
        Write-ColorLine "Selected all apps for installation." -Color "Green"
    }
    else {
        $selectedApps = $selectedIndices | ForEach-Object { $apps[$_ - 1] }
        Write-ColorLine "Selected apps for installation:" -Color "Green"
    }
    
    foreach ($app in $selectedApps) {
        Write-ColorText $app.displayName -Color "Yellow"
    }
    
    $installConfirmation = Read-Host "Do you want to proceed with the installation? (Y/N)"
    
    if ($installConfirmation -eq "Y" -or $installConfirmation -eq "y") {
        foreach ($app in $selectedApps) {
            Write-ColorText ("Installing: {0}" -f $app.displayName) -Color "Green"
            winget install --exact --silent $app.name --accept-package-agreements
        }
        
        Write-ColorLine "Installation completed." -Color "Green"
    }
    else {
        Write-ColorLine "Installation canceled." -Color "Red"
    }
}
else {
    Write-ColorLine "No valid selection entered. Installation canceled." -Color "Red"
}
