# Minecraft Server — Shared Mods & Resourcepacks

Shared mod and resourcepack repo for our Minecraft server. Everyone pulls from this repo to stay in sync.

**Minecraft version:** 1.21.11
**Mod loader:** Fabric (fabric-loader-0.18.4)

## Setup (First Time)

### Prerequisites

- [Git](https://git-scm.com/downloads) installed
- [Git LFS](https://git-lfs.com/) installed (`git lfs install` after installing)
- Minecraft Java Edition installed and launched at least once
- [Fabric Loader](https://fabricmc.net/use/installer/) installed for Minecraft 1.21.11

### Clone the Repo

```bash
git clone https://github.com/talonwr/minecraft-server.git
cd minecraft-server
git lfs pull
```

## Playing

Instead of launching Minecraft directly, use the launcher script. It pulls the latest mods, syncs them to your Minecraft folder, then starts the game.

### Mac

```bash
./launcher/launch.sh
```

> Tip: You can create an alias in your shell profile:
> ```bash
> alias minecraft="~/path/to/minecraft-server/launcher/launch.sh"
> ```

### Windows

Double-click `launcher/launch.bat`, or run it from Command Prompt:

```cmd
launcher\launch.bat
```

### Linux

```bash
./launcher/launch.sh
```

## Adding or Removing Mods

1. Add/remove `.jar` files in the `mods/` folder
2. Add/remove `.zip` files in the `resourcepacks/` folder
3. Commit and push:

```bash
git add mods/ resourcepacks/
git commit -m "Add/remove mod: ModName"
git push
```

Everyone will get the changes next time they launch.

## Server (Raspberry Pi)

The server start script pulls latest mods before starting:

```bash
# Set your server directory (defaults to ~/minecraft-server)
export MINECRAFT_SERVER_DIR=/path/to/your/fabric-server

# Optional: configure RAM (defaults to 1G min, 2G max)
export MINECRAFT_MIN_RAM=1G
export MINECRAFT_MAX_RAM=2G

./launcher/server-start.sh
```

## Current Mods

| Mod | Description |
|---|---|
| Fabric API | Required library for Fabric mods |
| Farmer's Delight (Refabricated) | Farming and cooking expansion |
| Iris Shaders | Shader support for Fabric |
| Sodium | Performance optimization |

## Current Resourcepacks

| Pack |
|---|
| JihadCreepers |
