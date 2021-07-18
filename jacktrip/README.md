# Jacktrip Docker

## Deploy

`$ git clone https://github.com/sandreae/jacktrip-docker`

`$ cd jacktrip-docker`

`$ docker build -t jacktrip .`

`$ docker run --ulimit rtprio=99 -p 4464:4464 -p 4464:4464/udp -p 61002:61002/udp jacktrip:latest`
