Write-Output "Installing Apps"
$apps = @(
    @{name = "Valve.Steam" }, 
    @{name = "Microsoft.Edge.Dev" },
    @{name = "Microsoft.PowerToys --source winget" }, 
    @{name = "CodecGuide.K-LiteCodecPack.Standard" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "OBSProject.OBSStudio.Pre-release" }, 
    @{name = "Spotify.Spotify" }, 
    @{name = "Discord.Discord" }, 
    @{name = "7zip.7zip" }, 
    @{name = "Elgato.WaveLink"  },
    @{name = "Bitwarden.Bitwarden" },
    @{name = "Avidemux.Avidemux" },
    @{name = "RiotGames.Valorant.EU" }
)

Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if (![String]::Join("", $listApp).Contains($app.name)) {
        $install = Read-Host "Do you want to install $($app.name)? (Y/N)"
        if ($install -eq "Y" -or $install -eq "y") {
            Write-Host "Installing: $($app.name)"
            if ($app.source -ne $null) {
                winget install --exact --silent $app.name --source $app.source --accept-package-agreements
            }
            else {
                winget install --exact --silent $app.name --accept-package-agreements
            }
        }
        else {
            Write-Host "Skipping Install of $($app.name)"
        }
    }
    else {
        Write-Host "Skipping Install of $($app.name)"
    }
}
