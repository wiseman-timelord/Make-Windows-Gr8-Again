# Make-Windows-Gr8-Again
Like the name states, the project is intended to revamp windows 8, which turns out to still be a perfectly good OS, just with version limits. 

### Objectives
- Install of, KB2770917, KB2770917, KB2785094, KB2795944, which are critical for things such as "Chat-Gradio-Gguf" to work.  
- Disable relevant components, then Remove Airplane Mode + traces.
- Disable themes. Redirect default starting theme to being Classic (as it always boots with aero, that then unloads for classic). Remove Aero + Traces. 
- Install Python 3.9, using script from other completed project (but remove build tools part, as not working).
- TBA

### Ideas
- Idea: Some kind of shim script, that will automatically check, and if required, capture and resize, contents of terminal output, to being suited to 80 character width display. Thus enabling compatibility with modern python apps, mainly for separators etc.
