# ZoneMinder

https://wiki.zoneminder.com/Debian_13_Trixie_with_Zoneminder_1.36.35_or_Zoneminder_1.37.x#Debian_13_with_Zoneminder_1.37.x_from_zmrepo


## Edit Monitor / Recording / Event End Command

```sh
ENDPOINT=<ENDPOINT>
AUTH=<AUTH>
KEY=<KEY>
PAYLOAD="ZoneMonitor: 📸 monitor/event ($MID/$EID)"

web-push send-notification --endpoint=$ENDPOINT --auth=$AUTH --key=$KEY --payload "$PAYLOAD"
```

```sh
MID=%MID% EID=%EID% ./push.sh
```
