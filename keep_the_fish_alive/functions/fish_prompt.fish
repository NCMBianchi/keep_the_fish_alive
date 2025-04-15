# You can override some default options with config.fish:
#
#  set -g theme_short_path yes
#  set -g theme_stash_indicator yes
#  set -g theme_ignore_ssh_awareness yes

function fish_prompt
  set -l last_command_status $status
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

  # First display of prompt symbol - only show if not in SSH
  set -l in_ssh_session 0
  if test "$theme_ignore_ssh_awareness" != 'yes' -a -n "$SSH_CLIENT$SSH_TTY"
    set -g _SSH_SESSION 1
    set in_ssh_session 1
  else
    set -e _SSH_SESSION
  end
  
  # Only show the first prompt if not in SSH
  if test $in_ssh_session -eq 0
    if test $last_command_status -eq 0
      set -l prompt_string $fish
      echo -n -s $success_color $prompt_string $normal_color
    else
      set -l prompt_string $deadfish
      echo -n -s $error_color $prompt_string $normal_color
    end
  end

  # SSH info display (if in SSH)
  if test $in_ssh_session -eq 1
    echo -n -s $ssh_color"("(whoami)"@"(hostname -s)") " $normal_color
  end

  # Second display of prompt symbol - only show if in SSH
  if test $in_ssh_session -eq 1
    if test $last_command_status -eq 0
      set -l prompt_string $fish
      echo -n -s $success_color $prompt_string $normal_color
    else
      set -l prompt_string $deadfish
      echo -n -s $error_color $prompt_string $normal_color
    end
  end

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
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