### Kanata

#### MacOS

1. Install [Karabinar-Elements](https://karabiner-elements.pqrs.org) and grant the requested premission.
2. Quit Karabinar-Elements.
3. Download [kanata](https://github.com/jtroo/kanata/releases) pre-built binary.
4. Copy the binary (with `cmd_allowed` enabled) to `/usr/local/bin/kanata`.
5. Ensure the binary has been allowed "Input Monitoring" and "Accessibility" permission under `System Settings > Privacy`.
6. Run the `install-config` script.
7. Run the above commands in the terminal:

```sh
sudo cp ~/.config/kanata/com.example.kanata.plist /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl enable system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

8. Reboot the system.

#### Windows

1. Download the pre-built binaries from [Releases](https://github.com/jtroo/kanata/releases) page.
2. Extract the folder and move to `C:\` drive.
3. Copy the `kanata-win32.kbd` file to the extracted folder and rename to `kanata.kbd`
4. Create a shortcut for `kanata_windows_gui_winIOv2_cmd_allowed_x64` executable.
5. Open run program (Win+R), and type `shell:startup` to open startup folder.
6. Move the shortcut into the startup folder.
7. Reboot the system.
