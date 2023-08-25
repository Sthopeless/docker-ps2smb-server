# PS2SMB Server

Containerized Open PS2 Loader SMB server.
Tested working with the latest version of OPL at the time of writing using Fedora 38.

## Usage

### Preface

- The run script contains required variables - modify to suit.
- Based off the [Samba Docker image](https://hub.docker.com/r/dperson/samba) - you might need to run manually once in order to login and download the image on first use.
- Uses port 445 by default.
- See `image/smb.conf` if you need to modify the internal Samba configuration.

### Running manually

```bash
# Script used to initialize the environment variables and run docker-compose
./up.sh opl_dir [port]
# - opl_dir: The directory in which your games are stored.
# - port: The port which the server will listen on (445 by default).

# Script used to stop the containers created by docker-compose
./down.sh
```

### Building the image and running the container without 'up.sh'

You need to supply the following environment variables:
- RUN_UID: UID for the samba user
- RUN_GID: GID for the samba user

When running the container, you should mount your OPL game directory to the
'/mount' directory as a volume, and also expose the port 445 to a port of your choice on the host

### OPL credentials on network settings:

Just leave both empty

### Running with systemd

- Place the repository under `/root/ps2smb-server`.
- Copy `ps2smb-server.service` to the `/etc/systemd/system` directory.
- `systemctl daemon-reload`.
- `systemctl start ps2smb-server`.

### Opening the port under firewalld

- Copy `ps2smb-server.xml` to the `/etc/firewalld/services` directory.
- `systemctl restart firewalld`.
- `firewall-cmd --info-service=ps2smb-server` to check it's working.
- `firewall-cmd --zone=FedoraServer --add-service=ps2smb-server --permanent`.
- `firewall-cmd --reload`.

## Licence

MIT.
