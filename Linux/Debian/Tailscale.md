# Tailscale

## Start a system service when the Tailscale network interface is ready

**Note**: I have not find a source for this. I just happened to find this service installed when Tailscale was installed and... it works. I hope it will work for you too.

1. Enable the relevant service.

```sh
systemctl enable tailscale-wait-online.service
```

2. Add the service as both `Requires` and `After` in the service definition you want to start when the Tailscale network interface is ready. e.g. `/usr/lib/systemd/system/apache2.service`:

```ini
Requires=tailscale-wait-online.service
After=network.target remote-fs.target nss-lookup.target tailscale-wait-online.service
```

Ref: https://github.com/Lightfielder/Tailscale/blob/main/cmd/tailscaled/tailscale-wait-online.service
