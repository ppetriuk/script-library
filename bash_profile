# Add coreutils to PATH to use instead of FreeBSD ls
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Color listing output 
export CLICOLOR=1
export LSCOLORS=Fxfxbxdxbxegedabagacad

alias ls='ls -laGhp'

# More usabele prompt
# PS1='\[\u@\h:\w\]\$  '

# Vim color pallet
source $HOME/.vim/pack/default/start/gruvbox/gruvbox_256palette.sh

# Navigation aliases
U_DIR="/Users/ppetriuk/Documents"
alias cd_github="cd $U_DIR/github"
alias cd_gerrit="cd $U_DIR/gerrit"

rc_presales="$U_DIR/rc.files/presales-cloud/ppetriuk-openrc.sh"

# Git aliases
alias git_pull="git remote update; git pull --ff-only; #git commit -s -m"

# Ooen chrome tab/window
alias chrome='open --new -a "Google Chrome" --args $@'
alias chrome_window='open --new -a "Google Chrome" --args --new-window $@'

#alias git_stash="git stash push -m"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
