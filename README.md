
## Description

Minecraft for rpi.

## Prerequisite

* podman
* podman-compose
* git
* jq
* java(optional)

## Usage

build a image and create default files.

```bash
## build image
podman build -t mc-server:latest .

## create a container volume and default files
podman run --rm -v mc-server-data:/data mc-server:latest

## edit eula.txt
MC_VOLUME=$(podman volume inspect mc-server-data | jq -r '.[].Mountpoint')
sed -i -e 's/false/true/g' $MC_VOLUME/eula.txt
```

check if it start normally.

```bash
podman run --rm -it -v mc-server-data:/data -p 25565:25565 mc-server:latest
```

check the starting log.

```
...
[10:17:26] [Worker-Main-1/INFO]: Preparing spawn area: 51%
[10:17:26] [Worker-Main-2/INFO]: Preparing spawn area: 51%
[10:17:27] [Server thread/INFO]: Time elapsed: 6296 ms
[10:17:27] [Server thread/INFO]: Done (14.872s)! For help, type "help"
```

start a mc-server

```bash
podman-compose up -d
```

link log for monitor

```
sudo ln -s `podman volume inspect mc-server-data | jq -r '.[].Mountpoint'`/logs/latest.log /var/log/mc-server.log
```

## How to install fabric for server

```bash
curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.21.4/0.16.10/1.0.1/server/jar
mv fabric-server-mc.1.21.4-loader.0.16.10-launcher.1.0.1.jar $MC_VOLUME/fabric-server-launch.jar
```

```bash
## download a mod to mods directory
$MC_VOLUME/mods
```

docker-compose.yaml entrypoint

```
    entrypoint: [ "java", "-jar", "-Xms7G", "-Xmx7G", "/data/fabric-server-launch.jar", "nogui" ]
```

### Geyser global link settings

```yaml
# Configuration for player linking
player-link:
  # Whether to enable the linking system. Turning this off will prevent
  # players from using the linking feature even if they are already linked.
  enabled: true
  use-global-linking: true
```

## How to version up minecraft server

bump up the version 

```bash
podman build -t mc-server:latest .

podman-compose down
podman-compose up -d
podman-compose logs -f | grep "minecraft server version"
```

