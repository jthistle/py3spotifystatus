#!/bin/bash

dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
if [ "$1" = status ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | tail -n1 | cut -d'"' -f2
elif [ "$1" = artist ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -f ${dir}/spotify_song.awk | sed -n "2p" | cut -d':' -f2
elif [ "$1" = song ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -f ${dir}/spotify_song.awk | sed -n "3p" | cut -d':' -f2
elif [ "$1" = length ]; then
  length=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -f ${dir}/spotify_song.awk | sed -n "1p" | cut -d':' -f2`
  echo $(( $length / 1000000 ))
elif [ "$1" = position ]; then
  # Returns position of playing in seconds
  position=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Position' | tail -n1 | sed "s/ \+/ /g" | cut -d" " -f4`
  echo $(( $position / 1000000 ))
elif [ "$1" = checkup ]; then
  dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' > /dev/null 2>&1 && echo 1 || echo 0
else
  echo "No argument specified to the script who gets info from Spotify. Try using 'status', 'artist' or 'song'."
fi
