# Dotfiles

These dotfiles are managed by Chezmoi. When initializing a new machine, install Chezmoi first, then proceed to allow Chezmoi to install all required dependencies.

- [Chezmoi Install](https://www.chezmoi.io/install/)

Once installed, initialize the dotfiles using the following command:

```bash
chezmoi init git@github.com:jkellz-dev/dotfiles.git --apply
```

## Templates

All templates use the [Golang Template Syntax](https://pkg.go.dev/text/template) with [Sprig Extensions](https://masterminds.github.io/sprig/).

## Manual Steps

- [Netcoredbg](https://github.com/Samsung/netcoredbg)
