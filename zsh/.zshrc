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

# variables
export PROMPT="%F{green}%n%F{white}@%F{green}%m %F{blue}%2~ %F{white}%# "
export EDITOR="nvim"
export VISUAL="nvim"

export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_SAVE_NO_DUPS

# enable vim bindings
bindkey -v
export KEYTIMEOUT=1

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# zsh completions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

	autoload -Uz compinit
	compinit
fi

# zsh syntax highlighting
export ZSH_HIGHLIGHT_DIR=$(brew --prefix)/share/zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$ZSH_HIGHLIGHT_DIR/highlighters
source $ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh

# fuzzy search
export FZF_DEFAULT_COMMAND="fd --type f"
source <(fzf --zsh)

# better `cd`
eval "$(zoxide init --cmd cd zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# bison
export LDFLAGS="-L/opt/homebrew/opt/bison/lib"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# sumo
export SUMO_HOME="/System/Volumes/Data/Library/Frameworks/EclipseSUMO.framework/Versions/1.24.0/EclipseSUMO/share/sumo/"
export PATH="$SUMO_HOME/bin:$PATH"
