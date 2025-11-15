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

1. `install-packages`: uses brew and git to install necessary packages and software.
2. `install-config`: creates folder and symlinks to configuration files.
3. `remove-config`: remove folder and unlink symlinks to configuration files.

# Home-Row Mod

1. Install [Karabinar-Elements](https://karabiner-elements.pqrs.org) and grant the requested premission.
2. Quit Karabinar-Elements
3. Install [kanata](https://github.com/jtroo/kanata) (install using `install-packages` script).

Run the following commands in the terminal, after running `install-config` script.

```sh
sudo cp ~/.config/kanata/com.example.kanata.plist /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl enable system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```
