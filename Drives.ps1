$driveMappings = @{
    "L:" = "\\aspit-fil-02.aspit.local\Programvare"
    "M:" = "\\aspit-fil-01.aspit.local\Drift"
    "N:" = "\\aspit-fil-01.aspit.local\Administrasjon"
    "K:" = "\\aspit-com-01.aspit.local\Complete"
    "R:" = "\\aspit-fil-02.aspit.local\Online"
    "S:" = "\\aspit-fil-02.aspit.local\Salg og Support"
    "O:" = "\\aspit-fil-02.aspit.local\Okonomi"
    "P:" = "\\aspit-fil-02.aspit.local\Personal"
    "T:" = "\\aspit-fil-02\Internt"
}

foreach ($drive in $driveMappings.GetEnumerator()) {
    $driveLetter = $drive.Key
    $networkPath = $drive.Value

    $addDrive = Read-Host "Vil du legge til $driveLetter ($networkPath)? (Y/N)"
    if ($addDrive.ToUpper() -eq "Y") {
        if (Test-Path $networkPath) {
            net use $driveLetter $networkPath /PERSISTENT:yes
            Write-Host "Drive $driveLetter lagt til."
        } else {
            Write-Host "Network path $networkPath ble ikke lagt til."
        }
    }
}
