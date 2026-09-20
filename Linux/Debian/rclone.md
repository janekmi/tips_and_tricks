# rclone

## Update `rclone`

> **Note**: The latest `rclone` provided in Debian may be a little bit behind which means you may not have all backends available.

```sh
curl https://rclone.org/install.sh | sudo bash
```

- https://packages.debian.org/trixie/rclone
- https://rclone.org/downloads/#script-download-and-install

## Mount locally

```sh
rclone mount remote:path/to/files /path/to/local/mount
```

https://rclone.org/commands/rclone_mount/

## Google Drive

1. Create your own client_id

https://rclone.org/drive/#making-your-own-client-id

2. Configure

https://rclone.org/drive/#configuration
