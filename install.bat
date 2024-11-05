@echo off
:: This script creates symlinks from the home directory to the desired settings files in $HOME\settings
:: And installs software

cd %userprofile%\settings

set "settingsdir=%userprofile%\settings"

:: Create links  
mklink /H %userprofile%\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 PowerShell\Microsoft.Powershell_profile.ps1
mklink /J %appdata%\Helix Helix
mkdir %appdata%\dystroy\bacon\prefs
mklink /H %appdata%\dystroy\bacon\prefs\config.toml bacon\config.toml
mklink .config
mklink /H %userprofile%\.config\starship.toml starship\starship.toml

set "progs=Bitwarden.Bitwarden 7zip.7zip Git.Git Logiech.OptionsPlus Mozilla.Firefox VideoLAN.VLC OpenJS.NodeJS"
set "progs=%progs%;TheDocumentFoundation.LibreOffice calibre.calibre Box.Box Foxit.FoxitReader"
set "progs=%progs%;Valve.Steam AOMEI.Backupper.Standard Microsoft.PowerShell Bitwarden.CLI Discord.Discord"
set "progs=%progs%;FreeCAD.FreeCAD Helix.Helix astral-sh.ruff astral-sh.uv Microsoft.WindowsTerminal"
set "progs=%progs%;Microsoft.VisualStudio.2022.BuildTools Rustlang.Rustup"

:: Install programs
for %%p in (%progs%) do (
 winget install %%p
)

:: install nerdfont
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git
$loc = Get-Location
Set-Location nerd-fonts
./install Inconsolata
Set-Location $loc
Remove-Item -Force -Recurse nerd-fonts

:: Install Python
C:\Users\dweis\AppData\Local\Microsoft\WinGet\Packages\astral-sh.uv_Microsoft.Winget.Source_8wekyb3d8bbwe\uv.exe python install 3.13

:: Install language servers and formatters
for %%p in (prettier pyright typescript-language-server) do (
 "c:\Program Files\NodeJS\npm.cmd" install -g %%p
)
%userprofile%\.cargo\bin\cargo.exe install --git https://github.com/estim/simple-completion-language-server.git

:: Install Rust programs
for %%p in (bacon du-dust speedtest-rs starship) do (
 %userprofile%\.cargo\bin\cargo.exe install %%P
)

:: Log in to bitwarden
C:\Users\dweis\AppData\Local\Microsoft\WinGet\Packages\Bitwarden.CLI_Microsoft.Winget.Source_8wekyb3d8bbwe\bw.exe login
