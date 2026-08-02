# Lunoriy---paper-world-reset

Minecraft Server Run Loop

This script automatically starts a Paper Minecraft server and restarts it whenever it stops, unless a stop flag is present. It also supports performing a complete world reset before the next server startup.
Requirements

    Linux

    Bash

    Java installed

    Paper server (paper.jar)

    Server directory:

    ~/minecraft

Configuration

The following variables can be adjusted in the script:

  SERVER_DIR="$HOME/minecraft"
  JAR_NAME="paper.jar"
  JAVA_ARGS="-Xms2G -Xmx4G"

Worlds Removed During a Reset

The following world directories will be deleted when a world reset is requested:

    world

    world_nether

    world_the_end

Usage
Start the Server

chmod +x run-loop.sh
./run-loop.sh

The server will start normally. If it crashes or shuts down, the script waits 5 seconds before automatically starting it again.
