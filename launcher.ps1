# launcher.ps1
# Entry point for Make-Windows-Gr8-Again

# Relaunch as admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Load dependencies
. .\scripts\utilities.ps1
. .\scripts\interface.ps1
. .\scripts\temporary.ps1

# Initialize environment
Set-ConsoleSettings
Show-MainMenu