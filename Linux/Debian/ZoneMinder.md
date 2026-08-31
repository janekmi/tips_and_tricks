# ZoneMinder

https://wiki.zoneminder.com/Debian_13_Trixie_with_Zoneminder_1.36.35_or_Zoneminder_1.37.x#Debian_13_with_Zoneminder_1.37.x_from_zmrepo

## Notifications

There is [zmesNg](https://zmeventnotificationng.readthedocs.io/en/latest/guides/install_path1.html#step-1-run-the-installer) which can be used with ZoneMinder to generate push notifications to zmNinjaNg on Android. I tried it make to work but the documentation was not clear how make it work. So, I decided to use ZoneMinder's `EventStartCommand` / `EventEndCommand` with UnifiedPush systems which just worked.

There is a limit on the length of the command but I do not know how long it can be. When the command is too long there is no error message. Too long message is just not get saved.

### Sunup (or possibly other external UnifiedPush servers)

1. Install Sunup on your mobile.
2. You can use UP-Example to register a topic and the Test page to collect all the necessary values e.g.

---

#### Test Webpush

**Endpoint**: &lt;ENDPOINT&gt;

**P256DH**: &lt;KEY&gt;

**Auth**: &lt;AUTH&gt;

**VAPID**: No VAPID header found

---

3. Install [web-push](web-push.md) on the ZoneMinder system.
4. Write a script calling web-push e.g. (it is too long to put it raw inside a ZoneMinder's Event Start / End Command).

```sh
ENDPOINT=<ENDPOINT>
AUTH=<AUTH>
KEY=<KEY>
PAYLOAD="ZoneMonitor: 📸 monitor/event ($MID/$EID)"

web-push send-notification --endpoint=$ENDPOINT --auth=$AUTH --key=$KEY --payload "$PAYLOAD"
```

5. Find the events in ZoneMinder's WebUI: Edit Monitor / Recording / Event Start Command and put there a command e.g.

```sh
MID=%MID% EID=%EID% ./push.sh # use absolute path
```

### Ntfy

1. Install ntfy on your mobile.
2. Set the default server to point to the ZoneMinder system: Settings / Default server e.g. http://192.168.0.1:85
3. Install and configure [ntfy](ntfy.sh.md) on the ZoneMinder system.
4. Write the script calling ntfy e.g.

```sh
ENDPOINT=<ENDPOINT>
PAYLOAD="ZoneMinder: 📸 monitor/event ($MID/$EID)"
EVENT_DIR="/some/path/zoneminder/events/$MID/$(date +'%Y-%m-%d')/$EID"
SNAPSHOT="$EVENT_DIR/snapshot.jpg"

case "$1" in
start)
    curl -d "$PAYLOAD" $ENDPOINT
    ;;
end)
    curl -T "$SNAPSHOT" -H "Filename: monitor_${MID}_event_${EID}.jpg" $ENDPOINT
    ;;
esac
```

5. ZoneMinder: Edit Monitor / Recording / Event Start Command

```sh
MID=%MID% EID=%EID% ./push.sh start # use absolute path
```

6. ZoneMinder: Edit Monitor / Recording / Event End Command

```sh
MID=%MID% EID=%EID% ./push.sh end # use absolute path
```
