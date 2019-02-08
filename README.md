# akromanode-dockerized
Akroma node daemon container for Akroma Network


This method uses a [bind mount](https://docs.docker.com/storage/bind-mounts) to persist the blockchain data on the host.

To simplify things, basic operations have been added as `Makefile` commands.

## To build:
```
make image
```

## To run the node / daemon (non-interactive):
```
make node
```

## To access the running node interactively with the geth console:
```
make attach
```

## To run as a systemd service:
Assuming you have created a user `akromanode` in group `akromanode` and have cloned this repository in the `akromanode` home user directory,
the following service file will start the daemon automatically at system startup.

Enter the following into `/etc/systemd/system/akromanode.service`:
```
[Unit]
Description=Akroma node daemon service
After=network.target

[Service]
User=akromanode
Group=akromanode
Type=simple
Restart=always
RestartSec=30s
WorkingDirectory=/home/akromanode/akromanode-dockerized
ExecStart=/usr/bin/make node

[Install]
WantedBy=default.target
```

After creating the service file, enable and restart the service:
```
systemctl enable akromanode
systemctl restart akromanode
```

NOTE: You must make sure the service is running if you use interactive mode for the geth console.

To stop the service:
```
systemctl stop akromanode
```

To restart the service:
```
systemctl restart akromanode
```

<hr>

#### Donations accepted:
`0x1a81a763c422E6457617Ce465C2C1cD34242c68C` (AKA)
