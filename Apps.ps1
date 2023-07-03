Write-Output "Installing Apps"
$apps = @(
    @{name = "Valve.Steam" }, 
    @{name = "Microsoft.Edge.Dev" },
    @{name = "CodecGuide.K-LiteCodecPack.Standard" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "OBSProject.OBSStudio.Pre-release" }, 
    @{name = "Spotify.Spotify" }, 
    @{name = "Discord.Discord" }, 
    @{name = "7zip.7zip" }, 
    @{name = "Elgato.WaveLink"  },
    @{name = "Avidemux.Avidemux" },
    @{name = "RiotGames.Valorant.EU" }
)

$selectedApps = Show-Command -Name "Select Apps to Install" -ParameterName "apps" -InputObject $apps | Out-GridView -PassThru

Foreach ($app in $selectedApps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-Host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --silent $app.name --source $app.source --accept-package-agreements
        }
        else {
            winget install --exact --silent $app.name --accept-package-agreements
        }
    }
    else {
        Write-Host "Skipping Install of " $app.name
    }
}
