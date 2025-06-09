# Make-Windows-Gr8-Again
Status : Alpha - Its very early development, plan is not final yet. 

### Description
Like the name states, the project is intended to revamp windows, 8 and 2012, build 9200, which turns out to still be a perfectly good OS, just with version limits, and "Legacy" versions of applications. While in the making (It will take a while to research, then finalize the, apps and groups, then, make and test), this page should somewhat assists people with, list of components and version numbers, for their own installations of Windows 8/Server 2012. This project may shift to being Server 2012 only, due to windows 8 limitations being significant in comparrisson.

### Preview
Here is the line-up so far...
```
=======================================================================================================
    Make-Windows-Gr8-Again : Main Menu
=======================================================================================================

Improvement Options:
    1. Install StartIsBack and Enable Boot F8 Menu.
    2. Install 3/4 Most Critical Windows Updates.
    3. Install .net 3.5 from Install Media (Disk/Key).
    4. Install, .net 4.6/4.8 + VC 2008-2022.
    5. Install, Context Window + Long File Name, Reg-Hacks.
    6. Insall XP-AntiSpy + Windows Privacy Tweaker.
    7. Install WinFireCtrl 5.4 + SoundSwitch 6.14 + FreeAlarmClock.
    8. Activate Testing Mode + Install Driver Booster 8.
    9. Install Vulkan Sdk 1.1/1.3 + Direct X 11.
    10. Install Python 3.9 + Powershell 4/5.1 + Notepad++.
    11. Install K-LiteCodecs + MediaPlayerClassic + VideoLanClassic
    12. Install, Brave 1.47, Waterfox G6.0, Google Earth Pro.
    13. Install, Tor Browser 13.5 + qBittorrent 4.5 + 7z.
    14. Install Thunderbird + Telegram + Gyazo
    15. Install MovieMaker, Writer, Mail. (Essentials 2012).
    16. Install FireStorm 6.6 + LSL Editor.
    16. Disable WindowsDefender + SmartScreen + Airplane Mode.
    17. Disable/Remove Themes/Aero + install/Use Classic-Greys. 
    18. Delete Default Movies + Pictures + Music.
    19. Install, Shutdown_NOW and Destroy_ALL, scripts

Selection; Options = 1-18, Exit = X: 
```

### Objectives
Additional Software has appeared in the Preview, must ensure all is covered, but there should be some more lines below. Its also looking like there will have to be sub-menus. Here is the further details on components...
- Install of, KB2770917, KB2779768, KB2785094, KB2795944, which are critical for things to work more correctly with somewhat modern apps. Server 2012 had "KB27959442" built-in, while Windows 8 required it to be installed.
- Install Python 3.9, using script from other completed project (but remove build tools part, as not working).
- Install of Powershell limited to 4.0 on Win 8. Server 2012 is 5.1 with updates, KB2919355, KB3000850, KB3156418, KB3173424. Additionally its possible to  install .NET Core 2.1, and then install PowerShell Core 6.2!
- Install of, "Run here as Admin", "Open Command Prompt as Admin", "Add Recycle to Navigation Pane", "Take_Ownership", "Open Powershell Window here as Admin"
- Addition of, `Desktop\Shutdown_Now` and `C\Anti-Anti-H8te`.
- Install of, AMD or nVidia or Both, pop up relating site page with drivers, people will be directed to their own drivers, and some kind of info to explain driver unlocking. There may be enhancements to do in relevance to hybrid nvidia/amd gpu setups.
- Activation of "Testing Mode" will enable "Unsigned Drivers", hence, drivers are more likely to install correctly.
- Win8 limited to .net 4.6.1, while server 2012 was .Net 4.8 (final). Deepseek said it was to do with server's lts aspect. It would be nice to be able to install 4.8 on both though, solve a lot of app issues.
- Delete default windows media including, pictures and movies, from all user/public directories, while not deleting other things. Starts by finding and listing all media. Server 2012 does not have such media.
- Install K-Lite Codec Pack with options, minimal, regular, full, in sub-menu.
- Disable relevant components, then Remove Airplane Mode + traces, while not breaking mobile internet support. Server 2012 does NOT have, airplane mode.
- Disable themes. Redirect default starting theme to being Classic (as it always boots with aero, that then unloads for classic). Remove Aero + Traces. 
- Enable Firewall and Install of Windows Firewall Control. The firewall already present gets some buffout. (try find latest compatible version)
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
