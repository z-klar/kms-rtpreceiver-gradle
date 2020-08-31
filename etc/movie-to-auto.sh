PEER_V=50002 \
PEER_IP=10.0.0.7 \
SELF_PATH="MGB02.mp4" \
SELF_V=5004 \
SELF_VSSRC=2130684 \
bash -c 'gst-launch-1.0 -e \
  rtpbin name=r sdes="application/x-rtp-source-sdes,cname=(string)\"user\@example.com\"" \
  filesrc location="$SELF_PATH" ! decodebin ! autovideosink '
