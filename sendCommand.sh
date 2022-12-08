#!/usr/bin/env bash
getvol() {
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Volume' | tail -n1 | sed "s/ \+/ /g" | cut -d' ' -f4
}

setvol() {
  vol=$(clampvol $1)
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:'org.mpris.MediaPlayer2.Player' string:'Volume' variant:double:"$vol"
}

clampvol() {
  if (( $(echo "$1 > 1.0" | bc -l) )); then
    echo 1.0
  elif (( $(echo "$1 < 0.0" | bc -l) )); then
    echo 0.0
  else
    echo $1
  fi
}

dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
if [ "$1" = "playpause" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
elif [ "$1" = "next" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
elif [ "$1" = "prev" ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
elif [ "$1" = "volup" ]; then
  vol=$(getvol)
  setvol $(echo "$vol + 0.02" | bc -l)
elif [ "$1" = "voldown" ]; then
  vol=$(getvol)
  setvol $(echo "$vol - 0.02" | bc -l)
else
  echo "Unrecognised command" 1>&2
fi
