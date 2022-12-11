#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import subprocess
import os

##
## Configuration
# Colours: colour of widget text corresponding to different playback states
COLOUR_PLAYING = "#1db954" # default "#1db954"
COLOUR_PAUSED  = "#e3a600" # default "#e3a600"
COLOUR_DOWN    = "#ff0000" # default "#ff0000"
COLOUR_UNKNOWN = "#000000" # default "#000000"

# Whether or not to display song progress
SHOW_PROGRESS = False # default True

# The character to use at the start of the widget. Defaults to FontAwesome Spotify logo character.
START_CHAR = " " # default " "

# Maximum length of artist + song string. If set to None, no maximum.
# This will always completely remove the song title before truncating the artist.
MAX_LENGTH = 64 # default 64
##
##


dir_path=os.path.dirname(os.path.realpath(__file__))

def get_prop(prop):
    spotify_read = subprocess.check_output(f"{dir_path}/getInfo.sh {prop}", shell=True)
    spotify_status=spotify_read.decode('utf-8')
    return spotify_status.strip()

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def seconds_to_time(timestamp):
    try:
        timestamp = int(timestamp)
    except TypeError:
        pass
    secs = timestamp % 60
    mins = timestamp // 60
    return f"{mins:01}:{secs:02}"


if __name__ == '__main__':
    spotify_up = get_prop("checkup")
    if spotify_up == "0":
        print_line(f"{START_CHAR}down")
        print_line(COLOUR_DOWN)
    else:
        status = get_prop("status")
        artist = get_prop("artist")
        title = get_prop("song")

        song_string = f"{artist} — {title}"

        if MAX_LENGTH is not None and len(song_string) > MAX_LENGTH:
            song_string = song_string[:MAX_LENGTH - 1] + "…"

        if artist == "" or title == "":
            print_line(f"{START_CHAR}...")
            print_line(COLOUR_UNKNOWN)
        else:
            if SHOW_PROGRESS:
                position = seconds_to_time(get_prop("position"))
                length = seconds_to_time(get_prop("length"))
                print_line(f"{START_CHAR}{song_string} ({position} / {length})")
            else:
                print_line(f"{START_CHAR}{song_string}")

            if status == "Playing":
                print_line(COLOUR_PLAYING)
            elif status == "Paused":
                print_line(COLOUR_PAUSED)