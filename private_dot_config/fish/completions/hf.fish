# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_hf_global_optspecs
	string join \n log-level= generate-completion= h/help V/version
end

function __fish_hf_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_hf_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_hf_using_subcommand
	set -l cmd (__fish_hf_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c hf -n "__fish_hf_needs_command" -l log-level -d 'The minimum log level to print' -r -f -a "{OFF\t'Lowest log level',ERROR\t'Error log level',WARN\t'Warn log level',INFO\t'Info log level',DEBUG\t'Debug log level',TRACE\t'Trace log level'}"
complete -c hf -n "__fish_hf_needs_command" -l generate-completion -d 'Generate shell completion' -r -f -a "{bash\t'Bash',elvish\t'Elvish',fish\t'fish',nushell\t'Nushell',powershell\t'PowerShell',zsh\t'Zsh'}"
complete -c hf -n "__fish_hf_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c hf -n "__fish_hf_needs_command" -s V -l version -d 'Print version'
complete -c hf -n "__fish_hf_needs_command" -f -a "hide" -d 'Make files or directories invisible'
complete -c hf -n "__fish_hf_needs_command" -f -a "show" -d 'Make hidden files or hidden directories visible'
complete -c hf -n "__fish_hf_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c hf -n "__fish_hf_using_subcommand hide" -l log-level -d 'The minimum log level to print' -r -f -a "{OFF\t'Lowest log level',ERROR\t'Error log level',WARN\t'Warn log level',INFO\t'Info log level',DEBUG\t'Debug log level',TRACE\t'Trace log level'}"
complete -c hf -n "__fish_hf_using_subcommand hide" -s f -l force -d 'Actually hide files or directories'
complete -c hf -n "__fish_hf_using_subcommand hide" -s n -l dry-run -d 'Don\'t actually hide anything, just show what would be done'
complete -c hf -n "__fish_hf_using_subcommand hide" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c hf -n "__fish_hf_using_subcommand hide" -s V -l version -d 'Print version'
complete -c hf -n "__fish_hf_using_subcommand show" -l log-level -d 'The minimum log level to print' -r -f -a "{OFF\t'Lowest log level',ERROR\t'Error log level',WARN\t'Warn log level',INFO\t'Info log level',DEBUG\t'Debug log level',TRACE\t'Trace log level'}"
complete -c hf -n "__fish_hf_using_subcommand show" -s f -l force -d 'Actually show hidden files or hidden directories'
complete -c hf -n "__fish_hf_using_subcommand show" -s n -l dry-run -d 'Don\'t actually show anything, just show what would be done'
complete -c hf -n "__fish_hf_using_subcommand show" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c hf -n "__fish_hf_using_subcommand show" -s V -l version -d 'Print version'
complete -c hf -n "__fish_hf_using_subcommand help; and not __fish_seen_subcommand_from hide show help" -f -a "hide" -d 'Make files or directories invisible'
complete -c hf -n "__fish_hf_using_subcommand help; and not __fish_seen_subcommand_from hide show help" -f -a "show" -d 'Make hidden files or hidden directories visible'
complete -c hf -n "__fish_hf_using_subcommand help; and not __fish_seen_subcommand_from hide show help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
