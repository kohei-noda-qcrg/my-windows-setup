#!/bin/bash
set -euo pipefail # Abort script when error is occured.
cd "$(dirname "$0")"

echo -e "============================="
echo -e "Start vscodeubuntusetup.sh"
echo -e "============================="

##############################
# Install VScode extensions
##############################

# WSL and Remote-ssh and Remote-containers support
code --install-extension ms-vscode-remote.vscode-remote-extensionpack --force

# Utils
code --install-extension formulahendry.code-runner --force # Execute script extension
code --install-extension streetsidesoftware.code-spell-checker --force # check English Spell
code --install-extension timonwong.shellcheck --force # Powerful support for syntax error of shell scripts
code --install-extension mads-hartmann.bash-ide-vscode --force # Powerful support for bash script
code --install-extension usernamehw.errorlens --force # Whether or not you hover over the error line, highlight errors
code --install-extension PKief.material-icon-theme --force # Change Vscode explorer icons
code --install-extension IBM.output-colorizer --force # Colorize output file
code --install-extension shardulm94.trailing-spaces --force # Detect end of line spaces and highlight these
code --install-extension mosapride.zenkaku --force # Detect Zenkaku characters and highlight these
code --install-extension sgryjp.japanese-word-handler --force # Japanese word jump extension
code --install-extension ms-vscode.hexeditor --force # Binary viewer
code --install-extension EditorConfig.EditorConfig --force # Force code rules

# C/C++
code --install-extension ms-vscode.cpptools-extension-pack --force

# Rust
code --install-extension rust-lang.rust-analyzer --force # Rust language support
code --install-extension tamasfe.even-better-toml --force # TOML language support

# Git/Github
code --install-extension mhutchie.git-graph --force # View git history as a graphical tree
code --install-extension donjayamanne.githistory --force # Add convenient features to Vscode Source control tab
code --install-extension GitHub.vscode-pull-request-github --force # Support for Github, github pull requests and issues
code --install-extension eamodio.gitlens --force # Visualize code authorship and so on

# Markdown
code --install-extension yzane.markdown-pdf --force # Convert Markdown to pdf
code --install-extension DavidAnson.vscode-markdownlint --force # Markdown linter

echo -e "============================="
echo -e "End vscodeubuntusetup.sh"
echo -e "============================="
