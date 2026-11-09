source (status dirname)/helpers.fish
cd (mktemp -d)

@echo "SSH awareness"
@test "no SSH: prompt starts with the fish" (ktfa_left 0 | string sub -l 4) = "⋊≡°>"
@test "no SSH: no [SSH] in right prompt" (ktfa_both 0 | string match -q '*[SSH]*') $status -eq 1

set -gx SSH_TTY /dev/pts/0
@test "SSH: (user@host) before the fish" (
    ktfa_left 0 | string match -q "($USER@"(prompt_hostname)") ⋊≡°>*"
) $status -eq 0
@test "SSH: [SSH] in right prompt" (ktfa_both 0 | string match -q '*[SSH]*') $status -eq 0

set -g theme_ignore_ssh_awareness yes
@test "SSH ignored: no (user@host)" (ktfa_left 0 | string sub -l 4) = "⋊≡°>"
@test "SSH ignored: no [SSH] in right prompt" (ktfa_both 0 | string match -q '*[SSH]*') $status -eq 1
