
# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install Node.js (from tarball)
ENV NODE_VERSION 0.12.0
ADD http://assets.hypriot.com/node-v${NODE_VERSION}-linux-armv6hf.tar.gz /
RUN \
  cd /usr/local/ && \
  tar --strip-components 1 -xzf /node-v${NODE_VERSION}-linux-armv6hf.tar.gz && \
  rm -f node-v${NODE_VERSION}-linux-armv6hf.tar.gz

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]
