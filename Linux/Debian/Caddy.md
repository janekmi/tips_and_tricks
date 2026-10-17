# Caddy

## Install

Follow steps from the documentation.

Ref: https://caddyserver.com/docs/install#debian-ubuntu-raspbian

**Note**: Make sure it does not clash with other servers in your system. Check `systemctl status caddy`.

## Configure

1. Adjust `/etc/caddy/Caddyfile` as necessary.
2. Check the file.

```sh
caddy validate --config /etc/caddy/Caddyfile
```

3. Restart the `caddy` service.

```sh
systemctl restart caddy
```

# TLS with Tailscale and Let's Encrypt

1. Enable [TLS in Tails](Tailscale.md#tls-certificates).
2. Add `TS_PERMIT_CERT_UID` for the `caddy` user in `/etc/default/tailscaled`.

```sh
TS_PERMIT_CERT_UID=caddy
```

Ref: https://tailscale.com/docs/integrations/web-servers/caddy/caddy-certificates#provide-non-root-users-with-access-to-fetch-certificate

3. Restart `tailscaled`.

```sh
systemctl restart tailscaled
```

4. Use MagicDNS names in `Caddyfile` e.g.

**Note**: `caddy` automatically requests and renews TLS certificates from `tailscaled`.

**Note**: Tailscale source its certificates from Let's Encrypt.

```caddyfile
host.tail0000.ts.net {
    reverse_proxy 127.0.0.1:7745 {
        header_up X-Real-IP {remote_host}
    }
}
```

Ref: https://tailscale.com/docs/integrations/web-servers/caddy/caddy-certificates
