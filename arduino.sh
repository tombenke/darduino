#!/bin/bash
# Starts the Arduino IDE using the docker image.

docker run \
    -it \
    --rm \
    --privileged \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/ttyUSB0:/dev/ttyUSB0 \
    -v $HOME/topics:/topics \
    tombenke/darduino:latest \
    arduino
