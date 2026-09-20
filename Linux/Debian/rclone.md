# rclone

## Update `rclone`

> **Note**: The latest `rclone` provided in Debian may be a little bit behind which means you may not have all backends available.

```sh
curl https://rclone.org/install.sh | sudo bash
```

Ref: https://packages.debian.org/trixie/rclone
Ref: https://rclone.org/downloads/#script-download-and-install

## Mount locally

```sh
rclone mount remote:path/to/files /path/to/local/mount
```

Ref: https://rclone.org/commands/rclone_mount/

## Google Drive

1. Create your own client_id

Ref: https://rclone.org/drive/#making-your-own-client-id

2. Configure

Ref: https://rclone.org/drive/#configuration
