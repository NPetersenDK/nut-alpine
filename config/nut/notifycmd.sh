#!/bin/sh

# Load notification settings
. /etc/nut/notify.conf

# Function to send email
send_mail() {
    SUBJECT="$1"
    MESSAGE="$2"
    {
        echo "From: ${NOTIFY_FROM}"
        echo "To: ${NOTIFY_TO}"
        echo "Subject: ${SUBJECT}"
        echo
        echo "${MESSAGE}"
    } | msmtp "${NOTIFY_TO}"
}

case $NOTIFYTYPE in
    ONLINE)
        send_mail "UPS Online" "UPS $UPSNAME is online"
        ;;
    ONBATT)
        send_mail "UPS on Battery" "UPS $UPSNAME is on battery"
        ;;
    LOWBATT)
        send_mail "UPS Battery Low" "UPS $UPSNAME has a low battery"
        ;;
    FSD)
        send_mail "UPS Forced Shutdown" "UPS $UPSNAME forcing shutdown"
        ;;
    COMMOK)
        send_mail "UPS Communication Restored" "Communication with $UPSNAME restored"
        ;;
    COMMBAD)
        send_mail "UPS Communication Lost" "Communication with $UPSNAME lost"
        ;;
    SHUTDOWN)
        send_mail "UPS Shutdown" "UPS $UPSNAME shutting down"
        ;;
    REPLBATT)
        send_mail "UPS Battery Replace" "UPS $UPSNAME battery needs replacement"
        ;;
    NOCOMM)
        send_mail "UPS No Communication" "UPS $UPSNAME is unavailable"
        ;;
    *)
        send_mail "UPS Status Changed" "UPS $UPSNAME: $NOTIFYTYPE"
        ;;
esac
