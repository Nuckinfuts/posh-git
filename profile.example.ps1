Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $cyan = [ConsoleColor]::Cyan
    $red = [ConsoleColor]::Red

    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd.ProviderPath) -nonewline -f $cyan

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-Host " >" -n -f $red
    return " "
}

Enable-GitColors

Pop-Location

#Start-SshAgent -Quiet

# setup aliases
function Get-GitStatus { git status }
Set-Alias gs Get-GitStatus

function Get-GitDiff { git diff }
Set-Alias gd Get-GitDiff

function Get-GitDiffCached { git diff --cached }
Set-Alias gdc Get-GitDiffCached

function Get-GitAddAll { git add --all }
Set-Alias ga Get-GitAddAll

function Get-GitCommit { git commit }
Set-Alias gco Get-GitCommit

function Get-GitCommitAll { git commit -a }
Set-Alias gca Get-GitCommitAll
