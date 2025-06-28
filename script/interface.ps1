# interface.ps1
# User interface functions

function Set-ConsoleSettings {
    $host.UI.RawUI.WindowTitle = "Make Windows Gr8 Again"
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(100,40)
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(100,2000)
    Clear-Host
}

function Show-MainMenu {
    do {
        Clear-Host
        Write-Host "======================================================================================================="
        Write-Host "    Make-Windows-Gr8-Again : Main Menu"
        Write-Host "=======================================================================================================`n"
        
        Write-Host "System Configuration:"
        Write-Host "    1. Core System Tweaks"
        Write-Host "    2. Security & Privacy"
        Write-Host "    3. .NET & Runtime Components"
        Write-Host "    4. Driver & Hardware Support`n"
        
        Write-Host "Software Installation:"
        Write-Host "    5. Essential Utilities"
        Write-Host "    6. Media & Productivity"
        Write-Host "    7. Internet & Networking"
        Write-Host "    8. Development Tools`n"
        
        $selection = Read-Host "Selection (1-8, X=Exit)"
        switch ($selection) {
            '1' { Show-SubMenu -Category "CoreSystem" }
            '2' { Show-SubMenu -Category "Security" }
            '3' { Show-SubMenu -Category "DotNet" }
            '4' { Show-SubMenu -Category "Drivers" }
            '5' { Show-SubMenu -Category "Utilities" }
            '6' { Show-SubMenu -Category "Media" }
            '7' { Show-SubMenu -Category "Internet" }
            '8' { Show-SubMenu -Category "Development" }
            'x' { return }
            default { Write-Host "Invalid selection" -ForegroundColor Red; Start-Sleep -Seconds 1 }
        }
    } while ($selection -ne 'x')
}

function Show-SubMenu {
    param($Category)
    
    do {
        Clear-Host
        Write-Host "======================================================================================================="
        Write-Host "    Make-Windows-Gr8-Again : $($Global:Categories[$Category].Name)"
        Write-Host "=======================================================================================================`n"
        
        $index = 1
        foreach ($item in $Global:Categories[$Category].Options) {
            $status = if ($Global:InstallState["$Category-$($index-1)"]) { " (done)" } else { "" }
            Write-Host "    $index. $($item.Name)$status"
            $index++
        }
        Write-Host "`n    B. Back to Main Menu`n"
        
        $choice = Read-Host "Select options (comma separated) or B to go back"
        if ($choice -eq 'b') { return }
        
        if ($choice -match '^[\d, ]+$') {
            $selections = $choice -split ',' | ForEach-Object { [int]::Parse($_.Trim()) }
            Install-Selections -Category $Category -Selections $selections
        }
        else {
            Write-Host "Invalid input" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    } while ($true)
}