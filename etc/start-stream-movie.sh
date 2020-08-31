PEER_V=$1 PEER_IP=$2 \
SELF_PATH="/var/etc/MGB02.mp4" \
bash -c 'gst-launch-1.0 -e \
    uridecodebin uri="file://$SELF_PATH" \
        ! videoconvert ! x264enc tune=zerolatency \
        ! rtph264pay \
        ! "application/x-rtp,payload=(int)103,clock-rate=(int)90000" \
        ! udpsink host=$PEER_IP port=$PEER_V'

