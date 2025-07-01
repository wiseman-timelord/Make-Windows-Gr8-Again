# Script: `.\scripts\temporary.ps1`
# Initialize installation state
$Global:InstallState = @{}

$Global:Categories = @{
    CoreSystem = @{
        Name = "Core System Tweaks"
        Options = @(
            @{
                Name = "StartIsBack + Boot Menu"
                Commands = @(
                    '$url = "https://www.startisback.com/StartIsBack_setup.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "StartIsBack.exe"'
                    'Start-Process $path -ArgumentList "/silent /install" -Wait'
                    '$Global:InstallState["CoreSystem-0"] = $true'
                )
            },
            @{
                Name = "Context Menu Hacks + TeraCopy"
                Commands = @(
                    '# Apply context menu registry tweaks'
                    '$contextReg = @"'
'Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\runas]
@="Open cmd here as admin"
"Icon"="cmd.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\runas\command]
@="cmd.exe /s /k pushd \"%V\""

[HKEY_CLASSES_ROOT\Directory\Background\shell\runaspowershell]
@="Open PowerShell here as admin"
"Icon"="powershell.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\runaspowershell\command]
@="powershell.exe -NoExit -Command \"Set-Location -LiteralPath \\\"%V\\\"\""

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
@="Take Ownership"
"Icon"="imageres.dll,-5302"

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
@="cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t"
"@'
                    '$tempPath = [System.IO.Path]::GetTempFileName()'
                    'Set-Content $tempPath $contextReg'
                    'reg import $tempPath'
                    'Remove-Item $tempPath'
                    
                    '$url = "https://www.codesector.com/files/teracopy.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "teracopy.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["CoreSystem-1"] = $true'
                )
            },
            @{
                Name = "Install Classic Grey Theme"
                Commands = @(
                    '$themeFile = "Classic-GreyRoyale_003c.theme"'
                    '$sourcePath = ".\data\$themeFile"'
                    '$destDir = Join-Path $env:windir "Resources\Themes"'
                    '$destPath = Join-Path $destDir $themeFile'
                    
                    '# Create themes directory if needed'
                    'if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }'
                    
                    '# Copy theme file'
                    'Copy-Item $sourcePath $destPath -Force'
                    
                    '# Set as current theme'
                    'Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes" "CurrentTheme" "$themeFile"'
                    '$Global:InstallState["CoreSystem-2"] = $true'
                )
            },
            @{
                Name = "Disable Aero + Apply Theme"
                Commands = @(
                    '# Apply theme and disable Aero'
                    'Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes" "CurrentTheme" "Classic-GreyRoyale_003c.theme"'
                    'Set-ItemProperty "HKCU:\Software\Microsoft\Windows\DWM" "Composition" 0'
                    'Set-ItemProperty "HKCU:\Software\Microsoft\Windows\DWM" "ColorizationColor" 0xFF6B6B6B'
                    'Stop-Process -Name explorer -Force'
                    '$Global:InstallState["CoreSystem-3"] = $true'
                )
            },
            @{
                Name = "WiseMan-TimeLords Gaming Tweaks"
                Commands = @(
                    '# Detect OS version',
                    '$osInfo = Get-CimInstance Win32_OperatingSystem',
                    '$isServer = Test-IsServer',
                    '$osName = $osInfo.Caption',
                    'Write-Host "Detected OS: $osName"',
                    'Start-Sleep -Seconds 1',
                    '',
                    '# 1. Enable Required Features',
                    'if ($isServer) {',
                    '    Write-Host "Installing Desktop Experience feature..."',
                    '    try {',
                    '        Install-WindowsFeature Desktop-Experience -IncludeManagementTools -ErrorAction Stop',
                    '        Write-Host "  [SUCCESS] Desktop Experience installed" -ForegroundColor Green',
                    '    } catch {',
                    '        Write-Host "  [ERROR] Failed to install Desktop Experience: $_" -ForegroundColor Red',
                    '        $success = $false',
                    '    }',
                    '    Start-Sleep -Seconds 1',
                    '} else {',
                    '    Write-Host "Desktop Experience not required on client OS"',
                    '}',
                    '',
                    '# 2. Configure Windows Audio Service',
                    'Write-Host "Configuring Windows Audio Service..."',
                    'try {',
                    '    $audioService = Get-Service -Name Audiosrv -ErrorAction Stop',
                    '    if ($audioService.StartType -ne "Automatic") {',
                    '        Set-Service -Name Audiosrv -StartupType Automatic -ErrorAction Stop',
                    '    }',
                    '    if ($audioService.Status -ne "Running") {',
                    '        Start-Service Audiosrv -ErrorAction Stop',
                    '    }',
                    '    Write-Host "  [SUCCESS] Windows Audio Service configured" -ForegroundColor Green',
                    '} catch {',
                    '    Write-Host "  [ERROR] Failed to configure audio service: $_" -ForegroundColor Red',
                    '    $success = $false',
                    '}',
                    'Start-Sleep -Seconds 1',
                    '',
                    '# 3. Configure other gaming services',
                    'Write-Host "Configuring gaming services..."',
                    'try {',
                    '    # Correct service names for Windows 8/2012',
                    '    $servicesToEnable = @(''Audiosrv'', ''PlugPlay'', ''MMCSS'')',
                    '    $serviceDisplayNames = @{',
                    '        Audiosrv = "Windows Audio"',
                    '        PlugPlay = "Plug and Play"',
                    '        MMCSS = "Multimedia Class Scheduler"',
                    '    }',
                    '',
                    '    foreach ($service in $servicesToEnable) {',
                    '        $svc = Get-Service -Name $service -ErrorAction SilentlyContinue',
                    '        if ($svc) {',
                    '            if ($svc.StartType -ne "Automatic") {',
                    '                Set-Service -Name $service -StartupType Automatic -ErrorAction Stop',
                    '                Write-Host "  [OK] Set $($serviceDisplayNames[$service]) to Automatic"',
                    '            }',
                    '        } else {',
                    '            Write-Host "  [WARNING] Service $service not found" -ForegroundColor Yellow',
                    '        }',
                    '    }',
                    '',
                    '    # Disable Windows Search if on server',
                    '    if ($isServer) {',
                    '        $searchService = "WSearch"',
                    '        if (Get-Service -Name $searchService -ErrorAction SilentlyContinue) {',
                    '            Set-Service -Name $searchService -StartupType Disabled',
                    '            Stop-Service -Name $searchService -Force -ErrorAction SilentlyContinue',
                    '            Write-Host "  [OK] Disabled Windows Search service"',
                    '        }',
                    '    }',
                    '    Write-Host "  [SUCCESS] Service configuration complete" -ForegroundColor Green',
                    '} catch {',
                    '    Write-Host "  [ERROR] Failed to configure services: $_" -ForegroundColor Red',
                    '    $success = $false',
                    '}',
                    'Start-Sleep -Seconds 1',
                    '',
                    '# Completion message',
                    'Write-Host "`nGaming tweaks complete!" -ForegroundColor Cyan',
                    'Write-Host "For best results, please restart your computer." -ForegroundColor Yellow',
                    'Read-Host "Press Enter to return to menu"',
                    '$Global:InstallState["CoreSystem-4"] = $true'
                )
            }
        )
    }
    Security = @{
        Name = "Security & Privacy"
        Options = @(
            @{
                Name = "XP-AntiSpy + Privacy Tweaker"
                Commands = @(
                    '$url = "https://m.majorgeeks.com/files/details/xp_antispy.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "xp_antispy.exe"'
                    'Start-Process $path /VERYSILENT'
                    '$Global:InstallState["Security-0"] = $true'
                )
            },
            @{
                Name = "Enable TLS 1.2 Protocol"
                Commands = @(
                    '$tlsReg = @"'
'Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]
"DisabledByDefault"=dword:00000000
"Enabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server]
"DisabledByDefault"=dword:00000000
"Enabled"=dword:00000001
"@'
                    '$tempPath = [System.IO.Path]::GetTempFileName()'
                    'Set-Content $tempPath $tlsReg'
                    'reg import $tempPath'
                    'Remove-Item $tempPath'
                    '$Global:InstallState["Security-1"] = $true'
                )
            },
            @{
                Name = "Remove Defender + SmartScreen"
                Commands = @(
                    'Dism /online /Disable-Feature /FeatureName:Windows-Defender /NoRestart'
                    'Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "SmartScreenEnabled" "Off"'
                    '$Global:InstallState["Security-2"] = $true'
                )
            }
        )
    }
    DotNet = @{
        Name = ".NET & Runtimes"
        Options = @(
            @{
                Name = ".NET 3.5 (from Media)"
                Commands = @(
                    'Dism /online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:D:\sources\sxs'
                    '$Global:InstallState["DotNet-0"] = $true'
                )
            },
            @{
                Name = ".NET 4.8 + VC Runtimes"
                Commands = @(
                    '$url = "https://download.microsoft.com/download/9/E/6/9E63300C-0941-4B45-A0EC-0008F96DD480/NDP48-x86-x64-AllOS-ENU.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "dotnet48.exe"'
                    'Start-Process $path /q /norestart'
                    '$vcRedists = @(2008,2010,2012,2013,2015,2017,2019,2022)'
                    'foreach ($ver in $vcRedists) {'
                    '    $url = "https://aka.ms/vs/16/release/vc_redist.x64.exe"'
                    '    $path = Invoke-SafeDownload -Url $url -FileName "vc_$ver.exe"'
                    '    Start-Process $path /install /quiet /norestart'
                    '}'
                    '$Global:InstallState["DotNet-1"] = $true'
                )
            }
        )
    }
    Drivers = @{
        Name = "Driver & Hardware"
        Options = @(
            @{
                Name = "Enable Testing Mode + DriverBooster"
                Commands = @(
                    '# Enable testing mode'
                    'bcdedit /set testsigning on'
                    'Write-Host "  [OK] Testing mode enabled" -ForegroundColor Green'
                    ''
                    '# Verify testing mode'
                    '$testMode = (bcdedit | Select-String "testsigning" | Out-String).Trim()'
                    'if ($testMode -match "Yes") {'
                    '    Write-Host "  [SUCCESS] Testing mode verified" -ForegroundColor Green'
                    '} else {'
                    '    Write-Host "  [WARNING] Testing mode not active - reboot required" -ForegroundColor Yellow'
                    '}'
                    ''
                    '# Check for Server 2012'
                    'if (Test-IsServer2012) {'
                    '    Write-Host "  [INFO] DriverBooster does not work with Server 2012 - skipping installation" -ForegroundColor Cyan'
                    '    $success = $true'
                    '}'
                    'else {'
                    '    # Download DriverBooster with progress display'
                    '    $url = "https://delivery2.filecroco.com/kits_6/driver_booster_setup.exe"'
                    '    $fileName = "driverbooster.exe"'
                    '    $tempPath = Get-TempPath'
                    '    $filePath = Join-Path $tempPath $fileName'
                    ''
                    '    # Force TLS 1.2 for secure download'
                    '    try {'
                    '        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12'
                    '    } catch {'
                    '        Write-Host "  [WARNING] Failed to set TLS 1.2: $_" -ForegroundColor Yellow'
                    '    }'
                    ''
                    '    try {'
                    '        Write-Host "Downloading $fileName... " -NoNewline'
                    '        $webClient = New-Object System.Net.WebClient'
                    ''
                    '        # Add progress tracker'
                    '        $event = Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -Action {'
                    '            $progress = $eventArgs.ProgressPercentage'
                    '            if ($progress % 10 -eq 0 -and $progress -ne $global:lastProgress) {'
                    '                Write-Host "$progress% " -NoNewline'
                    '                $global:lastProgress = $progress'
                    '            }'
                    '        }'
                    ''
                    '        $global:lastProgress = -1'
                    '        $webClient.DownloadFileAsync([Uri]$url, $filePath)'
                    ''
                    '        # Wait for download to complete'
                    '        while ($webClient.IsBusy) { Start-Sleep -Milliseconds 100 }'
                    '        Unregister-Event -SourceIdentifier $event.Name'
                    '        Write-Host "100% Complete!"'
                    ''
                    '        if (Test-Path $filePath) {'
                    '            Write-Host "  [OK] Starting DriverBooster installation..."'
                    '            Start-Process -FilePath $filePath -ArgumentList "/S" -Wait'
                    '            if ($LASTEXITCODE -eq 0) {'
                    '                Write-Host "  [SUCCESS] DriverBooster installed" -ForegroundColor Green'
                    '                $success = $true'
                    '            } else {'
                    '                Write-Host "  [WARNING] DriverBooster installation exited with code $LASTEXITCODE" -ForegroundColor Yellow'
                    '                $success = $false'
                    '            }'
                    '        } else {'
                    '            throw "File not found after download"'
                    '            $success = $false'
                    '        }'
                    '    }'
                    '    catch {'
                    '        Write-Host "  [ERROR] Download failed: $_" -ForegroundColor Red'
                    '        $success = $false'
                    '    }'
                    '    finally {'
                    '        if ($webClient) { $webClient.Dispose() }'
                    '    }'
                    '}'
                    '$Global:InstallState["Drivers-0"] = $success'
                )
            },
            @{
                Name = "Vulkan SDK + DirectX 11"
                Commands = @(
                    'if (Test-IsWindows8) { $ver = "1.1.130.0" } else { $ver = "1.3.250.1" }'
                    '$url = "https://sdk.lunarg.com/sdk/download/$ver/windows/VulkanSDK-$ver-Installer.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "vulkan.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Drivers-1"] = $true'
                )
            }
        )
    }
    Utilities = @{
        Name = "Essential Utilities"
        Options = @(
            @{
                Name = "Firewall Control + SoundSwitch"
                Commands = @(
                    '$url = "https://m.majorgeeks.com/files/details/windows_firewall_control.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "wfc.exe"'
                    'Start-Process $path /VERYSILENT'
                    '$url = "https://github.com/Belphemur/SoundSwitch/releases/download/v6.14.1/SoundSwitch_v6.14.1.0_Release_Installer.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "soundswitch.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Utilities-0"] = $true'
                )
            },
            @{
                Name = "7-Zip + Free Alarm Clock"
                Commands = @(
                    '$url = "https://7-zip.org/a/7z2400-x64.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "7z.exe"'
                    'Start-Process $path /S'
                    '$url = "https://freealarmapp.com/files/freealarmclock-portable.zip"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "alarmclock.zip"'
                    'Expand-Archive $path -DestinationPath "$env:ProgramFiles\FreeAlarmClock"'
                    '$Global:InstallState["Utilities-1"] = $true'
                )
            }
        )
    }
    Media = @{
        Name = "Media & Productivity"
        Options = @(
            @{
                Name = "K-Lite Codecs + VLC"
                Commands = @(
                    '$url = "https://files3.codecguide.com/K-Lite_Codec_Pack_Standard.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "klite.exe"'
                    'Start-Process $path /VERYSILENT'
                    '$url = "https://get.videolan.org/vlc/3.0.20/win64/vlc-3.0.20-win64.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "vlc.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Media-0"] = $true'
                )
            },
            @{
                Name = "Windows Essentials 2012"
                Commands = @(
                    '$url = "https://github.com/thedoggybrad/winliveessentials-archive/releases/download/16.4.3528.331/wlsetup-all.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "essentials.exe"'
                    'Start-Process $path'
                    '$Global:InstallState["Media-1"] = $true'
                )
            }
        )
    }
    Internet = @{
        Name = "Internet & Networking"
        Options = @(
            @{
                Name = "Brave + Waterfox"
                Commands = @(
                    '$url = "https://github.com/brave/brave-browser/releases/download/v1.47.186/BraveBrowserStandaloneSilentSetup.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "brave.exe"'
                    'Start-Process $path'
                    '$url = "https://cdn1.waterfox.net/waterfox/releases/G6.0.1/Windows_x86_64/Waterfox%20G6.0.1%20Setup.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "waterfox.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Internet-0"] = $true'
                )
            },
            @{
                Name = "Tor Browser + qBittorrent"
                Commands = @(
                    '$url = "https://www.torproject.org/dist/torbrowser/13.5/torbrowser-install-win64-13.5.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "tor.exe"'
                    'Start-Process $path /S'
                    '$url = "https://altushost-swe.dl.sourceforge.net/project/qbittorrent/qbittorrent-win32/qbittorrent-4.5.0/qbittorrent_4.5.0_x64_setup.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "qbittorrent.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Internet-1"] = $true'
                )
            }
        )
    }
    Development = @{
        Name = "Development Tools"
        Options = @(
            @{
                Name = "Python + PowerShell"
                Commands = @(
                    'if (Test-IsWindows8) { $pyUrl = "https://www.python.org/ftp/python/3.8.0/python-3.8.0.exe" } else { $pyUrl = "https://www.python.org/ftp/python/3.9.0/python-3.9.0.exe" }'
                    '$path = Invoke-SafeDownload -Url $pyUrl -FileName "python.exe"'
                    'Start-Process $path /quiet InstallAllUsers=1'
                    'if (-not (Test-IsWindows8)) {'
                    '    $psUrl = "https://github.com/PowerShell/PowerShell/releases/download/v6.2.7/PowerShell-6.2.7-win-x64.msi"'
                    '    $path = Invoke-SafeDownload -Url $psUrl -FileName "pwsh.msi"'
                    '    Start-Process msiexec -ArgumentList "/i $path /quiet" -Wait'
                    '}'
                    '$Global:InstallState["Development-0"] = $true'
                )
            },
            @{
                Name = "Rainmeter + PowerShellRM"
                Commands = @(
                    '$url = "https://github.com/rainmeter/rainmeter/releases/download/v4.5.23/Rainmeter-4.5.23.exe"'
                    '$path = Invoke-SafeDownload -Url $url -FileName "rainmeter.exe"'
                    'Start-Process $path /S'
                    '$Global:InstallState["Development-1"] = $true'
                )
            }
        )
    }
}