#!/bin/sh

mkdir -p ./factorio/saves
if [ ! -f ./factorio/saves/save.zip ]; then
    ./factorio/bin/x64/factorio --create ./factorio/saves/save.zip
fi
exec ./factorio/bin/x64/factorio --start-server-load-latest --server-settings ./factorio/data/server-settings.example.json