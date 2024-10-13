# Caveats

## openjdk
For the system Java wrappers to find this JDK, symlink it with
  sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

openjdk is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS provides similar software and installing this software in
parallel can cause all kinds of trouble.

If you need to have openjdk first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> /Users/solvedbiscuit71/.bash_profile

For compilers to find openjdk you may need to set:
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

## llvm
To use the bundled libc++ please add the following LDFLAGS:
  LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

llvm is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have llvm first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> /Users/solvedbiscuit71/.bash_profile

For compilers to find llvm you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

## zoxide
Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d

## htop
htop requires root privileges to correctly display all running processes,
so you will need to run `sudo htop`.
You should be certain that you trust any software you grant root privileges.

## mysql
We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -u root

To start mysql now and restart at login:
  brew services start mysql
Or, if you don't want/need a background service you can just run:
  /opt/homebrew/opt/mysql/bin/mysqld_safe --datadir\=/opt/homebrew/var/mysql

## tmux
Example configuration has been installed to:
  /opt/homebrew/opt/tmux/share/tmux

Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d

## ripgrep
Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d

## fzf
To set up shell integration, add this to your shell configuration file:

```sh
  # bash
  eval "$(fzf --bash)"

  # zsh
  source <(fzf --zsh)

  # fish
  fzf --fish | source
```

To use fzf in Vim, add the following line to your .vimrc:
  set rtp+=/opt/homebrew/opt/fzf

## git
The Tcl/Tk GUIs (e.g. gitk, git-gui) are now in the `git-gui` formula.
Subversion interoperability (git-svn) is now in the `git-svn` formula.

Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d

## wineskin
wineskin is built for Intel macOS and so requires Rosetta 2 to be installed.
You can install Rosetta 2 with:
  softwareupdate --install-rosetta --agree-to-license
Note that it is very difficult to remove Rosetta 2 once it is installed.
