# Script: `.\scripts\utilities.ps1`
# Helper functions for installation

function Get-TempPath {
    $path = Join-Path $env:TEMP "MWGA-$(Get-Date -Format 'yyyyMMdd')"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path | Out-Null }
    return $path
}

function Invoke-SafeDownload {
    param($Url, $FileName)
    
    # Add TLS workaround for older systems
    try {
        # Enable strong TLS versions
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12 -bor
            [System.Net.SecurityProtocolType]::Tls11 -bor
            [System.Net.SecurityProtocolType]::Tls
    } catch {
        Write-Host "  [WARNING] Failed to set security protocol: $_" -ForegroundColor Yellow
    }
    
    $tempPath = Get-TempPath
    $filePath = Join-Path $tempPath $FileName
    try {
        Write-Host "Downloading $FileName... " -NoNewline
        $webClient = New-Object System.Net.WebClient
        
        # Add progress tracker
        $event = Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -Action {
            $progress = $eventArgs.ProgressPercentage
            if ($progress % 10 -eq 0 -and $progress -ne $global:lastProgress) {
                Write-Host "$progress% " -NoNewline
                $global:lastProgress = $progress
            }
        }
        
        $global:lastProgress = -1
        $webClient.DownloadFileAsync([Uri]$Url, $filePath)
        
        # Wait for download to complete
        while ($webClient.IsBusy) { Start-Sleep -Milliseconds 100 }
        Unregister-Event -SourceIdentifier $event.Name
        Write-Host "100% Complete!"
        
        if (Test-Path $filePath) {
            return $filePath
        }
        throw "File not found after download"
    }
    catch {
        Write-Host "`nDownload failed: $_" -ForegroundColor Red
        return $null
    }
    finally {
        if ($webClient) { $webClient.Dispose() }
    }
}

function Install-Selections {
    param($Category, $Selections)
    
    foreach ($index in $Selections) {
        $itemIndex = $index - 1
        if ($itemIndex -lt $Global:Categories[$Category].Options.Count) {
            $item = $Global:Categories[$Category].Options[$itemIndex]
            Write-Host "`nInstalling: $($item.Name)" -ForegroundColor Cyan
            
            $success = $true
            $scriptBlock = [scriptblock]::Create(($item.Commands -join "`n"))
            
            try {
                # Execute as a single script block
                & $scriptBlock
            }
            catch {
                $success = $false
                Write-Host "  [ERROR] $($item.Name): $_" -ForegroundColor Red
            }
            
            if ($success) {
                Write-Host "  [SUCCESS] Installed successfully" -ForegroundColor Green
                # Force state update
                $Global:InstallState["$Category-$itemIndex"] = $true
            }
            else {
                Write-Host "  [WARNING] Installation had errors" -ForegroundColor Yellow
            }
        }
    }
    Read-Host "`nPress Enter to continue..."
}

function Test-IsWindows8 {
    $os = Get-CimInstance Win32_OperatingSystem
    ($os.Caption -match "Windows 8") -or ($os.Caption -match "Windows Server 2012")
}

function Test-IsServer2012 {
    $os = Get-CimInstance Win32_OperatingSystem
    $os.Caption -match "Windows Server 2012"
}