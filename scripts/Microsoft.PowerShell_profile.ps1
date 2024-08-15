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

Import-Module posh-git
