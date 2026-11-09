source (status dirname)/helpers.fish

# Real repository: theme_short_path calls `git rev-parse --show-toplevel`.
# realpath: on macOS mktemp returns /var/..., a symlink to /private/var/...
set -l repo (realpath (mktemp -d))/myrepo
mkdir -p $repo/sub/dir
command git -C $repo init -q
cd $repo/sub/dir

# Stubbed omf git helpers report a clean repository on branch main
function git_is_repo
    return 0
end

@echo git
@test "[git] in right prompt" (ktfa_both 0 | string match -q '*[git]*') $status -eq 0
@test "branch shown" (ktfa_left 0 | string match -q '* on main *') $status -eq 0
@test "clean and in sync: ◦" (ktfa_left 0 | string match -q '* on main ◦ ') $status -eq 0

function git_is_touched
    return 0
end
@test "dirty: ⨯" (ktfa_left 0 | string match -q '* on main ⨯ ') $status -eq 0

function git_is_stashed
    return 0
end
set -g theme_stash_indicator yes
@test "stash indicator: ≡ before ⨯" (ktfa_left 0 | string match -q '* on main ≡ ⨯ ') $status -eq 0

@echo theme_short_path
set -g theme_short_path yes
@test "path from the repository folder down" (ktfa_left 0 | string match -q '⋊≡°> myrepo/sub/dir on main*') $status -eq 0

cd $repo
@test "repository root: folder name only" (ktfa_left 0 | string match -q '⋊≡°> myrepo on main*') $status -eq 0
