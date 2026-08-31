#!/bin/sh

mkdir -p ./saves
if [ ! -f ./saves/save.zip ]; then
    ./factorio/bin/x64/factorio --create ./saves/save.zip
fi
exec ./factorio/bin/x64/factorio --start-server-load-latest --server-settings ./factorio/data/server-settings.example.json
