# i3spotifystatus - updated for py3status

## About

This is an updated verison of [rpieja's i3spotifystatus](https://github.com/rpieja/i3spotifystatus). It adds a widget to your py3status bar displaying the current Spotify song and artist, as well as the current progress through the song.

### Examples

Widget with all config options on, while playing:

![Widget with all config options on, while playing](./res/1.png)

While paused (and demonstrating non-latin song titles):

![While paused](./res/2.png)

Showing truncation of long song titles:

![Showing truncation of long song titles](./res/3.png)

With song progress turned off:

![With song progress turned off](./res/4.png)

### Changes in this version

* Changed output format of `pystatus.py` to work with py3status
* Added song progress to widget
* Updated colours to match current Spotify branding
* Added `sendCommand.sh` script - this can be used to remotely control the Spotify player, for example through i3 mod keybindings

## Requirements
* dbus
* Spotify desktop app - web player is not enough
* FontAwesome if you want Spotify logo in status bar

## Installation

* Clone repository to your preferred location
* Update your `i3status.conf` with
```conf
order += "external_script"

# ...

external_script {
    script_path = "/path/to/i3spotifystatus/pystatus.py"
    cache_timeout = 1
}
```
* Optional: keybindings can be added through i3 `config` file, e.g.
```
bindsym $mod+$alt+D exec /path/to/i3spotifystatus/sendCommand.sh playpause
# etc.
```

## Configuration

There are some options you can set at the top of the `pystatus.py` script by editing it. They are documented in the script.

## Credits

[Original i3spotifystatus](https://github.com/rpieja/i3spotifystatus) by [rpieja](https://github.com/rpieja).

Original credits:

Script is based on sample wrapper commited on original i3status repository.

Awk script by @csssuf.
