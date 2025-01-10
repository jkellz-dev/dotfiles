abbr -a -- ... 'cd ../../'
abbr -a -- .... 'cd ../../../'
abbr -a -- b bat
abbr -a -- c cat
abbr -a -- cm chezmoi
abbr -a -- cp 'cp -i'
abbr -a -- do doctl
abbr -a -- docker podman
abbr -a -- eks eksctl
abbr -a -- h history
abbr -a -- kc kubectl
abbr -a -- kx kubectx
abbr -a -- lg lazygit
abbr -a -- lzd lazydocker
abbr -a -- mkdir 'mkdir -p'
abbr -a -- mp multipass
abbr -a -- mv 'mv -i'
abbr -a -- pc podman-compose
abbr -a -- pm podman
abbr -a -- rm 'rm -i'
abbr -a -- tf tofu
abbr -a -- tg terragrunt
abbr -a -- tp telepresence
abbr -a --position anywhere -- ts tailscale
abbr -a -- vim nvim
abbr -a -- which 'type -a'
abbr -a --position anywhere --function last_history_item -- !!
abbr -a --position anywhere --set-cursor='%' -- L '% | less'

# Jujutsu
abbr -a j jj
abbr -a jbl 'jj bookmark list'
abbr -a jbm --set-cursor 'jj bookmark move % --to @-'
abbr -a jbmm 'jj bookmark move main --to @-'
abbr -a jc 'jj commit'
abbr -a jcc 'jj commit -m "$(koji --stdout)"'
abbr -a jd --set-cursor 'jj desc -m "%"'
abbr -a jdf 'jj diff'
abbr -a je --set-cursor 'jj edit %'
abbr -a jgf 'jj git fetch'
abbr -a jgp 'jj git push'
abbr -a jk 'jj desc -m "$(koji --stdout)"'
abbr -a jl 'jj log'
abbr -a jn --set-cursor 'jj new %'
abbr -a jr --set-cursor 'jj rebase -s % -d @-'
abbr -a js 'jj status'
