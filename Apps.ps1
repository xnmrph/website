Add-Type -TypeDefinition @"
using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

public class AppInstaller : Window
{
    private List<string> selectedApps = new List<string>();

    public AppInstaller()
    {
        Title = "Select Apps to Install";
        Width = 300;
        Height = 400;
        ResizeMode = ResizeMode.NoResize;
        WindowStartupLocation = WindowStartupLocation.CenterScreen;

        StackPanel stackPanel = new StackPanel();

        foreach (var app in Apps)
        {
            CheckBox checkBox = new CheckBox();
            checkBox.Content = app;
            checkBox.IsChecked = false;
            checkBox.Foreground = Brushes.Black;
            checkBox.Margin = new Thickness(10);
            checkBox.Checked += CheckBox_Checked;
            checkBox.Unchecked += CheckBox_Unchecked;

            stackPanel.Children.Add(checkBox);
        }

        Button installButton = new Button();
        installButton.Content = "Install Selected Apps";
        installButton.Margin = new Thickness(10);
        installButton.Click += InstallButton_Click;

        stackPanel.Children.Add(installButton);

        Content = stackPanel;
    }

    public List<string> SelectedApps
    {
        get { return selectedApps; }
    }

    private void CheckBox_Checked(object sender, RoutedEventArgs e)
    {
        CheckBox checkBox = (CheckBox)sender;
        selectedApps.Add(checkBox.Content.ToString());
    }

    private void CheckBox_Unchecked(object sender, RoutedEventArgs e)
    {
        CheckBox checkBox = (CheckBox)sender;
        selectedApps.Remove(checkBox.Content.ToString());
    }

    private void InstallButton_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = true;
    }
}

public class MessageBoxHelper
{
    public static MessageBoxResult Show(string message, string caption, MessageBoxButton buttons, MessageBoxImage icon)
    {
        return MessageBox.Show(message, caption, buttons, icon);
    }
}
"@

$apps = @(
    "Valve.Steam", 
    "Microsoft.Edge.Dev",
    "CodecGuide.K-LiteCodecPack.Standard", 
    "Microsoft.VisualStudioCode", 
    "OBSProject.OBSStudio.Pre-release", 
    "Spotify.Spotify", 
    "Discord.Discord", 
    "7zip.7zip", 
    "Elgato.WaveLink",
    "Avidemux.Avidemux",
    "RiotGames.Valorant.EU"
)

Write-Output "Installing Apps"

$appInstaller = New-Object AppInstaller
$appInstaller.Apps = $apps

$result = $appInstaller.ShowDialog()

if ($result -eq $true)
{
    foreach ($app in $appInstaller.SelectedApps)
    {
        $listApp = winget list --exact -q $app --accept-source-agreements 
        if (![String]::Join("", $listApp).Contains($app))
        {
            $message = "Do you want to install $app?"
            $result = [MessageBoxHelper]::Show($message, "App Installation", [MessageBoxButton]::YesNo, [MessageBoxImage]::Question)

            if ($result -eq "Yes")
            {
                Write-Host "Installing: $app"
                winget install --exact --silent $app --accept-package-agreements
            }
        }
        else
        {
            Write-Host "Skipping Install of $app"
        }
    }
}
