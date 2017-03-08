FROM ubuntu

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG LANG=de_DE.UTF-8
ARG TERM=xterm
ARG TZ=Europe/Berlin
ARG USER_UID=1000
ARG USER_GID=1000

#
# Environment variables
#
ENV LANG=$LANG \
    TERM=$TERM \
    TZ=$TZ

#
# Setup
#
RUN groupadd -r -g $USER_GID app && \
    useradd -r -u $USER_UID -g app -m app && \
    mkdir /app && \
    chown app:app /app && \
    locale-gen $LANG && \
    update-locale LANG=$LANG && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        iputils-ping \
        iputils-tracepath \
        less \
        nano \
        openssl \
        ssl-cert \
        wget && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
