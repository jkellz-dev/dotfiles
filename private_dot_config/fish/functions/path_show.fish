function path_show --description "shows the entire \$PATH env var including from \$fish_user_paths"
    echo $PATH | tr " " "\n" | nl
end
