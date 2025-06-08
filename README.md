# Make-Windows-Gr8-Again
Status : Alpha - Its very early development, plan is not final yet.

### Description
Like the name states, the project is intended to revamp windows, 8 and 2012, build 9200, which turns out to still be a perfectly good OS, just with version limits, and "Legacy" versions of applications. While in the making this page should somewhat assists people with, list of components and version numbers, for their own installations of Windows 8/Server 2012. This project may shift to being Server 2012 only, due to windows 8 limitations being significant in comparrisson.

### Preview
Most or all, of this stuff should be happening in the final program...
```
=======================================================================================================
    Make-Windows-Gr8-Again : Main Menu
=======================================================================================================

Improvement Options:
    1. Install StartIsBack and Enable Boot F8 SafeMode.
    2. Install 3/4 Most Critical Windows Updates.
    3. Install .net 3.5 from Install Media (Disk/Key).
    4. Install, .net 4.6/4.8 + VC 2008-2022.
    5. Install Context Window Reg-Hacks.
    6. Insall XP-AntiSpy + Windows Privacy Tweaker.
    7. Install Windows Firewall Control + 7z
    8. Install Graphics Drivers + Driver Booster.
    9. Install Vulkan Sdk 1.1/1.3 + Direct X 11.
    10. Install Python 3.9 + Powershell 4.
    11. Install Codecs / MediaPlayerClassic
    12. Install, Brave 1.47, Waterfox G6.0, Tor Browser 13.5.
    13. Install 7z + Thunderbird + Telegram.
    14. Install Movie Maker 2012 + Google Earth Pro.
    15. Disable WindowsDefender + SmartScreen.
    16. Disable/Remove Themes + Aero + Airplane Mode.
    17. Delete Default Movies + Pictures + Music.
    18. Install Shutdown_Now + Anti-Anti-H8te.

Selection; Options = 1-18, Exit = X: 
```

### Objectives
Additional Software has appeared in the Preview, must ensure all is covered, but there should be some more lines below. Here is the outline of components...
- Install of, KB2770917, KB2770917, KB2785094, KB2795944, which are critical for things to work more correctly with somewhat modern apps. Server 2012 had "KB27959442" built-in, while Windows 8 required it to be installed.
- Install Python 3.9, using script from other completed project (but remove build tools part, as not working).
- Install of, "Run here as Admin", "Open Command Prompt as Admin", "Add Recycle to Navigation Pane", "Take_Ownership", "Open Powershell Window here as Admin"
- Addition of, `Desktop\Shutdown_Now` and `C\Anti-Anti-H8te`.
- Install of, AMD or nVidia or Both, pop up relating site page with drivers, people will be directed to their own drivers, and some kind of info to explain driver unlocking. There may be enhancements to do in relevance to hybrid nvidia/amd gpu setups.
- Win8 limited to .net 4.6.1, while server 2012 was .Net 4.8 (final). Deepseek said it was to do with server's lts aspect. It would be nice to be able to install 4.8 on both though, solve a lot of app issues.
- Delete default windows media including, pictures and movies, from all user directories, while not deleting other things. Starts by finding and listing all media, conclusion on what was found could be put in a folder and made into a short video.
- Install K-Lite Codec Pack with options, minimal, regular, full, in sub-menu.
- Disable relevant components, then Remove Airplane Mode + traces, while not breaking mobile internet support. Server 2012 does NOT have, airplane mode.
- Disable themes. Redirect default starting theme to being Classic (as it always boots with aero, that then unloads for classic). Remove Aero + Traces. 
- Enable Firewall and Install of Windows Firewall Control. The firewall already present gets some buffout. (try find latest compatible version)
- Install old version of Driver Booster 8. Its auto-installer seems windows 8 unsupported. It will try to update without the user's concent.
- Install of best version of vulkan_sdk, for windows 8 its 1.1 and for server 2012 its 1.3. Hard to find 1.1. 1.0 is out there but no direct link. 
- Win8 will require optional Defender remove, while 2012 already has this removed.

### Requirements
Considerations...
- Windows = Windows, 8 and 2012, both build 9200 (the final builds before, 8.1 / 2012 R2).
- CPU - compatibility was fine with x3900, after a little update with Driver Booster no driver issues.
- GPU - best ones supported are, TitanX and 1080. Need research the AMD side, having issues with the rx470. Hybrid nVidia-Amd will work vanilla.
- Games - Limited to, Direct-X 11 and Vulkan 1.1 for Win8, 1.3 for server 2012. This means, Yes Fallout4/GTA5/Valheim and No Cyberpunk/OtherDx12Titles.
- Apps - Win 8 limited to .net 4.6.1, while Server 2012 limited to .net 4.8. Use AI to find compatible app versions.

### Ideas / Notations
- Some kind of shim script, that will automatically check, and if required, capture and resize, contents of terminal output, to being suited to 80 character width display. Thus enabling compatibility with modern python apps, mainly for separators etc.
-  2012 dont have aero by default on boot, need to investigate the effects of mod attempted/failed with 8, that did have it during boot.
