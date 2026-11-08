# 'Keep The Fish Alive' custom theme for OhMyFish
My own take on the default [OhMyFish theme](https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md): it turns `⋊> ~` into `⋊≡°> ~`. Moreover, it turns into `⋊≡⁎> ~` after an error -mimicking a dead fish- and it adds standardised information on project directories (<i>i.e.</i> git, node.js and bun) and virtual environments (<i>i.e.</i> Python venv, conda env).

![omf_theme-3](figures/omf_theme-3.jpg)

This theme was optimised for the [Ghostty](https://ghostty.org) terminal emulator, with the 'Afterglow' color theme.

## Requirements
The [fish](https://fishshell.com) shell and [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) (omf):

| | fish | omf |
|---|---|---|
| macOS | `brew install fish` ([homebrew](https://brew.sh)) | `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install \| fish` |
| Arch Linux | `sudo pacman -S fish` | `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install \| fish` (or the AUR package `oh-my-fish`) |

## Installation
The theme is the inner `keep_the_fish_alive/` directory of this repository, not the repository itself. It goes in omf's themes directory, which is the same on macOS and Arch Linux: `~/.local/share/omf/themes/` (more precisely `$OMF_PATH/themes/`, which differs only if `$XDG_DATA_HOME` or `$OMF_PATH` were changed).

```fish
git clone https://github.com/NCMBianchi/keep_the_fish_alive.git
cp -r keep_the_fish_alive/keep_the_fish_alive $OMF_PATH/themes/
omf theme keep_the_fish_alive
```

To update, `git pull` in the cloned repository and repeat the `cp`. Alternatively, symlink the directory instead of copying it (`ln -s (realpath keep_the_fish_alive/keep_the_fish_alive) $OMF_PATH/themes/`), so updates apply after `git pull` without copying.

## License
This project is licensed under the MIT License. Feel free to use and modify the code as per your needs.
