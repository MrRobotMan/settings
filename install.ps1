##########################
# This script creates symlinks from the home directory to the desired settings files in $HOME\settings
# And installs software
##########################

# Settings directory
$settingsdir = "$($HOME)\settings"

# Settings to be symlinked
$files = @(@("Microsoft.PowerShell_profile.ps1", "$HOME\OneDrive\Documents\PowerShell"), @("empty", "empty"))
$dirs = @("helix", "nushell")

# Move to the settings directory
Write-Host "Changing current directory to $settingsdir"
try {Set-Location $settingsdir -ErrorAction Stop} 
catch {write-host "Could not change to $settingsdir"; return}

# Create symlinks for files
foreach ($file in $files) {
  Write-Host "Creating symlink for $file"
  mklink /H "$($file[1])" "$HOME\$($file[0])"
}

# Create symlinks for directories
foreach ($dir in $dirs) {
  Write-Host "Creating symlink for $dir"
  mklink /H /J "$HOME\AppData\Roaming\$dir" $dir
}

# install nerdfont
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git
$loc = Get-Location
Set-Location nerd-fonts
./install Inconsolata
Set-Location $loc
Remove-Item -Force -Recurse nerd-fonts
