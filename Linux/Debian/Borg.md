# Borg

> **Note**: I do not use Borg directly to manage backups. Please see [borgmatic.md](borgmatic.md).

## Key export

> **Note**: There is a recommendation to export a key and store it in a safe place.

```sh
# local repository
borg key export --repo /path/to/repository > local.key
# remote repository
borg key export --repo ssh://XXX@YYY.repo.borgbase.com/./repo > remote.key
```

- https://borgbackup.readthedocs.io/en/stable/usage/key.html#borg-key-export
