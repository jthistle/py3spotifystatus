#!/usr/bin/env bash

VOLUME_INTERVAL="0.02"


# Returns current volume of Spotify player
getvol() {
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Volume' | tail -n1 | sed "s/ \+/ /g" | cut -d' ' -f4
}

# Sets volume to input (will be clamped to [0.0, 1.0])
setvol() {
  vol=$(clampvol "$1")
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:'org.mpris.MediaPlayer2.Player' string:'Volume' variant:double:"$vol"
}

# Clamps input to [0.0, 1.0]
clampvol() {
  if (( $(echo "$1 > 1.0" | bc -l) )); then
    echo 1.0
  elif (( $(echo "$1 < 0.0" | bc -l) )); then
    echo 0.0
  else
    echo "$1"
  fi
}

if [ "$1" = "playpause" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
elif [ "$1" = "next" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
elif [ "$1" = "prev" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
elif [ "$1" = "volup" ]; then
  vol=$(getvol)
  setvol "$(echo "$vol + $VOLUME_INTERVAL" | bc -l)"
elif [ "$1" = "voldown" ]; then
  vol=$(getvol)
  setvol "$(echo "$vol - $VOLUME_INTERVAL" | bc -l)"
else
  echo "Unrecognised command '$1'. Available commands are 'playpause', 'next', 'prev', 'volup', 'voldown'." 1>&2
fi
