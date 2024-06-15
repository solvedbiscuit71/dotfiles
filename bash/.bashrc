# Homebrew (OS-specific)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    [[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
    echo "Unknown OS: $OSTYPE"
fi

# User defined env
export PS1="\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\W\[\e[m\]\\$ "
export VISUAL=nvim
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
stty -ixon

# User defined alias
alias lg="lazygit"
alias ls="ls -A"
alias nnn="nnn -CH -e"
alias vim="nvim"

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Zoxide
eval "$(zoxide init --cmd cd bash)"

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"

# Go
export GOPATH="$HOME/.go"
PATH="/usr/local/go/bin:$GOPATH/bin:${PATH}"

# Rust
. "$HOME/.cargo/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH
