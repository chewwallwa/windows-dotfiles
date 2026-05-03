fastfetch

Set-Alias -Name v -Value nvim
Set-Alias -Name y -Value yazi
Set-Alias -Name python -Value python3
Set-Alias -Name c -Value clear
Set-Alias -Name ff -Value fastfetch

# settings aliases
function neovim { nvim C:\Users\[USER]\AppData\Local\nvim\init.lua }
function wm { nvim "C:\Users\[USER]\.glzr\glazewm\config.yaml" } 
function keybind { nvim $PROFILE } 
