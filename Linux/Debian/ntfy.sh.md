# ntfy.sh

Ref: https://docs.ntfy.sh/install/#debianubuntu-repository
Ref: https://docs.ntfy.sh/install/#general-steps

Adjust configuration here: /etc/ntfy/server.yml

## Binding interface and port

```yaml
listen-http: "192.168.0.1:85"
```

**Note**: Especially you may want to adjust port since the default is port 80 which may by already taken.

## Attachments

```yaml
base-url: http://192.168.0.1:85
attachment-cache-dir: /some/dir/ntfy/attachments
```

The cache directory has to belong to the `ntfy` user.

```sh
chown -R ntfy:ntfy /some/dir/ntfy/attachments
```
