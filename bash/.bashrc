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
if [[ "$IN_ALACRITTY" ]] && [[ -z "$TMUX" ]]; then
	tmux new-session -A -s main
	exit
fi

# environment variables
export PS1="\[\e[32m\]\u\[\e[m\]@\h \[\e[34m\]\W\[\e[m\] \\$ "
export VISUAL=nvim
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
stty -ixon
shopt -s autocd

# alias
alias nnn="nnn -CH -e"
alias ls="ls -A"
alias vim="nvim"
alias lg="lazygit"
alias venv="source .venv/bin/activate"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# zoxide
eval "$(zoxide init --cmd cd bash)"

# java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"

# go
export GOPATH="$HOME/.go"
PATH="/usr/local/go/bin:$GOPATH/bin:${PATH}"

# python 3.12
# if macOS
PATH="~/Library/Python/3.12/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
PATH="~/.local/bin:$PATH"
# else...

# PATH
PATH="${PATH}:~/.solvedbiscuit71/.script"
export PATH
