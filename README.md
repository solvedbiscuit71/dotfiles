# Prerequisites

```sh
xcode-select --install
```

2. Homebrew
```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
## Add brew to $PATH

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

# Installation

```sh
brew install bash bash-completion fzf gcc git lazygit neovim nnn tmux zoxide
```

## Nerd Font

This repo uses [ZedMono Nerd Font](https://www.nerdfonts.com/#home) for terminal emulator.

## Bash

```sh
echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/bash
```

## Alacritty

```sh
brew install --cask alacritty
```

## TPM

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Once installed, enter tmux and enter the following sequence `PREFIX I` to install the plugin

# Setup

```sh
git clone https://github.com/solvedbiscuit71/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Install
```sh
python3 .script/init.py
```

## Uninstall
```sh
python3 .script/deinit.py
```

# Postrequisites

## Disable dock delay

```sh
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
```

## Tiling window manager

```sh
brew install --cask amethyst spaceid
```

## Karabiner-Elements

```sh
brew install --cask karabiner-elements
```

## Programming Language

### Python

Using pyenv to manage different python version, and using poetry for managing virtual environments and packages.
```sh
brew update
brew install pyenv
```

Current LTS python version is 3.11 so install python3.11 using pyenv and make it default
```sh
pyenv install 3.11
pyenv global 3.11
```

### Node

Using nvm to manage different node version, follow the [nvm](https://github.com/nvm-sh/nvm) github to install nvm.

To set a default node version
```sh
nvm alias default <version>
```
