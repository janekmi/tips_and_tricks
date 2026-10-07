# borgmatic

## Install `borg` and `borgmatic`

> **Note**: Both `borg` and `borgmatic` can be already installed in your distro. But in my case it was `borg` 1.4.0 which does not support e.g. `rclone` so you may prefer to install a package called `borgbackup2` but in this case you cannot rely on the `borgmatic` package provided by the repository since it requires the `borgbackup` package which cannot be installed along with the `borgbackup2` package.

> **Note**: At the time of writing, `borg` 2.x is not yet stable and not recommended to use in production, so I recommend using `borg` 1.x.

> **Note**: Repositories created with `borg` 1.x are NOT compatible with `borg` 2.x. I expect a migration procedure to be available when `borg` 2.x is released.

- https://www.borgbackup.org/releases/
- https://torsion.org/borgmatic/how-to/install-borgmatic/
- https://docs.astral.sh/uv/getting-started/installation/
- https://packages.debian.org/stable/borgbackup
- https://packages.debian.org/stable/borgbackup2
- https://tracker.debian.org/pkg/borgmatic

## Setups

### Simple one

A simple setup comprised of:

- one local borg repository and
- one remote borg repository on BorgBase.

1. [Create a BorgBase repository](/Services/BorgBase.md).
2. Generate a `borgmatic` configuration file.

```sh
borgmatic config generate --destination /my/config.yaml
```

3. Adjust the configuration file to your needs.

- Set what you want to backup.

```yaml
source_directories:
    - /very/important/data/
```

You can further fine-tune what you do and don’t back up by setting `patterns`.

```yaml
patterns:
    - '- /very/important/data/*.log'
```

- Set path to both local repository and remote repository.

```yaml
repositories:
   - path: /local/repository
     label: local
   - path: ssh://XXX@YYY.repo.borgbase.com/./repo
     label: remote
```

- Set password for both repositories (yes, the same password for both of them).

```yaml
encryption_passphrase: strong_password
```

4. Create repositories.

```sh
borgmatic repo-create --config /my/config.yaml
```

> **Note**: Adjust the encryption according to your prefence and what can be acceleratedy by your hardware.

5. Export and backup [keys](Borg.md#key-export)

> **Note**: Each of the repositories has its own key. You have to export and backup all of them.

### With rclone (`borg` 2.x)

> **Note**: This setup is not specially performant. Some caching options may fix this but till then you may want to avoid it and just use the [`rclone copy`](rclone.md#rclone-copy) command.

1. Setup an [rclone remote](rclone.md#setting-up-remotes).
2. Generate a `borgmatic` configuration file. (as above)
3. Adjust the configuration file to your needs.

- Set what you want to backup.
- Set rclone repository.

```yaml
repositories:
    - path: rclone:remote:/some/path
      label: proton
```

- Set password for the repository.

Ref: https://torsion.org/borgmatic/reference/configuration/repositories/#rclone

## Backup your data

> **Note**: You may want to check what is backed up before creating a backup.

```sh
borgmatic create --verbosity 1 --list --stats --config /my/config.yaml
```

## Check what is backed up

```sh
borgmatic create --config /my/config.yaml --dry-run --list
```
