# Shared setup for the fishtape tests: source with
#   source (status dirname)/helpers.fish
#
# Loads the theme, stubs the omf git helpers (so tests run without omf
# installed) and clears environment variables the prompts react to.

set -g ktfa_root (realpath (status dirname)/..)
source $ktfa_root/functions/fish_prompt.fish
source $ktfa_root/functions/fish_right_prompt.fish

# omf git helpers (lib/git in oh-my-fish): default to "not a git repo"
function git_is_repo
    return 1
end
function git_branch_name
    echo main
end
function git_is_touched
    return 1
end
function git_is_stashed
    return 1
end
function git_ahead
    echo ◦
end

set -e SSH_CLIENT SSH_TTY VIRTUAL_ENV CONDA_DEFAULT_ENV CONDA_LEFT_PROMPT _SSH_SESSION __ktfa_last_status
set -e theme_short_path theme_stash_indicator theme_ignore_ssh_awareness

# Set $status to $argv[1] for the next command
function ktfa_return
    return $argv[1]
end

# ANSI colour codes, removed from rendered prompts.
# Piped directly into `string`: `string` inside a helper function does not
# read stdin piped into that function.
set -g ktfa_ansi '\e\[[0-9;]*m|\e\(B'

# Render a prompt after a command that exited with $argv[1], colours removed
function ktfa_left -a last_status
    ktfa_return $last_status
    fish_prompt | string replace -ra -- $ktfa_ansi ''
end

function ktfa_right -a last_status
    ktfa_return $last_status
    fish_right_prompt | string replace -ra -- $ktfa_ansi ''
end

# Like fish itself: left prompt first, then right prompt, same $status
function ktfa_both -a last_status
    ktfa_left $last_status >/dev/null
    ktfa_right $last_status
end

# Reproduce conda's fish hook (`conda shell.fish hook`): it renames the theme
# functions and wraps them; the right wrapper runs `set -q` before calling
# the theme, which resets $status to 0.
function ktfa_wrap_like_conda
    # fishtape runs each file with the user's config: a real conda hook may
    # already have defined these
    functions -e __fish_prompt_orig __fish_right_prompt_orig
    functions -c fish_prompt __fish_prompt_orig
    functions -c fish_right_prompt __fish_right_prompt_orig
    set -g CONDA_LEFT_PROMPT 0
    function fish_prompt
        set -l last_status $status
        if set -q CONDA_LEFT_PROMPT
            true
        end
        ktfa_return $last_status
        __fish_prompt_orig
    end
    function fish_right_prompt
        if not set -q CONDA_LEFT_PROMPT
            true
        end
        __fish_right_prompt_orig
    end
end
