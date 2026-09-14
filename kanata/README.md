### Kanata

#### MacOS

1. Install [Karabinar-DriverKit-VirtualHIDDevice v6.2.0](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/tag/v6.2.0).
2. Download [kanata](https://github.com/jtroo/kanata/releases) pre-built binary.
3. Copy the binary (with `cmd_allowed` enabled) to `/usr/local/bin/kanata`.
4. Ensure the binary has been allowed "Input Monitoring" and "Accessibility" permission under `System Settings > Privacy`.
5. Run the `install-config` script.
6. Run the below commands in the terminal:

```bash
sudo cp $PWD/kanata/com.example.karabiner-vhiddaemon.plist /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist
sudo launchctl enable system/com.example.karabiner-vhiddaemon.plistom.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist

sudo cp $PWD/kanata/com.example.karabiner-vhidmanager.plist /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
sudo launchctl enable system/com.example.karabiner-vhidmanager.plistom.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
```

```bash
sudo cp ~/.config/kanata/com.example.kanata.plist /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl enable system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

8. Reboot the system.

NOTE: restart kanata when a new device is connected using the following command.

```bash
sudo launchctl kill 9 system/com.example.kanata
```

#### Windows

1. Download the pre-built binaries from [Releases](https://github.com/jtroo/kanata/releases) page.
2. Extract the folder and move to `C:\` drive.
3. Copy the `kanata-win32.kbd` file to the extracted folder and rename to `kanata.kbd`
4. Create a shortcut for `kanata_windows_gui_winIOv2_cmd_allowed_x64` executable.
5. Open run program (Win+R), and type `shell:startup` to open startup folder.
6. Move the shortcut into the startup folder.
7. Reboot the system.
