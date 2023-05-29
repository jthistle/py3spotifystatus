# py3spotifystatus - Spotify status widget for i3bar with py3status

- [About](#about)
  - [Examples](#examples)
  - [Changes in this version](#changes-in-this-version)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Credits](#credits)


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

* Added song progress to widget
* Added podcast support
* Added `sendCommand.sh` script, which can be used to remotely control the Spotify player, for example using i3 mod keybindings
* Changed output format of `pystatus.py` to work with py3status
* Updated colours to match current Spotify branding
* Fixed multiple bugs

## Requirements

* [py3status](https://py3status.readthedocs.io/en/latest/user-guide/installation/)
* [Spotify desktop app](https://www.spotify.com/us/download/linux/) - web player is not enough
* (optional) [FontAwesome for the desktop](https://fontawesome.com/download) if you want Spotify logo in status bar

The other requirements are dbus and Python 3, which you shouldn't need to worry about since they come bundled with most distros. You also need [i3](https://i3wm.org), obviously.

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
