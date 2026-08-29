#!/bin/sh

if [ "$EULA" = "true" ]; then
    echo "eula=true" > eula.txt
    exec sh ./bin/x64/factorio
    else 
        echo "You need to agree to EULA to launch server"
        exit 1
fi