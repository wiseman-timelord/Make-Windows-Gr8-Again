# Script: `.\installer.ps1`
# PowerShell 5.1 upgrade installer
# For Windows 8/2012 systems
# Requires PS 3.0+

# Set execution policy
Set-ExecutionPolicy Bypass -Scope Process -Force > $null

# Setup console
$Host.UI.RawUI.WindowTitle = "MWGA: PS5.1 Installer"
Clear-Host

# Check admin rights
function Test-Admin {
    $user = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "Admin rights required" -Fore Red
    Write-Host "Run as administrator" -Fore Yellow
    Write-Host "Press any key to exit"
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") > $null
    exit 1
}

# Get PS version
$PSVer = $PSVersionTable.PSVersion
Write-Host "Current PS version: $($PSVer.ToString())`n"

# Exit if already 5.1+
if ($PSVer.Major -ge 5 -and $PSVer.Minor -ge 1) {
    Write-Host "PS 5.1+ installed" -Fore Green
    Write-Host "No action needed`n"
    Write-Host "Press any key to exit"
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") > $null
    exit 0
}

# Check OS compatibility
$OSVer = [System.Environment]::OSVersion.Version
$IsTargetOS = ($OSVer.Major -eq 6 -and $OSVer.Minor -eq 2)

if (-not $IsTargetOS) {
    Write-Host "Windows 8/2012 only" -Fore Red
    Write-Host "Press any key to exit"
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") > $null
    exit 1
}

# Install package function
function Install-Pkg {
    param ($Name, $Path, $Args)
    
    Write-Host "Installing $Name" -Fore Cyan
    
    try {
        if ($Path.EndsWith(".msu")) {
            $proc = Start-Process "wusa" "$Path $Args /quiet /norestart" -Wait -PassThru -NoNewWindow
        }
        elseif ($Path.EndsWith(".cab")) {
            $proc = Start-Process "dism" "/Online /Add-Package /PackagePath:`"$Path`" /Quiet /NoRestart" -Wait -PassThru -NoNewWindow
        }
        else {
            $proc = Start-Process $Path $Args -Wait -PassThru -NoNewWindow
        }
        
        if ($proc.ExitCode -in 0,3010) {
            Write-Host "$Name installed" -Fore Green
            return $true
        }
        else {
            Write-Host "Install failed" -Fore Red
            return $false
        }
    }
    catch {
        Write-Host "Install error" -Fore Red
        return $false
    }
}

# Main logic
$NeedsRestart = $false
$DataDir = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "data"

if ($PSVer.Major -lt 4) {
    # Upgrade to PS4 first
    Write-Host "Upgrading to PS4" -Fore Yellow
    $cab = Join-Path $DataDir "Windows8-RT-KB2799888-x64.cab"
    
    if (Test-Path $cab) {
        if (Install-Pkg "PS4 Update" $cab) {
            $NeedsRestart = $true
            Write-Host "PS4 installed" -Fore Green
            Write-Host "Restart required" -Fore Yellow
        }
    }
    else {
        Write-Host "Missing CAB file" -Fore Red
    }
}
elseif ($PSVer.Major -eq 4) {
    # Check .NET version
    $dotNetOK = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\' | 
                Get-ItemPropertyValue -Name Release | 
                ForEach-Object { $_ -ge 379893 }
    
    if (-not $dotNetOK) {
        Write-Host "Installing .NET" -Fore Yellow
        $dotNetExe = Join-Path $DataDir "dotnet-sdk-2.1.818-win-x64.exe"
        
        if (Test-Path $dotNetExe) {
            if (Install-Pkg ".NET" $dotNetExe "/install /quiet /norestart") {
                $NeedsRestart = $true
                Write-Host ".NET installed" -Fore Green
                Write-Host "Restart required" -Fore Yellow
            }
        }
        else {
            Write-Host "Missing .NET installer" -Fore Red
        }
    }
    else {
        # Install PS5.1
        Write-Host "Upgrading to PS5.1" -Fore Yellow
        $msu = Join-Path $DataDir "W2K12-KB3191565-x64.msu"
        
        if (Test-Path $msu) {
            if (Install-Pkg "PS5.1 Update" $msu) {
                $NeedsRestart = $true
                Write-Host "PS5.1 installed" -Fore Green
            }
        }
        else {
            Write-Host "Missing MSU file" -Fore Red
        }
    }
}

# Restart handling
if ($NeedsRestart) {
    Write-Host "`nRestart needed" -Fore Yellow
    Write-Host "Run again after restart" -Fore Yellow
    Write-Host "Restart now? (Y/N)" -Fore Cyan
    
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    if ($key.Character -in 'y','Y') {
        Write-Host "`nRestarting..." -Fore Cyan
        Start-Process "shutdown" "/r /t 30 /c ""Restarting for PS install""" -NoNewWindow
    }
    else {
        Write-Host "`nRestart when ready" -Fore Yellow
    }
}
else {
    Write-Host "`nInstall complete" -Fore Green
    if ($PSVersionTable.PSVersion.Major -ge 5) {
        Write-Host "PS5.1 ready" -Fore Green
    }
}

Write-Host "`nPress any key to exit"
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") > $null
