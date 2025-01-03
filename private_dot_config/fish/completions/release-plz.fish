# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_release_plz_global_optspecs
	string join \n v/verbose h/help V/version
end

function __fish_release_plz_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_release_plz_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_release_plz_using_subcommand
	set -l cmd (__fish_release_plz_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c release-plz -n "__fish_release_plz_needs_command" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_needs_command" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_needs_command" -s V -l version -d 'Print version'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "update" -d 'Update packages version and changelogs based on commit messages'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "release-pr" -d 'Create a Pull Request representing the next release. The Pull request contains updated packages version and changelog based on commit messages. Close old PRs opened by release-plz, too'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "release" -d 'For each package not published to the cargo registry yet: - create and push upstream a tag in the format of `<package>-v<version>`. - publish the package to the cargo registry'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "generate-completions" -d 'Generate command autocompletions for various shells'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "check-updates" -d 'Check if a newer version of release-plz is available'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "generate-schema" -d 'Write the JSON schema of the release-plz.toml configuration to .schema/latest.json'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "init" -d 'Initialize release-plz for the current GitHub repository, by storing the necessary tokens in the GitHub repository secrets and generating the release-plz.yml GitHub Actions workflow file'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "set-version" -d 'Edit the version of a package in Cargo.toml and changelog. Specify a version with the syntax `<package_name>@<version>`. E.g. `release-plz set-version rand@1.2.3`'
complete -c release-plz -n "__fish_release_plz_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l manifest-path -d 'Path to the Cargo.toml of the project you want to update. If not provided, release-plz will use the Cargo.toml of the current directory. Both Cargo workspaces and single packages are supported' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l registry-manifest-path -d 'Path to the Cargo.toml contained in the released version of the project you want to update. If not provided, the packages of your project will be compared with the ones published in the cargo registry. Normally, this parameter is used only if the published version of your project is already available locally. For example, it could be the path to the project with a `git checkout` on its latest tag. The git history of this project should be behind the one of the project you want to update' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -s p -l package -d 'Package to update. Use it when you want to update a single package rather than all the packages contained in the workspace' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l release-date -d 'Date of the release. Format: %Y-%m-%d. It defaults to current Utc date' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l registry -d 'Registry where the packages are stored. The registry name needs to be present in the Cargo config. If unspecified, the `publish` field of the package manifest is used. If the `publish` field is empty, crates.io is used' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l changelog-config -d 'Path to the git-cliff configuration file. If not provided, `dirs::config_dir()/git-cliff/cliff.toml` is used if present' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l repo-url -d 'GitHub/Gitea repository url where your project is hosted. It is used to generate the changelog release link. It defaults to the url of the default remote' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l config -d 'Path to the release-plz config file. Default: `./release-plz.toml`. If no config file is found, the default configuration is used' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l git-token -l github-token -d 'Git token used to create the pull request' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l backend -d 'Kind of git host where your project is hosted' -r -f -a "{github\t'',gitea\t'',gitlab\t''}"
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l no-changelog -d 'Don\'t create/update changelog'
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -s u -l update-deps -d 'Update all the dependencies in the Cargo.lock file by running `cargo update`. If this flag is not specified, only update the workspace packages by running `cargo update --workspace`'
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -l allow-dirty -d 'Allow dirty working directories to be updated. The uncommitted changes will be part of the update'
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand update" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l manifest-path -d 'Path to the Cargo.toml of the project you want to update. If not provided, release-plz will use the Cargo.toml of the current directory. Both Cargo workspaces and single packages are supported' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l registry-manifest-path -d 'Path to the Cargo.toml contained in the released version of the project you want to update. If not provided, the packages of your project will be compared with the ones published in the cargo registry. Normally, this parameter is used only if the published version of your project is already available locally. For example, it could be the path to the project with a `git checkout` on its latest tag. The git history of this project should be behind the one of the project you want to update' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -s p -l package -d 'Package to update. Use it when you want to update a single package rather than all the packages contained in the workspace' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l release-date -d 'Date of the release. Format: %Y-%m-%d. It defaults to current Utc date' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l registry -d 'Registry where the packages are stored. The registry name needs to be present in the Cargo config. If unspecified, the `publish` field of the package manifest is used. If the `publish` field is empty, crates.io is used' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l changelog-config -d 'Path to the git-cliff configuration file. If not provided, `dirs::config_dir()/git-cliff/cliff.toml` is used if present' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l repo-url -d 'GitHub/Gitea repository url where your project is hosted. It is used to generate the changelog release link. It defaults to the url of the default remote' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l config -d 'Path to the release-plz config file. Default: `./release-plz.toml`. If no config file is found, the default configuration is used' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l git-token -l github-token -d 'Git token used to create the pull request' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l backend -d 'Kind of git host where your project is hosted' -r -f -a "{github\t'',gitea\t'',gitlab\t''}"
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -s o -l output -d 'Output format. If specified, prints the branch, URL and number of the release PR, if any' -r -f -a "{json\t''}"
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l no-changelog -d 'Don\'t create/update changelog'
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -s u -l update-deps -d 'Update all the dependencies in the Cargo.lock file by running `cargo update`. If this flag is not specified, only update the workspace packages by running `cargo update --workspace`'
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -l allow-dirty -d 'Allow dirty working directories to be updated. The uncommitted changes will be part of the update'
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand release-pr" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l manifest-path -d 'Path to the Cargo.toml of the project you want to release. If not provided, release-plz will use the Cargo.toml of the current directory. Both Cargo workspaces and single packages are supported' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l registry -d 'Registry where you want to publish the packages. The registry name needs to be present in the Cargo config. If unspecified, the `publish` field of the package manifest is used. If the `publish` field is empty, crates.io is used' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l token -d 'Token used to publish to the cargo registry. Override the `CARGO_REGISTRY_TOKEN` environment variable, or the `CARGO_REGISTRIES_<NAME>_TOKEN` environment variable, used for registry specified in the `registry` input variable' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l repo-url -d 'GitHub/Gitea/Gitlab repository url where your project is hosted. It is used to create the git release. It defaults to the url of the default remote' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l git-token -d 'Git token used to publish the GitHub/Gitea/GitLab release' -r
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l backend -d 'Kind of git backend' -r -f -a "{github\t'',gitea\t'',gitlab\t''}"
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l config -d 'Path to the release-plz config file. Default: `./release-plz.toml`. If no config file is found, the default configuration is used' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -s o -l output -d 'Output format. If specified, prints the version and the tag of the released packages' -r -f -a "{json\t''}"
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l dry-run -d 'Perform all checks without uploading'
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l no-verify -d 'Don\'t verify the contents by building them. When you pass this flag, `release-plz` adds the `--no-verify` flag to `cargo publish`'
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -l allow-dirty -d 'Allow dirty working directories to be packaged. When you pass this flag, `release-plz` adds the `--allow-dirty` flag to `cargo publish`'
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand release" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c release-plz -n "__fish_release_plz_using_subcommand generate-completions" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand generate-completions" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand check-updates" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand check-updates" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand generate-schema" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand generate-schema" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand init" -l manifest-path -d 'Path to the Cargo.toml of the project you want to update. If not provided, release-plz will use the Cargo.toml of the current directory. Both Cargo workspaces and single packages are supported' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand init" -l no-toml-check -d 'If set, don\'t check if the toml files contain `description` and `license` fields, which are mandatory for crates.io'
complete -c release-plz -n "__fish_release_plz_using_subcommand init" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand init" -s h -l help -d 'Print help'
complete -c release-plz -n "__fish_release_plz_using_subcommand set-version" -l manifest-path -d 'Path to the Cargo.toml of the project you want to update. If not provided, release-plz will use the Cargo.toml of the current directory. Both Cargo workspaces and single packages are supported' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand set-version" -l config -d 'Path to the release-plz config file. Default: `./release-plz.toml`. If no config file is found, the default configuration is used' -r -F
complete -c release-plz -n "__fish_release_plz_using_subcommand set-version" -s v -l verbose -d 'Print source location and additional information in logs. To change the log level, use the `RUST_LOG` environment variable'
complete -c release-plz -n "__fish_release_plz_using_subcommand set-version" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "update" -d 'Update packages version and changelogs based on commit messages'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "release-pr" -d 'Create a Pull Request representing the next release. The Pull request contains updated packages version and changelog based on commit messages. Close old PRs opened by release-plz, too'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "release" -d 'For each package not published to the cargo registry yet: - create and push upstream a tag in the format of `<package>-v<version>`. - publish the package to the cargo registry'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "generate-completions" -d 'Generate command autocompletions for various shells'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "check-updates" -d 'Check if a newer version of release-plz is available'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "generate-schema" -d 'Write the JSON schema of the release-plz.toml configuration to .schema/latest.json'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "init" -d 'Initialize release-plz for the current GitHub repository, by storing the necessary tokens in the GitHub repository secrets and generating the release-plz.yml GitHub Actions workflow file'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "set-version" -d 'Edit the version of a package in Cargo.toml and changelog. Specify a version with the syntax `<package_name>@<version>`. E.g. `release-plz set-version rand@1.2.3`'
complete -c release-plz -n "__fish_release_plz_using_subcommand help; and not __fish_seen_subcommand_from update release-pr release generate-completions check-updates generate-schema init set-version help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
