function surreal_shell --description "SurrealDB shell hosted via podman"
    podman exec -it surreal /surreal sql -e http://localhost:8000 -u root -p root --ns test --db test --pretty
end
