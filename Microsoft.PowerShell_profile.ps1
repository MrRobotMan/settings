Set-Alias wher where.exe
Set-Alias coffee Invoke-ItemSites
Set-Alias op Invoke-Item
Set-Alias off Stop-Computer
Set-Alias cppa Copy-Path

function prompt {
    Write-Host "`n $env:COMPUTERNAME" -NoNewline -ForegroundColor DarkGreen
    Write-Host " in " -NoNewline
    Write-Host $(Get-Location) -ForegroundColor DarkRed
    return ">> "
}

function Copy-Path {
    Set-Clipboard (Get-Location).Path
}

function Activate {
    $folders = "venv", ".venv", "env", ".env"
    foreach ($folder in $folders) {
        try {
            Invoke-Expression .\$folder\Scripts\activate
            return
        }
        catch [System.Management.Automation.CommandNotFoundException] {
            continue
        }
    }
    Write-Host "Not virtual environment found"
}

function Update-PIPPackages {
    # Finds and updates all PIP packages.
    py -m pip install --upgrade pip
    foreach ($package in (pip list --outdated --format=freeze)) {
        pip install -U $package.Substring(0, $package.IndexOf("="))
    }
}

function Invoke-ItemSites {
    param (
        [string]$sites
    )

    $news = @("https://meh.com/", "https://woot.com/", "https://lifehacker.com/", "https://gizmodo.com/", "https://arstechnica.com/")
    $comics = @("https://gocomics.com/mycomics/1187379", "https://xkcd.com/", "https://satwcomic.com/latest",
        "http://bearnutscomic.com/", "https://buttersafe.com/", "https://thefarside.com/", "http://poorlydrawnlines.com/",
        "https://webtoons.com/en/challenge/system32comics/list?title_no=235074&page=1", "https://www.stbeals.com")

    $all = $news + $comics 
    $default = ($comics, $news)

    switch ($sites) {
        news { Invoke-ItemList $news; Break }
        comics { Invoke-ItemList $comics; Break }
        all {Invoke-ItemList $all; break}
        default {
            foreach ($sitelist in $default) {
                Invoke-ItemList $sitelist;
                if ($sitelist[0] -ne $default[-1][0]) {
                    Write-Host 'Press Enter to continue...' -NoNewline
                    $host.UI.ReadLine()
                }
            }
        }
    }
}

function Invoke-ItemList ([String[]]$sites) {
    ForEach ($site in $sites) {
        Start-Process $site
    }
}


function unzip {
    param (
        [Parameter(Mandatory = $true)][string]$Zipfile,
        [Parameter(Mandatory = $false)][string]$Directory
    )
    $parent = Split-Path $Zipfile -Resolve
    if (!($Directory)) {
        $Directory = (Get-Item $Zipfile).Basename
        $output = (Join-Path -Path $parent -ChildPath $Directory)
    }
    else {
        $output = $Directory
    }
    Expand-Archive $Zipfile $output
    Remove-Item $Zipfile
    <#
    .SYNOPSIS

    Unzips the Zipfile to the Directory and then deletes the Zipfile.

    .PARAMETER Zipfile
    Specifies the file name and path of the .zip file.

    .PARAMETER Directory
    Specifies the destination directory. -Zipfile is the default.

    .DESCRIPTION

    Unzips the Zipfile to the Directory and then deletes the Zipfile.
    The Directory is placed in the same location as the Zipfile.
    If Directory is omitted it uses the same name as the Zipfile.

    .OUTPUTS
    None.

    .LINK
    Expand-Archive
    Remove-Item

    .EXAMPLE
    PS> unzip .\test.zip

    .EXAMPLE
    PS> unzip .\test.zip "output"

    .EXAMPLE
    PS> unzip -Zipfile .\test.zip -Directory "output"
    #>

}

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\settings\starship.toml"
