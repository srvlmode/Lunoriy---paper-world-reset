#!/usr/bin/env bash
#
# run-loop.sh
# Universal version: works no matter where the "server" folder is located,
# as long as this script sits directly inside that folder.

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SERVER_DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"

JAR_NAME="server.jar"
JAVA_ARGS="-Xms2G -Xmx4G"
WORLDS=("world" "world_nether" "world_the_end")

cd "$SERVER_DIR" || exit 1

while true; do
    if [ -f "wipe-requested.flag" ]; then
        echo "[Lunoriy] Wipe requested - deleting world folders..."
        for w in "${WORLDS[@]}"; do
            if [ -d "$w" ]; then
                rm -rf -- "$w"
                echo "[Lunoriy]  - $w removed."
            fi
        done
        rm -f -- "wipe-requested.flag"
        FLAG_FILE="$SERVER_DIR/plugins/LunoriyWorldReset/world-started.flag"
        if [ -f "$FLAG_FILE" ]; then
            rm -f -- "$FLAG_FILE"
            echo "[Lunoriy]  - world-started.flag reset."
        fi
    fi

    echo "[Lunoriy] Starting server..."
    java $JAVA_ARGS -jar "$JAR_NAME" nogui

    if [ -f "stop-loop.flag" ]; then
        echo "[Lunoriy] stop-loop.flag found - exiting restart loop."
        rm -f -- "stop-loop.flag"
        break
    fi

    echo "[Lunoriy] Server stopped, restarting in 5 seconds..."
    sleep 5
done
