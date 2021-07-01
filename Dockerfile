FROM ubuntu:18.04 AS build

ARG DEBIAN_FRONTEND=noninteractive

ARG VERSION_TAG="v1.3.0"

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
          autoconf \
          libtool \
          automake \
          jackd2 \
          libjack-jackd2-dev \
          librtaudio-dev \
          qt5-default \ 
          qt5-qmake \
          g++ \
          git \
          ca-certificates

RUN mkdir /tmp/jacktrip-build && \
        git clone --branch ${VERSION_TAG} \
        https://github.com/jacktrip/jacktrip.git /tmp/jacktrip-build

WORKDIR /tmp/jacktrip-build/src

RUN qmake jacktrip.pro && make install

WORKDIR /

RUN echo "@audio - memlock unlimited" >> /etc/security/limits.conf \
        && echo "@audio - rtprio 95" >> /etc/security/limits.conf

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
