PEER_V=$1 \
PEER_IP=192.168.1.90 \
\
SELF_V=5000 \
\
\
SCAPS_VIN="media=(string)video,clock-rate=(int)90000,encoding-name=(string)H264,payload=(int)96" \
SCAPS_VOUT="media=(string)video,clock-rate=(int)90000,encoding-name=(string)H264,payload=(int)103" \
bash -c 'gst-launch-1.0 -e \
  rtpsession name=r sdes="application/x-rtp-source-sdes,cname=(string)\"user\@example.com\"" udpsrc port=$SELF_V \
  ! "application/x-rtp,$SCAPS_VIN" \
  ! r.recv_rtp_sink r.recv_rtp_src \
  ! rtph264depay \
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
