# Tmux (terminal multiplexer)
if [[ "$ALACRITTY_WINDOW_ID" ]] && [[ -z "$TMUX" ]]; then
    /opt/homebrew/bin/tmux new-session -A -s main
    exit
fi

# Environment Variables
export PS1="\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w\[\e[m\]\$(__git_ps1)\n$ "
export VISUAL=nvim
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="echo"
stty -ixon

# Aliases
alias lg="lazygit"
alias ls="ls -AF --color"
alias nnn="nnn -CH -e"
alias vi="nvim"
alias vim="nvim"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Bash Completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# FZF (fuzzy find)
# Deprecated [ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

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
export PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"

# Go
export GOPATH="$HOME/.go"
export PATH="/usr/local/go/bin:$GOPATH/bin:${PATH}"

# Rust
. "$HOME/.cargo/env"

# Haskell: ghcup-env
[ -f "/Users/solvedbiscuit71/.ghcup/env" ] && . "/Users/solvedbiscuit71/.ghcup/env"

# Done.
echo "loaded ~/.bashrc"
