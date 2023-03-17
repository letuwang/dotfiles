# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/homebrew/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# dotfiles
set -g -x DOTFILES "$HOME/.dotfiles"

# gnupg
export GPG_TTY=(tty)

# homebrew
eval "/opt/homebrew/bin/brew shellenv" | source

# starship
starship init fish | source

# perl
bass eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# coreutils
set PATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

# grep
set PATH "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"

# findutils
set PATH "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"

# sed
set PATH "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

# python (homebrew version)
set PATH "$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"

# Aliases
alias r="radian"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.config/fish/config.fish"
alias ll="gls -AhlFo --color --group-directories-first"
alias c="clear"
alias dotfiles="cd $DOTFILES"
alias brewdepsgraph="brew graph --installed --highlight-leaves | fdp -T png -o graph.png; open graph.png"
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias pinentry='pinentry-mac'