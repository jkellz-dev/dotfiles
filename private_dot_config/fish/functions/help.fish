function help -d "wraps help call in bat"
    $argv --help | bat --plain --language=help
end
