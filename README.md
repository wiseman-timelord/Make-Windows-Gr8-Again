# Make-Windows-Gr8-Again
Status : Alpha - Its very early development, plan is not final yet. This will be a slow-back-burner project.

### Description
Like the name states, the project is intended to revamp windows, 8 and 2012, build 9200, which turns out to still be a perfectly good OS, just with version limits, and "Legacy" versions of applications. While in the making (It will take a while to research, then finalize the, apps and groups, then, make and test), this page should somewhat assists people with, list of components and version numbers, for their own installations of Windows 8/Server 2012. This project may shift to being developed for Server 2012 first, due to windows 8 limitations being significant in comparrisson, such as .net 4.8 instead of 4.6.1 on 8, and powershell 6.2.7 instead of 4.0 on 8, vulkan being 1.3 instead of 1.1 on 8.

### Preview
Here is the line-up so far...
```
=======================================================================================================
    Make-Windows-Gr8-Again : Main Menu
=======================================================================================================

Improvement Options:
    1. Install StartIsBack and EnableBootF8Menu.
    2. Install 3/4 Most Critical Windows Updates.
    3. Install .net3.5 from Install Media (Disk/Key).
    4. Install, .net 4.6/4.8 + VC 2008-2022.
    5. Install, ContextWindow + LongFileName, Reg-Hacks.
    6. Insall XP-AntiSpy + Windows Privacy Tweaker.
    7. Install WinFireCtrl5.4 + SoundSwitch6.14 + FreeAlarmClock5.4.
    8. Activate TestingMode + Install DriverBooster8 + ExperienceIndex
    9. Install VulkanSdk 1.1/1.3 + DirectX11.
    10. Install Python3.9 + Powershell 4/5.1/6.2.7 + Notepad++.
    11. Install K-LiteCodecs + MediaPlayerClassic + VideoLanClassic
    12. Install, Brave1.47, WaterfoxG6.0, GoogleEarthPro7.x.
    13. Install, TorBrowser13.5 + qBittorrent4.5 + 7z.
    14. Install Thunderbird + Telegram + Gyazo
    15. Install Essentials2012 - MovieMaker, Writer, Mail.
    16. Install FireStorm6.6 + LSLEditor.
    17. Install Rainmeter + WiseRain + PowershellRM
    18. Install/Use Classic-Greys + Disable/Remove Themes/Aero. 
    19. Disable/Remove WindowsDefender + AirplaneMode +  SmartScreen.
    20. Delete Default Movies+Pictures+Music (Win8 Only).
    21. Install, Shutdown_NOW and Destroy_ALL, scripts

Selection; Options = 1-18, Exit = X: 
```

### Objectives
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

### Considerations
- Windows - Windows, 8 and 2012, both build 9200 (the final builds before, 8.1 / 2012 R2).
- CPU - compatibility was fine with x3900, after a little update with Driver Booster no driver issues.
- GPU - best ones supported are, TitanX and 1080. Need research the AMD side, having issues with the rx470. Hybrid nVidia-Amd will work vanilla.
- Games - Limited to, Direct-X 11 and Vulkan 1.1 for Win8, 1.3 for server 2012. This means, Yes Fallout4/GTA5/Valheim and No Cyberpunk/OtherDx12Titles.
- Apps - Win 8 limited to .net 4.6.1, while Server 2012 limited to .net 4.8. Use AI to find compatible app versions.


### Ideas / Notations
- Some kind of shim script, that will automatically check, and if required, capture and resize, contents of terminal output, to being suited to 80 character width display. Thus enabling compatibility with modern python apps, mainly for separators etc.
-  2012 dont have aero by default on boot, need to investigate the effects of mod attempted/failed with 8, that did have it during boot.
