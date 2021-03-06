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

