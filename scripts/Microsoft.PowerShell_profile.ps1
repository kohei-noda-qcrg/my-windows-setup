function prompt {
    $p = $($executionContext.SessionState.Path.CurrentLocation)
    $converted_path = Convert-Path $p
    $ansi_escape = [char]27
    "PS $p$('>' * ($nestedPromptLevel + 1)) ";
    Write-Host "$ansi_escape]9;9;$converted_path$ansi_escape\"
}

function git-clean() {
    git fetch --prune
    git branch -vv | findstr " gone]" | %{(-split $_)[0]} | %{git branch -D $_}
}

function git-su() { # submodule update
    git pull
    git submodule update --init --recursive
    git submodule update --recursive --checkout
    git submodule foreach --recursive git submodule update --checkout
    Get-ChildItem -Recurse -Force | Where-Object { $_.Attributes -match "ReparsePoint" -and $_.Length -eq 0 } | Remove-Item -Force
    git submodule foreach --recursive git reset --hard
    git reset --hard
}

Import-Module posh-git
