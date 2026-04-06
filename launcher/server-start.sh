#!/usr/bin/env bash
# Minecraft Server Sync & Start — Raspberry Pi (Linux)
# Pulls the latest mods from the shared repo, syncs them to the server, then starts it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- CONFIGURATION ---
# Set this to your Fabric server directory on the Pi
SERVER_DIR="${MINECRAFT_SERVER_DIR:-$HOME/minecraft-server}"
# RAM allocation
MIN_RAM="${MINECRAFT_MIN_RAM:-1G}"
MAX_RAM="${MINECRAFT_MAX_RAM:-2G}"
# Server jar name
SERVER_JAR="${MINECRAFT_SERVER_JAR:-fabric-server-launch.jar}"
# --- END CONFIGURATION ---

if [[ ! -d "$SERVER_DIR" ]]; then
    echo "Error: Server directory not found at $SERVER_DIR"
    echo "Set MINECRAFT_SERVER_DIR to your Fabric server location."
    exit 1
fi

if [[ ! -f "$SERVER_DIR/$SERVER_JAR" ]]; then
    echo "Error: Server jar not found at $SERVER_DIR/$SERVER_JAR"
    echo "Set MINECRAFT_SERVER_JAR if your jar has a different name."
    exit 1
fi

echo "=== Minecraft Server Sync ==="
echo ""

# Pull latest changes
echo "Pulling latest mods and resourcepacks..."
cd "$REPO_DIR"
git pull --ff-only origin main
echo ""

# Sync mods to server
echo "Syncing mods to server..."
mkdir -p "$SERVER_DIR/mods"
rm -f "$SERVER_DIR/mods/"*.jar 2>/dev/null || true
cp "$REPO_DIR/mods/"*.jar "$SERVER_DIR/mods/"
echo "  Installed $(ls "$REPO_DIR/mods/"*.jar 2>/dev/null | wc -l | tr -d ' ') mod(s)"

echo ""
echo "Sync complete! Starting server..."
echo ""

# Start the server
cd "$SERVER_DIR"
java -Xms"$MIN_RAM" -Xmx"$MAX_RAM" -jar "$SERVER_JAR" nogui
