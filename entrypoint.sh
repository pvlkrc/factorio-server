#!/bin/sh

if [ true ]; then
    mkdir -p ./saves
    if [ ! -f ./saves/save.zip ]; then
        ./factorio/bin/x64/factorio --create ./saves/save.zip
    fi
    exec ./factorio/bin/x64/factorio --start-server ./saves/save.zip --server-settings ./factorio/data/server-settings.example.json
    else
        exit 1
fi