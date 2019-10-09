Dockerized Arduino IDE
======================

This project is about installing and running the Arduino IDE from a docker image.

You do not have to pollute your original operating system,
with installing the several libs and the app itself.
Instead you only need docker to be installed.

At the same time you can keep your projects on your disk,
that the arduino docker container will reach through volumes.

This solution was made based on the
[Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
blog post written by Fábio Rehm.


## Use the container

Run this if you want the container to be removed after the session:

```bash
    docker run \
        -it \
        --rm \
        --network=host \
        --privileged \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /dev/ttyUSB0:/dev/ttyUSB0 \
        -v $HOME/topics:/topics \
        tombenke/darduino:v1.6.7 \
        arduino
```

Or you can use `docker-compose` script like:

```yml
version: "3.4"

services:
  arduino:
    image: tombenke/darduino
    container_name: arduino
    network_mode: "host"
    environment:
      - "DISPLAY=${DISPLAY}"
    volumes:
      - "/tmp/.X11-unix:/tmp/.X11-unix"
      - "/dev/ttyUSB0:/dev/ttyUSB0"
      - "${HOME}/topics:/topics"
    command: "arduino"
    privileged: true
```

or just simply run the `./arduino.sh` shell script, which contains the command listed above.

In case you want to make changes, then start the container without the `--rm` switch, 
and execute the `commit` and `push` docker commands.

### ESP8266 Board Manager usage

Starting with 1.6.4, Arduino allows installation of third-party platform packages using Boards Manager.

1. Start Arduino and open Preferences window.
2. Enter `http://arduino.esp8266.com/stable/package_esp8266com_index.json`
   into Additional Board Manager URLs field.
   You can add multiple URLs, separating them with commas.
3. Open __Boards Manager__ from __Tools__ > __Board__ menu and install esp8266 platform.
4. Select your ESP8266 board from __Tools__ > __Board__ menu after installation.
   For `ESP8266-12F`, select the __Generic ESP8266 Module__.


## References

- [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
- [Ubuntu Package Search](http://packages.ubuntu.com/)
- [Install the Arduino Software (IDE) on on Linux](https://www.arduino.cc/en/Guide/Linux/)
- [How to Install AVRDude 6.3 in Ubuntu 16.04, Ubuntu 14.04](http://ubuntuhandbook.org/index.php/2017/01/install-avrdude-6-4-ubuntu-16-04/)
