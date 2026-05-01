# The best windows is the less windowy windows 

p.s.: I use Neovim, if you don't use it, do not remove MS Notepad, and don't make settings for nvim.

If you want another font beside Iosevka, download and install its .tff normally.
**Download Iosevka**: Get the latest releases from [be5invis/Iosevka](https://github.com/be5invis/Iosevka/releases).

For windows 11, but may be applicable for Win10.

## (Opitional) Debloating 

### 1. Chris Titus Tech Windows Utility

Removing Default shit
* **Run PowerShell as Admin** and paste:
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; iwr -useb https://christitus.com/win | iex
    ```
* **Tweaks Tab**: Select **Standard**. Check others if you want (Note: Removing Xbox features might break some games).
* **Install Tab**: Remove Edge, Bing, and built-in apps like the MS Calculator or Photos.

### 2. O&O ShutUp10+

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

---


## Installation Command

Copy and paste this into your terminal to grab the core stack:

```powershell
winget install -e --id GlazeWM.GlazeWM
winget install -e --id Qalculate.Qalculate
winget install -e --id jurplel.qView
winget install -e --id SumatraPDF.SumatraPDF
winget install -e --id Librewolf.Librewolf
```

And download VLC.


## 📂 Dotfiles & Configuration

Copy the configuration files to these specific paths to achieve the look.

### GlazeWM

* **Path**: `C:\Users\[USER]\.glzr\glazewm`
* **Note**: This is where your `config.yaml` lives. Set up your gaps and keybindings here.

### Neovim (opitional)

* **Path**: `C:\Users\[USER]\AppData\Local\nvim`
* **Note**: Keep your `init.lua` here. Remember to run `pip install pynvim` for Python support.
There are another posts where I show my nvim mods on reddit: [nvim feature](https://www.reddit.com/r/neovim/comments/1r518sg/comment/o9fn15l/?context=3) and [rice](https://www.reddit.com/r/LinuxPorn/comments/1r8duka/neovim_my_modified_gruvbox_neovim/).
The dots for linux are on [chewwallwa/dotfiles](https://github.com/chewwallwa/dotfiles) and were adapted for windows here (under test).

### Windows Terminal

* You can config manually on `Ctrl + ,` > Defaults > Appearance or substitute this file by my dot:
* **Path**: `C:\Users\[USER]\AppData\Local\Packages\Microsoft.WindowsTerminal_[SOMETHING]\LocalState\settings.json`

---

## System Font & UI (Winaero Tweaker)

1. **Unzip Winaero**: Unzip the Winaero RAR directly to your local disk **C:**. *Do not unzip inside a user folder* as it may cause permission issues.
2. **Set the Font**: Open `WinaeroTweaker.exe` and navigate to **Advanced Appearance Settings**. Chiange the font to **Iosevka** for the following:
    * Menus
    * Message font
    * Statusbar font
    * System font
    * Window title bars

---

## Workflow Fixes on Registry (If you have removed notepad and installed neovim) 

Download and run the two `.reg` files and execute it.


