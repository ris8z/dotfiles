#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


#start ship
eval "$(starship init bash)"

#pfetch autostart
pfetch

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

#my own script in bash
export PATH="$HOME/dotfiles/bin:$PATH"

#obsidian reviwes
alias or='nvim -p $HOME/file/2brain/1_inbox/*.md'
