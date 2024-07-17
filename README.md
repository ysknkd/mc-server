
## Description

Minecraft for rpi.

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

