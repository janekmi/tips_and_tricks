# PhotoPrism

## Install

1. Download the `compose.yaml` file and put it where you would like to store it e.g. a dedicated PhotoPrism directory.

```sh
wget https://dl.photoprism.app/docker/compose.yaml
```

> **Note**: Without significant adjustments to the `compose.yaml` file this directory may grow quite big since all the data will live here.

2. Adjust the `compose.yaml` file - `environment`.

- admin user and password (at least the initial one). The password can be changed in WebUI later on,
- site (WebUI) domain (IP) and port,
- auto import delay on uploads via WebDAV (very useful).

```yaml
    environment:
      PHOTOPRISM_ADMIN_USER: "admin"                 # admin login username
      PHOTOPRISM_ADMIN_PASSWORD: "agoodpasstostart"  # initial admin password (8-72 characters)
      _: "..."
      PHOTOPRISM_SITE_URL: "http://127.0.0.1:2342/"  # server URL in the format "http(s)://domain.name(:port)/(path)"
      _: "..."
      PHOTOPRISM_AUTO_IMPORT: 30                     # delay before automatically importing files in SECONDS when uploading via WebDAV (-1 to disable)
```

3. Adjust the `compose.yaml` file - `volumes`.

> **Note**: This part is very important. If configured wrong you may loose the contents of the PhotoPrism instance between reboots. Just to be sure you may want to (1) upload / import a few images, (2) stop your PhotoPrism instance, (3) start it again and (4) check if everything is where you have left it.

All volumes are defined as: `"/host/folder:/photoprism/folder"`

- `originals` where PhotoPrism will store all the photos. This volume has to be defined.
- `import` a directory where you can stage photos for PhotoPrism to get imported from. Import allows for deduplication.
- `storage` where PhotoPrism will store its metadata. This volume has to be defined.

```yaml
    volumes:
      - "/local/PhotoPrism/originals:/photoprism/originals" # Original media files (DO NOT REMOVE)
      - "..."
      - "/mnt/encrypted/PhotoPrism/import:/photoprism/import"       # *Optional* base folder from which files can be imported to originals
      - "/mnt/encrypted/PhotoPrism/storage:/photoprism/storage"     # *Writable* storage folder for cache, database, and sidecar files (DO NOT REMOVE)
```

4. Start PhotoPrism

> **Note**: The `docker` command may require `sudo` privilege.

```sh
docker compose up -d
```

Than enter your site / server / WebUI URL in a browser and log in.

Ref: https://docs.photoprism.app/getting-started/docker-compose/

## Automatic import

WebDAV + automatic import set

```sh
rclone move --metadata /mnt/encrypted/Syncthing/FP4_Janek/DCIM/IMG_20260801_184546.jpg photoprism-import:/
```
