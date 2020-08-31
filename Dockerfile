#
# Build command
# -------------
# docker build [Args...] --tag kurento/kurento-media-server:latest .
#
#
# Run command
# -----------
# docker run --name kms -p 8888:8888 kurento/kurento-media-server:latest
#
FROM openjdk:8-jre

EXPOSE 8081
EXPOSE 5000/UDP
EXPOSE 50000-50010/UDP

########################################################################################################
# Install GStreamer-1.0:
RUN apt-get update && apt-get install --no-install-recommends --yes \
        libgstreamer1.0-0 gstreamer1.0-dev gstreamer1.0-tools gstreamer1.0-doc \
        gstreamer1.0-plugins-base gstreamer1.0-plugins-good  \
		gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
		gstreamer1.0-libav \
		gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa  gstreamer1.0-pulseaudio \
 && rm -rf /var/lib/apt/lists/*

#######################################################################################################
# Install nano: optional - standard openjdk source image does not have it
RUN apt-get update && apt-get install --no-install-recommends --yes \
        nano \
 && rm -rf /var/lib/apt/lists/*
#######################################################################################################


COPY build/libs/*.jar /var/app.jar
COPY etc/* /var/etc/
WORKDIR /var

ENTRYPOINT ["java","-jar","/var/app.jar" ]
