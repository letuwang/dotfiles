# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# dotfiles
set -g -x DOTFILES "$HOME/.dotfiles"

# gnupg
export GPG_TTY=(tty)

# starship
starship init fish | source

# perl
eval (perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)

# coreutils
set PATH "/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# grep
set PATH "/usr/local/opt/grep/libexec/gnubin:$PATH"

# python (homebrew version)
set PATH "/usr/local/opt/python/libexec/bin:$PATH"

# Aliases
alias r="radian"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.config/fish/config.fish"
alias ll="gls -AhlFo --color --group-directories-first"
alias c="clear"
alias dotfiles="cd $DOTFILES"
alias brewdepsgraph="brew graph --installed --highlight-leaves | fdp -T png -o graph.png; open graph.png"
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"