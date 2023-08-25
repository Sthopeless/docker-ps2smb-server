# PS2SMB Server

Containerized Open PS2 Loader SMB server.
Tested working with the latest version of OPL at the time of writing using Fedora 38.

## Usage

### Preface

- Based off the [Samba Docker image](https://hub.docker.com/r/dperson/samba).
- Uses port 445 by default.
- See `image/smb.conf` if you need to modify the internal Samba configuration.

### Running the container without 'up.sh'

The image is posted on [DockerHub](https://hub.docker.com/r/edisnord/ps2smb-server).

When running the container, you can supply the following environment variables:
- RUN_UID: UID for the samba user
- RUN_GID: GID for the samba user

You should mount your OPL game directory to the
'/mount' in the container directory as a volume, and also publish the port 445 of the container to a port of your choice on the host.

```bash
# Simple run
docker run -p 445:445 \
                    --mount type=bind,source="/home/$USER/Documents/PS2SMB",target="/mount" -d \
                    edisnord/ps2smb-server:1

# Example run:
docker run -p 445:445 \
                    --env=RUN_UID='1001' \
                    --env=RUN_GID='1001' \
                    --mount type=bind,source="/home/$USER/Documents/PS2SMB",target="/mount" -d \
                    edisnord/ps2smb-server:1
```

### OpenPS2Loader connection credentials:

Just leave both the username and password fields empty, as this server supports anonymous GUEST logins

## !Important!, don't forget to allow traffic to the port you chose in the -p setting on your firewall

## Licence

MIT.
