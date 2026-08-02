#!/usr/bin/env bash
#
# run-loop.sh

SERVER_DIR="$HOME/minecraft"
JAR_NAME="paper.jar"
JAVA_ARGS="-Xms2G -Xmx4G"

WORLDS=("world" "world_nether" "world_the_end")

cd "$SERVER_DIR" || exit 1

while true; do
    if [ -f "wipe-requested.flag" ]; then
        echo "[Lunoriy] Wipe angefordert - lösche alte Weltordner..."
        for w in "${WORLDS[@]}"; do
            if [ -d "$w" ]; then
                rm -rf -- "$w"
                echo "[Lunoriy]  - $w gelöscht."
            fi
        done
        rm -f -- "wipe-requested.flag"

        FLAG_FILE="$SERVER_DIR/plugins/LunoriyWorldReset/world-started.flag"
        if [ -f "$FLAG_FILE" ]; then
            rm -f -- "$FLAG_FILE"
            echo "[Lunoriy]  - world-started.flag zurückgesetzt."
        fi
    fi

    echo "[Lunoriy] Starte Server..."
    java $JAVA_ARGS -jar "$JAR_NAME" nogui

    if [ -f "stop-loop.flag" ]; then
        echo "[Lunoriy] stop-loop.flag gefunden - beende Auto-Restart-Loop."
        rm -f -- "stop-loop.flag"
        break
    fi

    echo "[Lunoriy] Server beendet, starte in 5 Sekunden neu..."
    sleep 5
done
