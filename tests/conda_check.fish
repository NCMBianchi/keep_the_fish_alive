# Exit code {N} under a REAL conda installation (not the simulated wrapper
# in helpers.fish). Run in a fresh shell after `conda init fish`, with the
# theme in fish's function path:
#
#   fish tests/conda_check.fish
#
# Exits 1 if conda did not wrap the right prompt or if {N} is wrong.

function ktfa_return
    return $argv[1]
end

functions fish_right_prompt | string match -q '*__fish_right_prompt_orig*'
or begin
    echo "conda did not wrap fish_right_prompt: check \`conda init fish\`"
    exit 1
end

set -l failed 0
for expected in 0 1 2 127
    ktfa_return $expected
    fish_prompt >/dev/null
    # fish restores $status before drawing the right prompt
    ktfa_return $expected
    set -l shown (fish_right_prompt | string replace -ra '\e\[[0-9;]*m|\e\(B' '' | string match -r '\{\d+\}')
    if test "$shown" = "{$expected}"
        echo "ok: exit $expected -> $shown"
    else
        echo "FAIL: exit $expected -> $shown (expected {$expected})"
        set failed 1
    end
end
exit $failed
