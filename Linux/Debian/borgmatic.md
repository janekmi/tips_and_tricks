# borgmatic

A simple setup comprised of:

- one local borg repository and
- one remote borg repository on BorgBase.

1. Install `borg` and `borgmatic`.

> **Note**: Both `borg` and `borgmatic` come already installed in my distro. Make sure they already installed in yours as well.

- https://torsion.org/borgmatic/how-to/install-borgmatic/
- https://packages.debian.org/stable/borgbackup
- https://tracker.debian.org/pkg/borgmatic

2. [Create a BorgBase repository](/Services/BorgBase.md).
3. Generate a `borgmatic` configuration file.

```sh
borgmatic config generate --destination /my/configs.yaml
```

4. Adjust the configuration file to your needs.

- Set what you want to backup.

```yaml
source_directories:
    - /very/important/data/
```

- Set path to both local repository and remote repository.

```yaml
repositories:
   - path: /local/repository
     label: local
   - path: ssh://XXX@YYY.repo.borgbase.com/./repo
     label: remote
```

- Set password for both repositories.

```yaml
encryption_passphrase: strong_password
```

5. Create repositories.

```sh
borgmatic repo-create --encryption repokey
```

6. Backup your data.

```sh
borgmatic create --verbosity 1 --list --stats
```
