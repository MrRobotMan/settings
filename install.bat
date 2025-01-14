@echo off
:: This script creates symlinks from the home directory to the desired settings files in $HOME\settings
:: And installs software

cd %userprofile%
set %settings% = %userprofile%\settings

:: Create links  
echo Creating Symlinks
mkdir %userprofile%\OneDrive\Docuemnts\PowerShell
mklink /H %userprofile%\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 %settings%\PowerShell\Microsoft.Powershell_profile.ps1
mklink /J %appdata%\Helix %settings%\Helix
mkdir %appdata%\dystroy\bacon\prefs
mklink /H %appdata%\dystroy\bacon\prefs\config.toml %settings%\bacon\config.toml
mkdir %userprofile%\.config
mklink /H %userprofile%\.config\starship.toml %settings%\starship\starship.toml
mklink /J %appdata%\calibre %settings%\Calibre


set progs=Bitwarden.Bitwarden 7zip.7zip Git.Git Logiech.OptionsPlus Mozilla.Firefox VideoLAN.VLC OpenJS.NodeJS
set progs=%progs% TheDocumentFoundation.LibreOffice calibre.calibre Box.Box Foxit.FoxitReader
set progs=%progs% Valve.Steam AOMEI.Backupper.Standard Microsoft.PowerShell Bitwarden.CLI Discord.Discord
set progs=%progs% FreeCAD.FreeCAD Helix.Helix astral-sh.ruff astral-sh.uv Microsoft.WindowsTerminal
set progs=%progs% Microsoft.VisualStudio.2022.BuildTools Rustlang.Rustup Microsoft.DotNet.SDK.8

:: Install programs
for %%p in (%progs%) do (
 echo Installing %%p
 winget install %%p
)

:: Update PATH
set "PATH=%ProgramFiles%\Git\cmd;%ProgramFiles%\NodeJS;%userprofile%\.cargo\bin;%LocalAppData%\Microsoft\Winget\Packages\astral-sh.uv_Microsoft.Winget.Source_8wekyb3d8bbwe;Microsoft\WinGet\Packages\Bitwarden.CLI_Microsoft.Winget.Source_8wekyb3d8bbwe;%ProgramFiles%\Powershell\7;%ProgramFiles%\dotnet;%PATH%"

:: install nerdfont
echo Installing Inconsolata Nerd Font
git clone --filter=blob:none --sparse https:\\github.com\ryanoasis\nerd-fonts.git
pwsh -NoProfile -Command "nerd-fonts\install.ps1 Inconsolata" -ExecutionPolicy Bypass
del /Q nerd-fonts

:: Install Python and tools
echo Installing Python
uv python install 3.13

:: Install language servers and formatters
for %%p in (prettier pyright typescript-language-server) do (
 echo Installing %%p
 npm install -g %%p
)

echo Installing simple-completion-language-server
cargo.exe install --git https:\\github.com\estim\simple-completion-language-server.git

echo Installing PowerShellEditorServices
git clone https:\\github.com\PowerShell\PowerShellEditorServices.git
pwsh -NoProfile -Command "Install-Module InvokeBuild -Scope CurrentUser" -ExecutionPolicy Bypass
pwsh -NoProfile -Command "Install-Module platyPS -Scope CurrentUser" -ExecutionPolicy Bypass
cd settings\PowerShellEditorServices
del NuGet.Config
pwsh -NoProfile -Command "Invoke-Build Build"
mv module\PowerShellEditorServices C:\
cd %userprofile%
del /F PowerShellEditorServices


:: Install Rust programs
for %%p in (bacon du-dust speedtest-rs starship) do (
 echo Installing %%p
 cargo.exe install %%P
)

:: Log in to bitwarden
bw login

:: Set up git name
for /F "tokens=*" %%i in ('git config --global --get user.name') do set gh_user=%%i
if "%~gh_user%"=="" (
 set /P gh_user=Enter your FULL NAME for Git configuration: 
 git config --global user.name "%gh_user%"
) else (
 echo "Git user.name exists and is set to %gh_user%. Skipping."
)

:: Set up git email
for /F "tokens=*" %%i in ('git config --global --get user.email') do set gh_email=%%i
if "%~gh_email%" == "" (
 set /P gh_user=Enter your EMAIL for Git configuration: 
 git config --global user.email "%gh_email%"
) else (
 echo "Git user.email exists and is set to %gh_email%. Skipping."
)

:: Use helix as default editor
set /P editor=Do you want to use Helix as your default Git editor [y/n]:
if "%~editor%"=="" git config --global core.editor "hx"
 
:: Update DeDRM
set /P nothing=Download and update (if needed) DeDRM from https://github.com/apprenticeharper/DeDRM_tools/releases/latest
