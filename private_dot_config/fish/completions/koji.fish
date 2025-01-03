# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_koji_global_optspecs
	string join \n autocomplete= breaking-changes= c/config= emoji= hook issues= S/sign= a/all h/help V/version
end

function __fish_koji_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_koji_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_koji_using_subcommand
	set -l cmd (__fish_koji_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c koji -n "__fish_koji_needs_command" -l autocomplete -d 'Enables autocomplete for scope prompt via scanning commit history' -r -f -a "{true\t'',false\t''}"
complete -c koji -n "__fish_koji_needs_command" -l breaking-changes -d 'Enables breaking change prompts, one of them for adding the BREAKING CHANGE footer' -r -f -a "{true\t'',false\t''}"
complete -c koji -n "__fish_koji_needs_command" -s c -l config -d 'Path to a custom config file' -r
complete -c koji -n "__fish_koji_needs_command" -l emoji -d 'Prepend the commit summary with relevant emoji based on commit type' -r -f -a "{true\t'',false\t''}"
complete -c koji -n "__fish_koji_needs_command" -l issues -d 'Enables issue prompts, to add a footer for issue references' -r -f -a "{true\t'',false\t''}"
complete -c koji -n "__fish_koji_needs_command" -s S -l sign -d 'Sign the commit using the user\'s GPG key, if one is configured' -r -f -a "{true\t'',false\t''}"
complete -c koji -n "__fish_koji_needs_command" -l hook -d 'Run as a git hook, writing the commit message to COMMIT_EDITMSG instead of committing'
complete -c koji -n "__fish_koji_needs_command" -s a -l all -d 'Stage all tracked modified or deleted files'
complete -c koji -n "__fish_koji_needs_command" -s h -l help -d 'Print help'
complete -c koji -n "__fish_koji_needs_command" -s V -l version -d 'Print version'
complete -c koji -n "__fish_koji_needs_command" -f -a "completions" -d 'Generate shell completions'
complete -c koji -n "__fish_koji_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c koji -n "__fish_koji_using_subcommand completions" -s h -l help -d 'Print help'
complete -c koji -n "__fish_koji_using_subcommand help; and not __fish_seen_subcommand_from completions help" -f -a "completions" -d 'Generate shell completions'
complete -c koji -n "__fish_koji_using_subcommand help; and not __fish_seen_subcommand_from completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
