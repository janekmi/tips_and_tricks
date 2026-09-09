# GeoPulse

https://geopulse.cc/docs/getting-started/deployment/manual-installation

## Apache instead of Nginx

GeoPulse instructs on how to setup it's frontend on Nginx but since I already had Apache installed I managed to run it on Apache.

> **Disclaimer**: The following config was generated using AI. It works for me. It may break something for you.

> **Note**: Standard release of GeoPulse assumes it runs from the root directory e.g. `/api`. So, the following config dedicates a specific port (18080) for the GeoPulse frontend in order to run multiple virtual hosts on the same Apache.

1. Setup Apache to listen on the dedicated port. **Add** to the `/etc/apache2/ports.conf` not to disrupt standard services.

```
# GeoPulse
Listen 192.168.50.10:18080
```

2. Add `/etc/apache2/sites-available/geopulse.conf`.

```xml
<VirtualHost *:18080>
    ServerName 100.96.68.35

    DocumentRoot /var/www/geopulse

    <Directory /var/www/geopulse>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted

        DirectoryIndex index.html

        # SPA fallback
        RewriteEngine On
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule ^ /index.html [END]
    </Directory>

    # GeoPulse backend API
    ProxyPreserveHost On
    ProxyPass        /api/ http://127.0.0.1:8080/api/
    ProxyPassReverse /api/ http://127.0.0.1:8080/api/

    RequestHeader set X-Real-IP "%{REMOTE_ADDR}s"
    RequestHeader set X-Forwarded-Proto "http"
    RequestHeader set X-Forwarded-Port "18080"

    # Allow larger imports/uploads
    LimitRequestBody 104857600

    # Do not cache the SPA shell or runtime configuration
    <FilesMatch "^(index\.html|config\.js|manifest\.webmanifest|sw\.js|registerSW\.js)$">
        Header always set Cache-Control "no-store, no-cache, must-revalidate"
        Header always set Pragma "no-cache"
        Header always set Expires "0"
    </FilesMatch>

    # Cache static assets
    <FilesMatch "\.(css|js|png|jpg|jpeg|gif|svg|ico|woff|woff2|ttf)$">
        Header set Cache-Control "public, max-age=31536000"
    </FilesMatch>

    ErrorLog /var/log/geopulse/apache-error.log
    CustomLog /var/log/geopulse/apache-access.log combined
</VirtualHost>
```

3. Enable required modules, enable site, test and reload Apache.

```sh
a2enmod rewrite headers proxy proxy_httpsudo
a2ensite geopulse.conf
apache2ctl configtest
systemctl reload apache2
```
