function du --wraps=pdu --description 'renders a graphical chart for disk usages of files and directories'
    pdu --top-down $argv
end
