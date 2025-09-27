# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# aliases
alias ls='eza -a'
alias lg="lazygit"
alias ll="nnn -CH -ed"
alias vi="nvim"
alias vim="nvim"
alias ve="python3 -m venv .venv"
alias va="source .venv/bin/activate"

# variables
export PROMPT="%F{green}%n@%m %F{blue}%1~ %F{white}%# "
export VISUAL="nvim"

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
