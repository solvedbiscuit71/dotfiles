# Prerequisites

## macOS

1. Developer Toolkit
```sh
xcode-select --install
```

2. Homebrew
```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## linux

1. Developer Toolkit
```sh
sudo apt update
sudo apt upgrade
sudo apt install build-essential git curl
```

2. Linuxbrew
```sh
curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
/bin/bash install.sh
```

## Add brew to $PATH

1. Homebrew
```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

2. Linuxbrew
```sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

# Installation

```sh
brew install bash bash-completion fzf gcc git lazygit neovim nnn tmux zoxide
```

## Nerd Font

```sh
brew tap homebrew/cask-fonts &&
brew install --cask font-victor-mono-nerd-font
```

Or, download from [VictorMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/VictorMono.zip)
```sh
mkdir -p $HOME/.local/share/fonts
sudo cp $HOME/Downloads/TTF/* $HOME/.local/share/fonts
fc-cache -f -v
```

## Bash

### macOS
```sh
echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/bash
```

### linux
```sh
echo '/home/linuxbrew/.linuxbrew/bin/bash' | sudo tee -a /etc/shells
chsh -s /home/linuxbrew/.linuxbrew/bin/bash
```

## Alacritty

```sh
brew install --cask alacritty
```

Or, you can build is from [source](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

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

## Disable dock delay (macOS)

```sh
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
```

## Tiling window manager (macOS)

```sh
brew install --cask amethyst spaceid
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
