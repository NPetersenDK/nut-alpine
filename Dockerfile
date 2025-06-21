#FROM alpine:latest
# Use the Alpine edge version as a base image to reduce final size.
FROM alpine:edge AS builder

# Set environment variable
ENV NUT_VERSION=2.8.3

# Install dependencies and build NUT
RUN set -ex; \
    apk add --no-cache \
        openssh-client \
        libusb-compat \
        curl; \
    apk add --no-cache --virtual .build-deps \
        libusb-compat-dev \
        build-base; \
    cd /tmp; \
    wget http://www.networkupstools.org/source/2.8/nut-$NUT_VERSION.tar.gz; \
    tar xfz nut-$NUT_VERSION.tar.gz; \
    cd nut-$NUT_VERSION; \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/nut \
        --disable-dependency-tracking \
        --enable-strip \
        --disable-static \
        --with-all=no \
        --with-usb=yes \
        --datadir=/usr/share/nut \
        --with-drvpath=/usr/share/nut \
        --with-statepath=/var/run/nut \
        --with-user=nut \
        --with-group=nut; \
    make install; \
    adduser -D -h /var/run/nut nut; \
    chgrp -R nut /etc/nut; \
    chmod -R o-rwx /etc/nut; \
    install -d -m 750 -o nut -g nut /var/run/nut; \
    rm -rf /tmp/nut-$NUT_VERSION.tar.gz /tmp/nut-$NUT_VERSION; \
    apk del .build-deps

# Create necessary directories
RUN mkdir -p /var/run /run && \
    chown -R nut:nut /var/run /run && \
    chmod -R 750 /var/run /run

# Copy the entrypoint script
COPY src/docker-entrypoint /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint"]

# Set the working directory
WORKDIR /var/run/nut

# Expose the port
EXPOSE 3493/tcp

# Add a maintainer label
LABEL maintainer="NPetersen <git@nipetersen.dk>"