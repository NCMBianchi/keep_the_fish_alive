function fish_right_prompt

  # Show error code if the last command failed
  set -l exit_code $status
  if test $exit_code -ne 0
    set_color -o red
  else
    set_color 666666
  end
  printf '{%d} ' $exit_code

  # Git repository indicator
  if git_is_repo
    set_color blue
    echo -n "[git] "
    set_color normal
  end

  # conda environment indicator
  if set -q CONDA_DEFAULT_ENV
    set -l env_name $CONDA_DEFAULT_ENV
    if test -n "$env_name"
      set_color green
      echo -n "[conda] "
      set_color normal
    end
  end
  
  # pyenv virtual environment indicator
  if set -q VIRTUAL_ENV
    set_color white
    echo -n "[pyenv] "
    set_color normal
  end

  # Node.js project indicator
  if test -f "./package.json"; and test -f "./index.js"; and test \( -d "./node_modules" -o -f "./package-lock.json" -o -f "./yarn.lock" -o -f "./pnpm-lock.yaml" -o -f "./.npmrc" -o -f "./.nvmrc" \)
    set_color yellow
    echo -n "[node.js] "
    set_color normal
  end
  
  # Bun project indicator
  if test -f "./bunfig.toml"; or test -f "./bun.lockb"
    set_color magenta
    echo -n "[bun] "
    set_color normal
  end

  # SSH indicator
  if set -q _SSH_SESSION
    set_color ff8800  # Orange
    echo -n "[SSH] "
    set_color normal
  end

  set_color white
  date "+%H:%M:%S"
  set_color normal
end