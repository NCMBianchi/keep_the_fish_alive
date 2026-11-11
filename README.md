# 'Keep The Fish Alive' custom theme for OhMyFish
[![CI](https://github.com/NCMBianchi/keep_the_fish_alive/actions/workflows/ci.yml/badge.svg)](https://github.com/NCMBianchi/keep_the_fish_alive/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/NCMBianchi/keep_the_fish_alive)](https://github.com/NCMBianchi/keep_the_fish_alive/releases)
[![fish](https://img.shields.io/badge/fish-%E2%89%A5%203.3-blue)](https://fishshell.com)
[![omf](https://img.shields.io/badge/omf-v7%20%7C%20v8-blue)](https://github.com/oh-my-fish/oh-my-fish)
[![omf listing](https://img.shields.io/badge/omf%20listing-listed-green)](https://github.com/oh-my-fish/packages-main/blob/master/packages/keep_the_fish_alive)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](https://github.com/NCMBianchi/keep_the_fish_alive/blob/main/LICENSE.txt)

My own take on the default [OhMyFish theme](https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md): it turns `⋊> ~` into `⋊≡°> ~`. Moreover, it turns into `⋊≡⁎> ~` after an error -mimicking a dead fish- and it adds standardised information on project directories (<i>i.e.</i> git, node.js and bun) and virtual environments (<i>i.e.</i> Python venv, conda env).

![omf_theme-3](figures/omf_theme-3.jpg)

This theme was optimised for the [Ghostty](https://ghostty.org) terminal emulator, with the 'Afterglow' color theme.

## Requirements
The [fish](https://fishshell.com) shell and [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) (omf):

| | fish | omf |
|---|---|---|
| macOS | `brew install fish` ([homebrew](https://brew.sh)) | `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install \| fish` |
| Arch Linux | `sudo pacman -S fish` | `curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install \| fish` (or the AUR package `oh-my-fish`) |

## Installation (MacOS, Linux)
The theme is listed in the [official omf package repository](https://github.com/oh-my-fish/packages-main):

```fish
omf install keep_the_fish_alive
```

`omf install` also switches to the theme; to switch back to it later, `omf theme keep_the_fish_alive`. To update: `omf update keep_the_fish_alive`.

> Use the name, not the URL: for URLs (`omf install https://github.com/...`), omf only recognises a theme if `fish_prompt.fish` is at the repository root, otherwise it installs it as a plugin.

Alternatively, clone the repository directly into omf's themes directory: `~/.local/share/omf/themes/` (more precisely `$OMF_PATH/themes/`, which differs only if `$XDG_DATA_HOME` or `$OMF_PATH` were changed), and update it with `git -C $OMF_PATH/themes/keep_the_fish_alive pull`:

```fish
git clone https://github.com/NCMBianchi/keep_the_fish_alive.git $OMF_PATH/themes/keep_the_fish_alive
omf theme keep_the_fish_alive
```

## Tests
Tests use [fishtape](https://github.com/jorgebucaran/fishtape) 3.x (`fisher install jorgebucaran/fishtape`) and need fish 3.3 or later:
```fish
fishtape tests/*.test.fish
```

CI also runs the tests on the oldest supported fish versions (Ubuntu 22.04 and 24.04 packages), checks the exit code with a real conda installation (`tests/conda_check.fish`), and installs the theme with omf as described above.

## License
This project is licensed under the MIT License. Feel free to use and modify the code as per your needs.
