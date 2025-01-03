# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_mdsf_global_optspecs
	string join \n h/help V/version
end

function __fish_mdsf_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_mdsf_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_mdsf_using_subcommand
	set -l cmd (__fish_mdsf_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c mdsf -n "__fish_mdsf_needs_command" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_needs_command" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "format" -d 'Run formatters on input files'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "verify" -d 'Verify files are formatted'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "init" -d 'Create a new mdsf config'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "completions" -d 'Generate shell completion'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "cache-prune" -d 'Remove old caches'
complete -c mdsf -n "__fish_mdsf_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -l config -d 'Path to config' -r -F
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -l log-level -r -f -a "{trace\t'',debug\t'',info\t'',warn\t'',error\t'',off\t''}"
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -l threads -d 'Amount of threads to use. Defaults to 0 (auto)' -r
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -l debug -d 'Log stdout and stderr of formatters'
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -l cache -d 'Only format changed codeblocks'
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_using_subcommand format" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -l config -d 'Path to config' -r -F
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -l log-level -r -f -a "{trace\t'',debug\t'',info\t'',warn\t'',error\t'',off\t''}"
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -l threads -d 'Amount of threads to use. Defaults to 0 (auto)' -r
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -l debug -d 'Log stdout and stderr of formatters'
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_using_subcommand verify" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_using_subcommand init" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_using_subcommand init" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_using_subcommand completions" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_using_subcommand completions" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_using_subcommand cache-prune" -l all -d 'Remove caches that aren\'t state (based on config)'
complete -c mdsf -n "__fish_mdsf_using_subcommand cache-prune" -s h -l help -d 'Print help'
complete -c mdsf -n "__fish_mdsf_using_subcommand cache-prune" -s V -l version -d 'Print version'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "format" -d 'Run formatters on input files'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "verify" -d 'Verify files are formatted'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "init" -d 'Create a new mdsf config'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "completions" -d 'Generate shell completion'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "cache-prune" -d 'Remove old caches'
complete -c mdsf -n "__fish_mdsf_using_subcommand help; and not __fish_seen_subcommand_from format verify init completions cache-prune help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
