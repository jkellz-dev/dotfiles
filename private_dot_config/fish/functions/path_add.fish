function path_add --description "adds a path element to \$fish_user_paths"
    contains -- $argv $fish_user_paths
    or set -U fish_user_paths $fish_user_paths $argv
    echo "Updated PATH: $PATH"
end
