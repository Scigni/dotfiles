#!/usr/bin/env bash

# Get currently MediaPlayer firefox instance
readonly FIREFOX_INSTANCE=$(dbus-send --session --print-reply --dest=org.freedesktop.DBus --type=method_call /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep "MediaPlayer2.firefox" | cut -d "\"" -f 2)

# Only if the Firefox instance is Active
if [ -n $FIREFOX_INSTANCE ]
then
    case $1 in
        artist)
            dbus-send --print-reply --dest=$FIREFOX_INSTANCE /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 "xesam:artist" |tail -1 | cut -d "\"" -f 2
            ;;

        title)
            dbus-send --print-reply --dest=$FIREFOX_INSTANCE /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 1 "xesam:title" |tail -1 | cut -d "\"" -f 2
            ;;

        album)
            dbus-send --print-reply --dest=$FIREFOX_INSTANCE /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 1 "xesam:album" |tail -1 | cut -d "\"" -f 2
            ;;
    esac
fi
