function cmus-rebuild --description 'rebuilds cmus music library'
    cmus-remote -C clear
    cmus-remote -C "add ~/Music"
    cmus-remote -C "update-cache -f"
end
