# fish settings
set fish_greeting ""
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# dotfiles
set -x DOTFILES "$HOME/.dotfiles"

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# tex
fish_add_path /Library/TeX/texbin

# gnupg
export GPG_TTY=(tty)
set -x GNUPGHOME $XDG_DATA_HOME/gnupg

# homebrew
eval "/opt/homebrew/bin/brew shellenv" | source
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_ENV_HINTS 1
set -x HOMEBREW_AUTOREMOVE 1
set -x HOMEBREW_BAT 1

# starship
set -x STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
if status is-interactive
    starship init fish | source
end

# Perl and cpanm
fish_add_path $HOME/perl5/bin
set -xp PERL5LIB $HOME/perl5/lib/perl5
set -xp PERL_LOCAL_LIB_ROOT $HOME/perl5
set -x PERL_MB_OPT "--install_base \"$HOME/perl5\""
set -x PERL_MM_OPT "INSTALL_BASE=$HOME/perl5"
set -x PERL_CPANM_HOME $XDG_DATA_HOME/cpanm
set -x PERL_CPANM_OPT --auto-cleanup=1

# coreutils
fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin

# grep
fish_add_path $HOMEBREW_PREFIX/opt/grep/libexec/gnubin

# findutils
fish_add_path $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin

# sed
fish_add_path $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin

# orbstack
source ~/.orbstack/shell/init.fish ^/dev/null; or true

# vscode
string match -q "$TERM_PROGRAM" "vscode"
and . "/Applications/Visual Studio Code.app/Contents/Resources/app/out/vs/workbench/contrib/terminal/browser/media/fish_xdg_data/fish/vendor_conf.d/shellIntegration.fish"

# docker
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x MACHINE_STORAGE_PATH $XDG_DATA_HOME/docker-machine

# npmrc
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

# ncurses / terminfo
set -x TERMINFO $XDG_DATA_HOME/terminfo
set -xp TERMINFO_DIRS $TERMINFO

# python
set -x PYTHONPYCACHEPREFIX $XDG_CACHE_HOME/python
set -x PYTHONUSERBASE $XDG_DATA_HOME/python
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/config.py

# jupyter
set -x JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter

# matplotlib
set -x MPLCONFIGDIR $XDG_CONFIG_HOME/matplotlib

# vim
set -x GVIMINIT "set nocp | source $XDG_CONFIG_HOME/vim/gvimrc"
set -x VIMINIT "set nocp | source $XDG_CONFIG_HOME/vim/vimrc"

# aws-cli
set -x AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials
set -x AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config

# less
set -x LESSHISTFILE $XDG_STATE_HOME/less/history

# R
set -x R_ENVIRON $XDG_CONFIG_HOME/R/environ
set -x R_CHECK_ENVIRON $XDG_CONFIG_HOME/R/check-environ
set -x R_BUILD_ENVIRON $XDG_CONFIG_HOME/R/build-environ
set -x R_PROFILE $XDG_CONFIG_HOME/R/profile
set -x R_HISTFILE $XDG_STATE_HOME/R/history
set -x R_MAKEVARS_USER $XDG_CONFIG_HOME/R/makevars

# pipx
fish_add_path /Users/letuwang/.local/bin
set -x PIPX_HOME $XDG_DATA_HOME/pipx

# rust
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
fish_add_path $CARGO_HOME/bin

# Android
set -x ANDROID_USER_HOME $XDG_DATA_HOME/android

# Go
set -x GOPATH $XDG_DATA_HOME/go

# nodejs
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node/repl_history

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# fix conda for warp
if test "$TERM_PROGRAM" = "WarpTerminal"
    conda deactivate && conda activate base
end

# Aliases
alias r="radian"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $XDG_CONFIG_HOME/fish/config.fish"
alias ll="gls -AhlFo --color --group-directories-first"
alias c="clear"
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias pinentry='pinentry-mac'

# ssh agent
fish_ssh_agent