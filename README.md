# Installation

Install Xcode

```sh
xcode-select --install
```

Install Homebrew

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install Softwares

1. [Alacritty](https://alacritty.org/index.html)
2. [Dropshelf](https://pilotmoon.com/dropshelf/)

# Scripts

1. install-packages: uses brew and git to install necessary packages and software.
2. install-config: creates folder and symlinks to configuration files.
3. remove-config: remove folder and unlink symlinks to configuration files.
