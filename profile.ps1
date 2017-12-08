# Git related staff
#Import-Module posh-git

# Aliases
$vimPath = "C:\Program Files (x86)\Vim\vim80\vim.exe"
$pythonPath = "C:\Program Files\Python36\python.exe"
if (Test-Path "$vimPath") { Set-Alias vim "$vimPath" }
if (Test-Path "$pythonPath") { Set-Alias python "$pythonPath" }

# I don't like wget to work like curl, remove it from global scope
if (Test-Path alias:wget) { Remove-Item -Path Alias:\wget }

# Helper function to check administrative permission
Function isAdmin
{
	return [Bool]([System.Security.Principal.WindowsPrincipal]`
		[System.Security.Principal.WindowsIdentity]::GetCurrent()`
		).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Like $PS1 in bash
Function prompt
{
	If (isAdmin) {
		Write-Host -NoNewline -ForegroundColor Red "PS "
	} Else {
		Write-Host -NoNewline -ForegroundColor Yellow "PS "
	}
	Write-Host -NoNewline -ForegroundColor Blue "$(Get-Location) "
	return "> "
}

Function updateHosts
{
	# TODO: use types dedicated to files / urls
	Param (
		[Parameter(Mandatory=$false)] [String[]] $Urls    = @("https://raw.githubusercontent.com/lennylxx/ipv6-hosts/master/hosts"),
		[Parameter(Mandatory=$false)] [String]   $OutFile = "C:\Windows\System32\drivers\etc\hosts"
	)
	if (-Not (isAdmin)) {
		Write-Error "Administrative privilege is required to write to hosts file"
		return
	}
	# Should support merging multiple files in future (only when I need such functionality though...)
	$tempFile = New-TemporaryFile
	$url = $Urls[0]
	Write-Host "==> Downloading $url to $tempFile"
	Invoke-WebRequest -Uri "$url" -OutFile "$tempFile"
	Write-Host "==> Backing up $OutFile to $OutFile.orig"
	Copy-Item "$OutFile" -Destination "$OutFile.orig"
	Write-Host "==> Writing records to $OutFile"
	Copy-Item "$tempFile" -Destination "$OutFile"
}

Function testFile
{
	Param (
		[Parameter(Mandatory=$true)]  [System.IO.FileInfo] $file
	)
	echo $file.Mode
	echo $file.ToString()
}

# No need to import, all commands are available
Import-Module PSReadLine

# Bash style key bindings
Set-PSReadLineOption -EditMode Emacs

# Original style completion
Set-PSReadLineKeyHandler -Key Ctrl+Tab -Function TabCompleteNext

# Copy & paste
Set-PSReadlineKeyHandler -Key Ctrl+Shift+c -Function Copy
Set-PSReadlineKeyHandler -Key Ctrl+Shift+v -Function Paste

# Scrolling behaviour
Set-PSReadlineKeyHandler -Key Shift+PageUp -Function ScrollDisplayUp
Set-PSReadlineKeyHandler -Key Shift+PageDown -Function ScrollDisplayDown
Set-PSReadlineKeyHandler -Key Shift+Home -Function ScrollDisplayTop
Set-PSReadlineKeyHandler -Key Shift+End -Function ScrollDisplayToCursor
