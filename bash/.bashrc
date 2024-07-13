# Linuxbrew
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# [[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Tmux (terminal multiplexer)
if [[ "$ALACRITTY_WINDOW_ID" ]] && [[ -z "$TMUX" ]]; then
    tmux new-session -A -s main
    exit
fi

# Bash Completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

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
alias ls="ls -AFG"
alias nnn="nnn -CH -e"
alias vi="nvim"
alias vim="nvim"

# FZF (fuzzy find)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Zoxide (smarter cd)
eval "$(zoxide init --cmd cd bash)"

# Pyenv (python version manager)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# NVM (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"

# Go
export GOPATH="$HOME/.go"
PATH="/usr/local/go/bin:$GOPATH/bin:${PATH}"

# Rust
. "$HOME/.cargo/env"

export PATH
