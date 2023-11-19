# homebrew
export PATH=$HOME/.dotfiles2/.script:$PATH

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	[[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	echo "Unknown OS: $OSTYPE"
fi

if [[ -z "$TMUX" ]]; then
	tmux new-session -A -s main
	exit
fi

# .env
export PS1="\[\e[32m\]\u\[\e[m\]@\h \[\e[34m\]\W\[\e[m\] \\$ "
export VISUAL=nvim
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
stty -ixon
shopt -s autocd
eval "$(jump shell bash)"

# alias
alias nnn="nnn -CH -e"
alias ls="ls -A"
alias vim="nvim"

# extra
# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# go
export GOPATH="$HOME/.go"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"
