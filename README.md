# Make-Windows-Gr8-Again
Status : Alpha - Its not made yet, and likely it will be progressed only each time I install windows 8/2012...

### Description
Like the name states, the project is intended to revamp windows, 8 and 2012, build 9200, for which 2012 turns out to still be a perfectly good OS, just with version limits, and "Legacy" versions of applications, and no DirectX 12.

### Preview
- Here is the Batch Menu currently...
```
===============================================================================
    Make-Windows-Gr8-Again
===============================================================================








    1. Run Make-Windows-Gr8-Again

    2. Install PowerShell 4/5.1







===============================================================================
Selection; Run Program = 1, Install PowerShell = 2, Exit Program = X:

```
- here is the current plan for the Python main menu...
```
=======================================================================================================
    Make-Windows-Gr8-Again : Main Menu
=======================================================================================================

System Configuration:
    1. Core System Tweaks (0/4 done)
    2. Security & Privacy (0/3 done)
    3. .NET & Runtime Components (0/2 done)
    4. Driver & Hardware Support (0/2 done)

Software Installation:
    5. Essential Utilities (0/2 done)
    6. Media & Productivity (0/2 done)
    7. Internet & Networking (0/2 done)
    8. Development Tools (0/2 done)

Selection (1-8, X=Exit): 

```
- Here is the original plan for the main menu line-up so far...
```
=======================================================================================================
    Make-Windows-Gr8-Again : Main Menu
=======================================================================================================

Improvement Options:
    1. Install StartIsBack and EnableBootF8Menu.
    2. Install 3/4 Most Critical Windows Updates.
    3. Install .net3.5 from Install Media (Disk/Key).
    4. Install, .net 4.6/4.8 + VC 2008-2022.
    5. Install, ContextWindowRegHacks + TetraCopy3.17(Win8).
    6. Insall XP-AntiSpy + WindowsPrivacyTweaker.
    7. Install WinFireCtrl5.4 + SoundSwitch6.14 + FreeAlarmClock5.4.
    8. Activate TestingMode + Install DriverBooster8.
    9. Install VulkanSdk 1.1/1.3 + DirectX11.
    10. Install Python 3.8(Win8)/3.9(2012) + Powershell 4(Win8)/5.1+6.2.5(2012).
    11. Install K-LiteCodecs + MediaPlayerClassic + VideoLanClassic
    12. Install, Brave1.47, WaterfoxG6.0, GoogleEarthPro7.x.
    13. Install, TorBrowser13.5 + qBittorrent4.5 + 7z.
    14. Install Notepad++ + Thunderbird + Telegram.
    15. Install Essentials2012 - MovieMaker, Writer, Mail.
    16. Install FireStorm6.6 + LSLEditor + Gyazo.
    17. Install Rainmeter4.5.23 + WiseRain + PowershellRM
    18. Install/Use Classic-Greys + Disable/Remove Themes/Aero. 
    19. Disable/Remove WindowsDefender + AirplaneMode +  SmartScreen.
    20. Delete Default Movies+Pictures+Music (Win8).
    21. Install, Shutdown_NOW and Destroy_ALL, scripts

Selection; Options = 1-18, Exit = X: 
```

### Notation:
- This project switched to Server 2012 after finding limitation with NET 4.61 on Windows 8 instead of 4.8+ on Server 2012, and powershell 7+ instead of 4.0 on 8, vulkan being 1.3 instead of 1.1 on 8, hence stuff on windows 8 will be untested, until I have, spare machine/time and/or reasoning/motivation to do so. 
-  I cant log in to X on the legacy OS, I dont know why just that site, doesnt support legacy browsers for security or something my best guess??
- OpenHardwareMonitor is only safe to install, if somehow we can pre-configure to not show stats for drives, or will hang on shutdown with usbdrive plugged in.

### Development
Additional Software has appeared in the Preview, must ensure all is covered, but there should be some more lines below. Its also looking like there will have to be sub-menus. Here is the further details on components...
- Install of, KB2770917, KB2779768, KB2785094, KB2795944, which are critical for things to work more correctly with somewhat modern apps. Server 2012 had "KB27959442" built-in, while Windows 8 required it to be installed.
- Install Python 3.9, using script from other completed project (but remove build tools part, as not working).
- Install of Powershell limited to 4.0 on Win 8. Server 2012 is able to install [.NET Core 2.1.818](https://dotnet.microsoft.com/en-us/download/dotnet/2.1), and then [PowerShell Core 6.2.7](https://github.com/PowerShell/PowerShell/releases/download/v6.2.7/PowerShell-6.2.7-win-x64.msi) .
- Install of, "Run here as Admin", "Open Command Prompt as Admin", "Add Recycle to Navigation Pane", "Take_Ownership", "Open Powershell Window here as Admin"
- Addition of, `Desktop\Shutdown_Now` and `C\Destroy_All`, scripts for shutdown reinforcement and selective data erasure.
- Install of, AMD or nVidia or Both. Still determening depth of features. could involve identifiers unlocking for certain drivers. There may be enhancements to do for hybrid nvidia/amd gpu setups.
- Activation of "Testing Mode" will enable "Unsigned Drivers", hence, drivers are more likely to install correctly.
- Win8 limited to .net 4.6.1, while server 2012 was .Net 4.8 (final). Deepseek said it was to do with server's lts aspect. It would be nice to be able to install 4.8 on both though, solve a lot of app issues.
- Delete default windows media including, pictures and movies, from all user/public directories. Server 2012 does not have such media.
- Install K-Lite Codec Pack with options, minimal, regular, full, in sub-menu.
- Disable relevant components, then Remove Airplane Mode + traces, while not breaking mobile internet support. Server 2012 does NOT have, airplane mode.
- Disable themes. Redirect default starting theme to being Classic (as it always boots with aero, that then unloads for classic). Remove Aero + Traces. 
- Enable Firewall and Install of Windows Firewall Control. The firewall already present gets some buffout. (try find latest compatible version)
- Install rainmeter for powershell with plugin enhancement desktop stats, with simple re-programability through AI. 
- Install old version of Driver Booster 8. Its auto-installer seems windows 8 unsupported. It will try to update without the user's concent.
- Install of best version of vulkan_sdk, for windows 8 its 1.1 and for server 2012 its 1.3. Hard to find 1.1. 1.0 is out there but no direct link. 
- Win8 will require optional Defender remove, while 2012 already has this removed.
- Install Last Monthly rollup updates Windows8/[Server2012](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5029295) (from just before they broke startisback) + Insert [TLS 1.2/1.3](https://manage.accuwebhosting.com/knowledgebase/3578/How-to-enable-TLS-1.2-on-Windows-2012-Server.html) into registry + [Update Root Certificates](https://github.com/asheroto/UpdateRootCertificates/releases/tag/4.0.0)

### Considerations
- Windows - Windows, 8 and 2012, both build 9200 (the final builds before 8.1/2012R2 Beta). 
- ISOs - Do not burn windows <= 8/2012 isos with Linux (multi-writer seems ok), instead use "Rufus" under Windows (USB on VM is not simple). During install you may need a driver for modern HD, try find the drivers, otherwise try editions with modern drivers included such as "windows 8 usb-3.0+nvme".
- CPU - compatibility was fine with x3900, after a little update with Driver Booster no driver issues.
- GPU - best ones supported are, TitanX and 1080. Need research the AMD side, having issues with the rx470. Hybrid nVidia-Amd will work vanilla.
- Games - Limited to, Direct-X 11 and Vulkan 1.1 for Win8, 1.3 for server 2012. This means, Yes Fallout4/GTA5/Valheim and No Cyberpunk/OtherDx12Titles.
- Apps - Win 8 limited to .net 4.6.1, while Server 2012 limited to .net 4.8. Use AI to find compatible app versions.

### File Structure
```
.\Make-Windows-Gr8-Again.bat
.\launcher.ps1
.\installer.ps1
.\scripts\interface.ps1
.\scripts\utilities.ps1
.\scripts\temporary.ps1
.\data\Classic-GreyRoyale_003c.theme
```

### Notations
- Wondows 2012 doesnt have aero by default on boot, need to investigate the effects of mod attempted/failed with 8. Themes are necessary for some stuff to install/run correctly though ie drivers/graphical stuff.
- Windows 8/2012 build 9200 were the last versions of windows to be released where "Bill Gates" was the CEO of "Microsoft". 
