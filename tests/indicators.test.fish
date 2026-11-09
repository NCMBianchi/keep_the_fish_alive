source (status dirname)/helpers.fish

# Each test gets its own empty directory
function in_empty_dir
    cd (mktemp -d)
end

@echo "right prompt indicators"
in_empty_dir
@test "no indicators in an empty directory" (ktfa_both 0 | string match -q '*[*') $status -eq 1
@test "time at the end" (ktfa_both 0 | string match -rq '\d\d:\d\d:\d\d$') $status -eq 0

@test "[venv] with VIRTUAL_ENV" (
    set -lx VIRTUAL_ENV /tmp/venv
    ktfa_both 0 | string match -q '*[venv]*'
) $status -eq 0

@test "[conda] with CONDA_DEFAULT_ENV" (
    set -lx CONDA_DEFAULT_ENV base
    ktfa_both 0 | string match -q '*[conda]*'
) $status -eq 0

@test "no [conda] with empty CONDA_DEFAULT_ENV" (
    set -lx CONDA_DEFAULT_ENV ""
    ktfa_both 0 | string match -q '*[conda]*'
) $status -eq 1

for f in bun.lock bun.lockb bunfig.toml
    in_empty_dir
    touch $f
    @test "[bun] with $f" (ktfa_both 0 | string match -q '*[bun]*') $status -eq 0
end

in_empty_dir
touch package.json index.js package-lock.json
@test "[node.js] with package.json, index.js, lockfile" (ktfa_both 0 | string match -q '*[node.js]*') $status -eq 0

in_empty_dir
touch package.json
@test "no [node.js] with package.json only" (ktfa_both 0 | string match -q '*[node.js]*') $status -eq 1
