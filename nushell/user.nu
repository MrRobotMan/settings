# Immediately turn off the computer
export def off []: nothing -> nothing {
    shutdown /P
}


# Split the current terminal vertically. 
export def vsplit [] {
    wt -w 0 sp -p 'Nushell' -V -d .  
}


# Open a list of websites with your morning coffee
export def coffee [sites?: string]: nothing -> nothing {
    let news = [
        "https://meh.com/" 
        "https://woot.com/" 
        "https://lifehacker.com/" 
        "https://gizmodo.com/" 
        "https://arstechnica.com/"
        ]
    let comics = [
        "https://gocomics.com/mycomics/1187379" 
        "https://xkcd.com/" 
        "https://satwcomic.com/latest"
        "http://bearnutscomic.com/"
        "https://buttersafe.com/" 
        "https://thefarside.com/" 
        "http://poorlydrawnlines.com/" 
        ]

    let default = [$comics , $news]

    match $sites {
        news => ($news | enumerate | launch),
        comics => ($comics |enumerate | launch),
        all => ($comics | append $news | enumerate | launch),
        _ => {
            for $it in ($default | enumerate) {
                ($it.item | enumerate | launch)
                if $it.index != ($default | length) - 1 {
                  try {input "Press Enter to continue..."};
                }
            }
        }
    }
}

# Launch a list of sites in the browser
def launch [] -> nothing {
    each {|site| 
        start $site.item
        if $site.index == 0 {
            sleep 2sec
        }
    }
    return
}

# Unzip and optionally delete an archive
export def unzip [
    file: string  # Archive to unzip
    outdir?: string  # Directory to unzip into
    --delete (-d)  # Deletes the archive after unzipping
]: nothing -> string {
    let parent = ($file | path dirname)
    let outdir = if ($outdir == null) {
        $parent | path join ($file | path parse | get stem)
    } else {
        $outdir
    }
    7z e $"-o($outdir)" $file 
    if $delete {rm $file}
    $outdir 
}

# Search bitwarden for login info.
export def bitwarden [search_key: string] {
    bw list items --search $search_key | ConvertFrom-Json | Select @{n="Username"; e={$_.login.username}}, @{n="Password"; e={$_.login.password}}}

