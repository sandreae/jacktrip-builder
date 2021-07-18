FROM ubuntu:18.04 AS build

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

RUN mkdir /tmp/jacktrip-build && \
    git clone --branch ${VERSION_TAG} \
    https://github.com/jacktrip/jacktrip.git /tmp/jacktrip-build

WORKDIR /tmp/jacktrip-build/src

RUN qmake jacktrip.pro && make install

FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=build /usr/local/bin/jacktrip /usr/local/bin/

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
            jackd2 \
            qt5-default && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "@audio - memlock unlimited" >> /etc/security/limits.conf \
    && echo "@audio - rtprio 95" >> /etc/security/limits.conf

ADD start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]
