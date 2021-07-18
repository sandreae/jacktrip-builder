FROM ubuntu:20.04 AS build

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
        ca-certificates \
        # NG-JACKSPA DEPENDENCIES
        invada-studio-plugins-ladspa \
        libglib2.0-dev \
        libncurses5-dev \
        ladspa-sdk \
        ladspa-sdk-dev \
        # JACK_CAPTURE DEPENDENCIES
        libsndfile1-dev 

# BUILD JACKTRIP

RUN mkdir /tmp/jacktrip && \
    git clone --branch ${VERSION_TAG} \
        https://github.com/jacktrip/jacktrip.git /tmp/jacktrip

WORKDIR /tmp/jacktrip/src

RUN qmake jacktrip.pro && make install

# BUILD NG-JACKSPA

WORKDIR /

RUN mkdir /tmp/ng-jackspa && \
    git clone https://repo.or.cz/ng-jackspa.git /tmp/ng-jackspa

WORKDIR /tmp/ng-jackspa

RUN make njackspa jackspa-cli

# BUILD JACK_CAPTURE

RUN mkdir /tmp/jack_capture && \
    git clone https://github.com/kmatheussen/jack_capture.git  /tmp/jack_capture

WORKDIR /tmp/jack_capture

RUN make install

FROM ubuntu:20.04

WORKDIR /

RUN mkdir /build

COPY --from=build /tmp/ng-jackspa/njackspa /build/njackspa
COPY --from=build /tmp/ng-jackspa/jackspa-cli /build/jackspa-cli
COPY --from=build /tmp/jack_capture/jack_capture /build/jack_capture
COPY --from=build /usr/local/bin/jacktrip /build/jacktrip
