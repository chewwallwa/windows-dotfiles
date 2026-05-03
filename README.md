# The best windows is the less windowy windows 

- [Preview](https://github.com/chewwallwa/windows-dotfiles/edit/main/README.md#preview)
- [Dofiles and Settings](https://github.com/chewwallwa/windows-dotfiles/edit/main/README.md#-dotfiles--configuration)
- [Debloating](https://github.com/chewwallwa/windows-dotfiles/edit/main/README.md#opitional-debloating)
- [Substitute apps for MS apps](https://github.com/chewwallwa/windows-dotfiles/edit/main/README.md#apps-to-substitue-ms-apps)

I use Neovim, if you don't use it, do not remove MS Notepad, and don't follow the tutorial for nvim.

Made for windows 11, but may be applicable for Win10.

***Please note: Some files have a path like C:/Users/[USER], remeber to put your username.***

## Preview

<img width="2688" height="1366" alt="image" src="https://github.com/user-attachments/assets/9994c6ef-b1d2-4547-8c2b-8efbe4465849" />
<img width="1912" height="1073" alt="image" src="https://github.com/user-attachments/assets/316ad26a-9c21-408c-830b-5d4f82378c5f" />

---

## 📂 Dotfiles & Configuration

Copy the configuration files to these specific paths to achieve the look.

### GlazeWM

* [Download](https://glazewm.com/), install, and put my file (`glazewm/config.yaml`) on this path: `C:\Users\[USER]\.glzr\glazewm`.

### ExplorerPatcher

- [Download](github.com/valinet/ExplorerPatcher/releases) the latest release, install, open and Import my file.

### Windows Terminal

* You can config manually on `Ctrl + ,` > Defaults > Appearance 
* Or put my file `windows-terminal/settings.json` on this path: `C:\Users\[USER]\AppData\Local\Packages\Microsoft.WindowsTerminal_[SOMETHING]\LocalState\settings.json`
* To make command history permanent on powershell, run this on powershell:
`if (!(Test-Path -Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }`

### Windhawk

- [Downlod](https://windhawk.net/) and install; Download the extension `start menu styler` and choose the `LayerMicaUI` Theme.

### Changing System Font
* Download [Iosevka](https://github.com/be5invis/Iosevka/releases) and execute the `.ttf` file to install.
* Download [Winaero Tweaker](https://winaerotweaker.com/) it.
* Unzip the Winaero RAR directly to your local disk `C:/` folder.
* Open `WinaeroTweaker.exe` and navigate to **Advanced Appearance Settings**. Chiange the font to **Iosevka** for the following:
    * Menus
    * Message font
    * Statusbar font
    * System font
    * Window title bars

### Fastfetch

- `winget install fastfetch`
- Edit the `$PROFILE` file (`nvim $PROFILE` for nvim, use your editor), and paste the content of my file (`PowerShell_profile.ps1`) on it.
- Put my `fastfetch` folder on this path `C:Users/[USER]/.config/` (you have to create the `.config/`).

### Neovim (Opitional)

* `winget install Neovim.Neovim`
* Put my `nvim` folder on this path: `C:\Users\[USER]\AppData\Local\`

* If you have removed notepad: Download and run the two `.reg` files and execute it.
  
* **p.s.:** Remember to run `pip install pynvim` for Python support. You can remove the python/octave parts of the file.
There are another posts where I show my nvim mods on reddit: [nvim feature](https://www.reddit.com/r/neovim/comments/1r518sg/comment/o9fn15l/?context=3) and [rice](https://www.reddit.com/r/LinuxPorn/comments/1r8duka/neovim_my_modified_gruvbox_neovim/).
The dots for linux are on [chewwallwa/dotfiles](https://github.com/chewwallwa/dotfiles) and were adapted for windows here (under test).

### MS PowerToys

I'm also using it for a RoFi like menu on `alt+Space`. And more. I think you can download it by yourself if you want.

---

## (Opitional) Debloating 

### Chris Titus Tech Windows Utility

Removing Default shit
* **Run PowerShell as Admin** and paste:
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; iwr -useb https://christitus.com/win | iex
    ```
* **Tweaks Tab**: Select **Standard**. Check others if you want (Note: Removing Xbox features might break some games).
* **Install Tab**: Remove Edge, Bing, and built-in apps like the MS Calculator or Photos.

### O&O ShutUp10+

Disabling Telemetry
* Download and run **[O&O ShutUp10+](https://www.oo-software.com/en/shutup10)**.
* **Action**: Apply all recommended settings. Also others if you want (by your risk).

---

## Apps to substitue MS apps

Replace bloated Windows defaults with lightweight, "Linux" alternatives using `winget`.


| Category | App | Why? |
| :--- | :--- | :--- |
| **Text Editor** | Neovim (opitional) | Ultra-fast, Lua-configured, stays in the terminal. |
| **Calculator** | Qalculate! | Fraction support, unit conversion, and CLI/GUI options. |
| **Media Player** | VLC | High performance, minimal UI, scriptable. |
| **Image Viewer** | qView | Minimalist (no UI), ultra-fast, keyboard-driven. |
| **PDF Reader** | SumatraPDF | The "Zathura" of Windows. Config-file based. |
| **Browser** | Librewolf | Hardened Firefox for privacy. |
| **Terminal File Explorer** | Yazi | Ultra fast. |


### Installation Command

Copy and paste this into your terminal to grab the core stack:

```powershell
winget install -e --id GlazeWM.GlazeWM
winget install -e --id Qalculate.Qalculate
winget install -e --id jurplel.qView
winget install -e --id SumatraPDF.SumatraPDF
winget install -e --id Librewolf.Librewolf
winget install -e --id sxyazi.yazi
```
