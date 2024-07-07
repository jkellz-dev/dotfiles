function mmdc --description 'wrapper around podman to create mermaid charts'
    if test $argv[1] = -h
        podman run --userns keep-id --user $EUID --rm ghcr.io/mermaid-js/mermaid-cli/mermaid-cli -h
    else
        podman run --userns keep-id --user $EUID --rm -v (pwd):/data:z ghcr.io/mermaid-js/mermaid-cli/mermaid-cli -i $argv[1] $argv[2..-1]
    end
end
