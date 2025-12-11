# ===================
# shell configuration
# ===================

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# aliases
alias ls='eza'
alias la='eza -a'
alias ll='eza -l'
alias lt='tmux ls'
alias lg="lazygit"
alias nnn="nnn -CH -e"
alias vi="nvim"
alias vim="nvim"
alias ve="python3 -m venv .venv"
alias va="source .venv/bin/activate"
alias ta="tmux attach -t"

# better prompt, improves readability
NEWLINE=$'\n'
STATUS="%(?.%F{white}~>.%F{red}~>)%f"
export PROMPT="$NEWLINE%F{green}%n%f@%F{green}%m%f:%F{blue}%2~%f$NEWLINE$STATUS "

# set editor to neovim
export EDITOR="nvim"
export VISUAL="nvim"

# set history file
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_SAVE_NO_DUPS

# zsh syntax highlighting
export ZSH_HIGHLIGHT_DIR=$(brew --prefix)/share/zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$ZSH_HIGHLIGHT_DIR/highlighters
source $ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh

# fuzzy search
export FZF_DEFAULT_COMMAND="fd --type f"
source <(fzf --zsh)

# zsh completions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

	autoload -Uz compinit
	compinit
	source ~/zplugins/fzf-tab/fzf-tab.plugin.zsh
fi

# better `cd`
eval "$(zoxide init --cmd cd zsh)"

# ========================
# platform specific config
# ========================
if [ -f "$HOME/.zsh_config" ]; then
    source "$HOME/.zsh_config"
fi
