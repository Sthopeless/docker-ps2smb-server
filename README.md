# PS2SMB Server

Containerized Open PS2 Loader SMB server.
Tested working with the latest version of OPL at the time.

## Usage

### Preface

- Based off the [Samba Docker image](https://hub.docker.com/r/dperson/samba).
- Uses port 445 by default.
- See `image/smb.conf` if you need to modify the internal Samba configuration.

### Running the container without 'up.sh'

The image is posted on [DockerHub](https://hub.docker.com/r/edisnord/ps2smb-server).

When building the image yourself, you can supply the following arguments:
- UID: UID for the samba user
- GID: GID for the samba user
- LOG_LEVEL: Samba log level

You should mount your OPL game directory to the
'/mount' in the container directory as a volume, and also publish the port 445 of the container to a port of your choice on the host.

```bash
# Simple run
docker run -p 445:445 \
                    --mount type=bind,source="/home/$USER/Documents/PS2SMB",target="/mount" -d \
                    edisnord/ps2smb-server:latest

```

### OpenPS2Loader connection credentials:

Just leave both the username and password fields empty, as this server supports anonymous GUEST logins.

## ⚠️Important⚠️, don't forget to allow traffic to the port you chose in the -p setting on your firewall

## License

MIT.
