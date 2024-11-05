# Development Environment Setup

This repository contains scripts and configuration files to set up a my windows systems.

## Overview

The setup includes automated scripts for installing essential software, configuring Powershell and Nu shells, and setting up Helix and Visual Studio Code editors.

## Important Note Before Installation

**WARNING:** The configurations and scripts in this repository are **HIGHLY PERSONALIZED** to my own preferences and workflows. If you decide to use them, please be aware that they will **MODIFY** your current system, potentially making some changes that are **IRREVERSIBLE** without a fresh installation of your operating system.

Furthermore, while I strive to backup files wherever possible, I cannot guarantee that all files are backed up. The backup mechanism is designed to backup SOME files **ONCE**. If the script is run more than once, the initial backups will be **OVERWRITTEN**, potentially resulting in loss of data. While I could implement timestamped backups to preserve multiple versions, this setup is optimized for my personal use, and a single backup suffices for me.

If you would like an environment similar to mine, I highly encourage you to fork this repository and make your own personalized changes to these scripts instead of running them exactly as I have them written for myself.

A less serious (but potentially annoying) change it will make is setting the Desktop background to the image I use in my tutorials. This is the script I use to set up machines I will be recording on, after all.

If you choose to run these scripts, please do so with **EXTREME CAUTION**. It's recommended to review the scripts and understand the changes they will make to your system before proceeding.

By using these scripts, you acknowledge and accept the risk of potential data loss or system alteration. Proceed at your own risk.

## Getting Started

### Prerequisites

- Windows 11 (The scripts are tailored for Windows)

### Installation

1. Clone the repository to your local machine:
   ```sh
   git clone https://github.com/MrRobotMan/settings.git ~/settings
     ```
2. Navigate to the `settings` directory:
   ```sh
   cd ~/settings
   ```
3. Run the installation script:
   ```sh
   ./install.ps1
     ```

This script will:

- Create symlinks for settings (`.\helix`, `.\nushell`, etc.)
- Configure Visual Studio Code
- Set wallpaper and various other Windows settings

## Configuration Files

- `.bashrc` & `.zshrc`: Shell configuration files for Bash and Zsh.
- `.shared_prompt`: Custom prompt setup used by both `.bash_prompt` & `.zprompt`
- `.bash_prompt` & `.zprompt`: Custom prompt setup for Bash and Zsh.
- `.bash_profile: Setting system-wide environment variables
- `.aliases`: Aliases for common commands. Some are personalized to my machines specifically (e.g. the 'yt' alias opening my YouTube Scripts')
- `.private`: This is a file you'll create locally to hold private information and shouldn't be uploaded to version control
- `settings/`: Directory containing editor settings and themes for Sublime Text and Visual Studio Code.

## Contributing

Feel free to fork this repository and customize it for your setup. Pull requests for improvements and bug fixes are welcome, but I likely won't accept pull requests that simply add additional installations or change some settings unless they align with my personal preferences.

## License

This project is licensed under the MIT License - see the [LICENSE-MIT.txt](LICENSE-MIT.txt) file for details.

## Acknowledgments

- I originally forked this from [Corey Schafer's dotfiles](https://github.com/CoreyMSchafer/dotfiles.git) who forked it from [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- Thanks to all the open-source projects used in this setup.
