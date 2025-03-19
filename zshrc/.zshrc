# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9

# set the directory we want to install zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit if the zinit folder do not exist
if [ ! -d "${ZINIT_HOME}" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source our zinit file
source "${ZINIT_HOME}/zinit.zsh"

# Add powerLevel10k (prompt style)
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybinds
bindkey -e
bindkey '^p' history-search-backward # se inzi a scrive tipo curl ti da  vecchi comandi che startano con quello
bindkey '^n' history-search-forward

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# Alias
alias ls='ls --color'
alias or='nvim -p $HOME/file/2brain/1_inbox/*.md'
alias gh='cd /home/ris8z/file/github'
alias gl='cd /home/ris8z/file/gitlab'

# Path
export PATH="$HOME/dotfiles/bin:$PATH"
alias or='nvim -p $HOME/file/2brain/1_inbox/*.md'
alias gh='cd /home/ris8z/file/github'
alias gl='cd /home/ris8z/file/gitlab'
export HYPRSHOT_DIR="$HOME/file/image/screenshot/"
export PATH="/home/ris8z/.cargo/bin:$PATH"
export PATH=$PATH:/usr/lib/node_modules

# pfetch
pfetch
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
