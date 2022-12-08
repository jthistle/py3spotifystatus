#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import subprocess
import os

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
        print_line(" down")
        print_line("#ff0000")
    else:
        status = get_prop("status")
        artist = get_prop("artist")
        title = get_prop("song")

        if artist == "" or title == "":
            print_line(" ...")
        else:
            position = seconds_to_time(get_prop("position"))
            length = seconds_to_time(get_prop("length"))
            print_line(f" {artist} — {title} ({position} / {length})")

            if status == "Playing":
                print_line("#1DB954")
            elif status == "Paused":
                print_line("#e3a600")