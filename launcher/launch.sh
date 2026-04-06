#!/usr/bin/env bash
# Minecraft Mod Sync & Launch — Mac/Linux
# Pulls the latest mods and resourcepacks from the shared repo, then launches Minecraft.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Detect Minecraft directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    MC_DIR="$HOME/Library/Application Support/minecraft"
elif [[ "$OSTYPE" == "linux"* ]]; then
    MC_DIR="$HOME/.minecraft"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

if [[ ! -d "$MC_DIR" ]]; then
    echo "Error: Minecraft directory not found at $MC_DIR"
    echo "Make sure Minecraft is installed and has been run at least once."
    exit 1
fi

echo "=== Minecraft Mod Sync ==="
echo ""

# Pull latest changes
echo "Pulling latest mods and resourcepacks..."
cd "$REPO_DIR"
git pull --ff-only origin main
echo ""

# Sync mods — mirror the repo's mods folder exactly
echo "Syncing mods..."
rm -f "$MC_DIR/mods/"*.jar 2>/dev/null || true
cp "$REPO_DIR/mods/"*.jar "$MC_DIR/mods/"
echo "  Installed $(ls "$REPO_DIR/mods/"*.jar 2>/dev/null | wc -l | tr -d ' ') mod(s)"

# Sync resourcepacks — mirror the repo's resourcepacks folder exactly
echo "Syncing resourcepacks..."
rm -f "$MC_DIR/resourcepacks/"*.zip 2>/dev/null || true
if ls "$REPO_DIR/resourcepacks/"*.zip 1>/dev/null 2>&1; then
    cp "$REPO_DIR/resourcepacks/"*.zip "$MC_DIR/resourcepacks/"
    echo "  Installed $(ls "$REPO_DIR/resourcepacks/"*.zip 2>/dev/null | wc -l | tr -d ' ') resourcepack(s)"
else
    echo "  No resourcepacks to sync"
fi

echo ""
echo "Sync complete!"

# Launch Minecraft (Mac only — Linux users may need to adjust)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Launching Minecraft..."
    open -a "Minecraft"
else
    echo "Sync done. Please launch Minecraft manually."
fi
