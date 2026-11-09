# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0-dev]

### Added
- `tests/`: [fishtape](https://github.com/jorgebucaran/fishtape) tests for the fish symbol, exit code `{N}` (including conda's prompt wrappers), SSH awareness, right prompt indicators, git status and `theme_short_path`
- `.github/workflows/ci.yml`: syntax and `fish_indent` format checks, tests on Ubuntu and macOS, omf installation check following the README
- README: CI badge

### Changed
- theme files moved from `keep_the_fish_alive/functions/` to `functions/` at the repository root, the standard omf theme directory structure
- README: installation by cloning directly into `$OMF_PATH/themes/keep_the_fish_alive`, updates via `git pull`
- theme files formatted with `fish_indent` (4-space indentation, fish standard)

## [1.0.1] - 2026-11-08

### Added
- `figures/` directory with the README example image, previously hosted as a GitHub attachment

### Fixed
- error code in the right-justified elements always showing `{0}`: conda's `fish_right_prompt` wrapper runs `set -q` before calling the theme, resetting `$status`; `fish_prompt` now stores the last command status in the global `__ktfa_last_status`, read by `fish_right_prompt`
- `[bun]` indicator also detected from `bun.lock` (text lockfile since Bun 1.2)
- `theme_short_path` breaking for repositories directly under `/`
- README installation instructions: the theme is the inner `keep_the_fish_alive/` directory, copied into `$OMF_PATH/themes/`

### Changed
- `[pyenv]` indicator renamed to `[venv]`, as `VIRTUAL_ENV` is set by any Python virtual environment
- SSH prompt logic merged into a single block; `$USER` and `prompt_hostname` instead of `whoami` and `hostname -s`
- `string replace` instead of `sed` for `theme_short_path`
- README: requirements for macOS and Arch Linux
- `.gitignore`: grouped system files, ignored `CLAUDE.md`, `Icon` → `Icon?`

### Removed
- `Icon\r` macOS folder-icon file from the repository

### Known Issues
- `conda activate [env_name]` and `conda deactivate` leading to error 'status code 4' (reported in v1.0, not reproduced since)

## [v1.0] - 2025-04-15

### Added
- `keep_the_fish_alive` directory
- installation instructions
- example image

### Known Issues
- error code not showing in the right-justified elements due to complications on how to show `echo $status` before the new input is available
- `conda activate [env_name]` and `conda deactivate` leading to error 'status code 4'
