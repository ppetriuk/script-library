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
alias cd_github="cd /Users/ppetriuk/Documents/github"
alias cd_gerrit="cd /Users/ppetriuk/Documents/gerrit"
alias commit_message="cp /Users/ppetriuk/Documents/github/script-library/commit_message.txt ./commit_message.txt; vim ./commit_message.txt"
alias git_commit="git remote update; git pull --ff-only; #git commit -s -m"
alias git_stash="git stash push -m "$(head -n 1 ./commit_message.txt)""
