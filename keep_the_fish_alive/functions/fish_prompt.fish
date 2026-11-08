# You can override some default options with config.fish:
#
#  set -g theme_short_path yes
#  set -g theme_stash_indicator yes
#  set -g theme_ignore_ssh_awareness yes

function fish_prompt
  set -l last_command_status $status
  # Share real exit status with fish_right_prompt: wrappers (e.g. conda's
  # fish hook) run `set -q` before the right prompt and reset $status to 0.
  set -g __ktfa_last_status $last_command_status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish     "⋊≡°>"
  set -l deadfish "⋊≡⁎>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄"
  set -l dirty    "⨯"
  set -l stash    "≡"
  set -l none     "◦"

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color cyan)
  set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
  set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)
  set -l ssh_color        (set_color ff8800)  #orange

  # SSH detection (shared with fish_right_prompt via _SSH_SESSION)
  if test "$theme_ignore_ssh_awareness" != 'yes' -a -n "$SSH_CLIENT$SSH_TTY"
    set -g _SSH_SESSION 1
    echo -n -s $ssh_color "(" $USER "@" (prompt_hostname) ") " $normal_color
  else
    set -e _SSH_SESSION
  end

  # Fish symbol: alive after success, dead after an error
  if test $last_command_status -eq 0
    echo -n -s $success_color $fish $normal_color
  else
    echo -n -s $error_color $deadfish $normal_color
  end

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      # Path from the repository folder down, e.g. keep_the_fish_alive/functions
      set -l root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      if string match -q -- "$root_folder*" $PWD
        set cwd (basename $root_folder)(string replace -- $root_folder "" $PWD)
      end
    end

    echo -n -s " " $directory_color $cwd $normal_color
    echo -n -s " on " $repository_color (git_branch_name) $normal_color " "


    set -l list
    if test "$theme_stash_indicator" = yes; and git_is_stashed
      set list $list $stash
    end
    if git_is_touched
      set list $list $dirty
    end
    echo -n $list

    if test -z "$list"
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s " " $directory_color $cwd $normal_color
  end

  echo -n -s " "
end