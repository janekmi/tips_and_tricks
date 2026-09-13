# Borg

> **Note**: I do not use Borg directly to manage backups. Please see [borgmatic.md](borgmatic.md).

## Key export

> **Note**: There is a recommendation to export a key and store it in a safe place.

```sh
# local repository
borg key export /path/to/repository local.key
# remote repository
borg key export ssh://XXX@YYY.repo.borgbase.com/./repo remote.key
```
