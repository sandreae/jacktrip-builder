FROM balenalib/rpi-raspbian:latest AS build

ARG DEBIAN_FRONTEND=noninteractive

ARG VERSION_TAG="v1.3.0"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        autoconf \
        libtool \
        automake \
        qt5-default \ 
        qt5-qmake \
        g++ \
        make \
        git \
        librtaudio-dev\
        libjack-jackd2-dev \
        ca-certificates

# BUILD JACKTRIP

RUN mkdir /tmp/jacktrip && \
    git clone --branch ${VERSION_TAG} \
        https://github.com/jacktrip/jacktrip.git /tmp/jacktrip

WORKDIR /tmp/jacktrip/src

RUN qmake jacktrip.pro && make install

FROM balenalib/rpi-raspbian:latest

WORKDIR /

RUN mkdir /build

COPY --from=build /usr/local/bin/jacktrip /build/jacktrip
