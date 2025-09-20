eval "$(/opt/homebrew/bin/brew shellenv)"

# aliases
alias lg="lazygit"
alias ls="ls -AF --color"
alias nn="nnn -CH -e"
alias nnn="nnn -CH -e"
alias vi="nvim"
alias vim="nvim"
alias activate="source .venv/bin/activate"

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
