function psql --description "executes psql in a container"
    podman exec -it postgres psql $argv
end
