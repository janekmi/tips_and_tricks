# HomeBox

## Install

1. Copy `compose.yml` from the webpage to a dedicated directory.

2. Adjust the `compose.yml` file `environment` values.

- set `HBOX_AUTH_API_KEY_PEPPER`

```yaml
    - HBOX_AUTH_API_KEY_PEPPER=goodpepperstring
```

- set values required for the reverse proxy to work

```yaml
    - HBOX_WEB_HOST=0.0.0.0
    - HBOX_OPTIONS_TRUST_PROXY=true
```

3. Set local directory for the data.

```yaml
        volumes:
            - "/local/HomeBox/data:/data/"
```

4. Set the local port for the service.

```yaml
        ports:
            - 127.0.0.1:7745:7745
```

5. Start the service.

```sh
docker compose up -d
```

Ref: https://homebox.software/en/quick-start/install/#docker-compose
