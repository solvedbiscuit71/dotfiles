# brew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    [[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
    echo "Unknown OS: $OSTYPE"
fi

# tmux
# if [[ "$IN_ALACRITTY" ]] && [[ -z "$TMUX" ]]; then
#     tmux new-session -A -s main
#     exit
# fi

# environment variables
export PS1="\[\e[32m\]\u\[\e[m\]@\h \[\e[34m\]\W\[\e[m\] \\$ "
export VISUAL=nvim
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
stty -ixon

# alias
alias lg="lazygit"
alias ls="ls -A"
alias nnn="nnn -CH -e"
alias vim="nvim"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# zoxide
eval "$(zoxide init --cmd cd bash)"

# java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"

# go
export GOPATH="$HOME/.go"
PATH="/usr/local/go/bin:$GOPATH/bin:${PATH}"

# rust
. "$HOME/.cargo/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH
