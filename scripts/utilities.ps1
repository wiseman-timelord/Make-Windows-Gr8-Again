# utilities.ps1
# Helper functions for installation

function Get-TempPath {
    $path = Join-Path $env:TEMP "MWGA-$(Get-Date -Format 'yyyyMMdd')"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path | Out-Null }
    return $path
}

function Invoke-SafeDownload {
    param($Url, $FileName)
    
    $tempPath = Get-TempPath
    $filePath = Join-Path $tempPath $FileName
    try {
        Write-Host "Downloading $FileName..."
        (New-Object Net.WebClient).DownloadFile($Url, $filePath)
        if (Test-Path $filePath) {
            return $filePath
        }
        throw "File not found after download"
    }
    catch {
        Write-Host "Download failed: $_" -ForegroundColor Red
        return $null
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
            foreach ($command in $item.Commands) {
                try {
                    # Skip state tracking commands during execution
                    if (-not $command.Contains('$Global:InstallState')) {
                        Invoke-Expression $command
                    }
                }
                catch {
                    $success = $false
                    Write-Host "  [ERROR] $($item.Name): $_" -ForegroundColor Red
                }
            }
            
            if ($success) {
                Write-Host "  [SUCCESS] Installed successfully" -ForegroundColor Green
                # Force state update even if tracking command failed
                Invoke-Expression "`$Global:InstallState['$Category-$itemIndex'] = `$true"
            }
            else {
                Write-Host "  [WARNING] Installation had errors" -ForegroundColor Yellow
            }
        }
    }
    Read-Host "`nPress Enter to continue..."
}

function Test-IsWindows8 {
    (Get-CimInstance Win32_OperatingSystem).Caption -match "Windows 8"
}