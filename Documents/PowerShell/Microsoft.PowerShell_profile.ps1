#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

Function list {eza -lagh}

Set-Alias -Name l -Value list
Set-Alias -Name vim -Value nvim

Invoke-Expression (&starship init powershell)
