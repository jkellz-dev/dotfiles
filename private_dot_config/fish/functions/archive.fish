function archive --description "archive file or directory"
    switch $argv[1]
        case s6
            set dest singularity6
        case wotc
            set dest wotc
        case web
            set dest "web\ dev"
        case '*'
            echo must specify valid destination
            return 1
    end
    echo "moving to $dest"
    mv $argv[2] $HOME/archive/$dest/
end
