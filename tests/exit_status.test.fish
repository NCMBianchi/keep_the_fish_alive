source (status dirname)/helpers.fish
cd (mktemp -d)

@echo "fish symbol"
@test "alive fish after success" (ktfa_left 0 | string sub -l 4) = "⋊≡°>"
@test "dead fish after error" (ktfa_left 1 | string sub -l 4) = "⋊≡⁎>"

@echo "exit code {N}"
@test "{0} after success" (ktfa_both 0 | string match -r '^\{\d+\}') = "{0}"
@test "{1} after error" (ktfa_both 1 | string match -r '^\{\d+\}') = "{1}"
@test "{127} after unknown command" (ktfa_both 127 | string match -r '^\{\d+\}') = "{127}"
@test "right prompt alone falls back to \$status" (
    set -e __ktfa_last_status
    ktfa_right 2 | string match -r '^\{\d+\}'
) = "{2}"

@echo "exit code {N} with conda's prompt wrappers"
ktfa_wrap_like_conda
@test "conda: {0} after success" (ktfa_both 0 | string match -r '^\{\d+\}') = "{0}"
@test "conda: {1} after error" (ktfa_both 1 | string match -r '^\{\d+\}') = "{1}"
@test "conda: {127} after unknown command" (ktfa_both 127 | string match -r '^\{\d+\}') = "{127}"
@test "conda: dead fish after error" (ktfa_left 1 | string sub -l 4) = "⋊≡⁎>"
