#!/bin/sh

# Function to send Discord webhook notification
send_discord() {
    TITLE="$1"
    MESSAGE="$2"
    
    # Use curl to send webhook
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"embeds\": [{\"title\": \"${TITLE}\", \"description\": \"${MESSAGE}\", \"color\": 16711680}]}" \
         "${DISCORD_WEBHOOK_URL}"
}

case $NOTIFYTYPE in
    ONLINE)
        send_discord "UPS Online" "UPS $UPSNAME is online"
        ;;
    ONBATT)
        send_discord "UPS on Battery" "UPS $UPSNAME is on battery"
        ;;
    LOWBATT)
        send_discord "UPS Battery Low" "UPS $UPSNAME has a low battery"
        ;;
    FSD)
        send_discord "UPS Forced Shutdown" "UPS $UPSNAME forcing shutdown"
        ;;
    COMMOK)
        send_discord "UPS Communication Restored" "Communication with $UPSNAME restored"
        ;;
    COMMBAD)
        send_discord "UPS Communication Lost" "Communication with $UPSNAME lost"
        ;;
    SHUTDOWN)
        send_discord "UPS Shutdown" "UPS $UPSNAME shutting down"
        ;;
    REPLBATT)
        send_discord "UPS Battery Replace" "UPS $UPSNAME battery needs replacement"
        ;;
    NOCOMM)
        send_discord "UPS No Communication" "UPS $UPSNAME is unavailable"
        ;;
    DOCKERONLINE)
        send_discord "Docker online" "Docker container is online"
        ;;
    *)
        send_discord "UPS Status Changed" "UPS $UPSNAME: $NOTIFYTYPE"
        ;;
esac
