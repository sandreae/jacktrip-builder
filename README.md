# Build JackTrip (+ other useful deps)

Several Dockerfiles for building the following:

- JackTrip built in Ubuntu 20.04 container
- JackTrip built in Raspberry Pi OS container
- JackTrip + other dependencies needed for running a [`pypatcher`](https://github.com/noiseorchestra/jacktrip_pypatcher) server built in Ubuntu 20.04 container

## Build

### From docker hub (just pypatcher atm)

```
$ docker create sandreae/pypatcher_deps:latest
# prints CONTAINER_ID
$ docker cp {{CONTAINER_ID:build}}/. /usr/local/bin/
```

### From repo

```
$ git clone https://github.com/sandreae/jacktrip-builder
# Enter the relevent folder
$ cd jacktrip
$ docker built -t jacktrip-builder .
$ docker create jacktrip-builder
# prints CONTAINER_ID
$ docker cp {{CONTAINER_ID:build}}/. /usr/local/bin/
```
