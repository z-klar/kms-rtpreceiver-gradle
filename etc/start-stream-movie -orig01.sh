PEER_V=$1 \
PEER_IP=$2 \
SELF_PATH="/var/etc/MGB02.mp4" \
\
\
\
\
SCAPS_VOUT="media=(string)video,clock-rate=(int)90000,encoding-name=(string)H264,payload=(int)96,ssrc=(uint)112233" \
bash -c 'gst-launch-1.0 -e \
  rtpsession name=r sdes="application/x-rtp-source-sdes,cname=(string)\"user\@example.com\"" filesrc location="$SELF_PATH" \
  ! decodebin name=d d. \
  ! queue \
  ! videoconvert \
  ! x264enc tune=zerolatency \
  ! rtph264pay \
  ! "application/x-rtp,$SCAPS_VOUT" \
  ! udpsink host=$PEER_IP port=$PEER_V r.send_rtcp_src \
  ! tee name=t t. \
  ! queue \
  ! r.recv_rtcp_sink t. \
  ! queue \
  ! fakesink dump=true async=false'
