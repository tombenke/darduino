Dockerized EAGLE
================

This project is about installing and running the Arduino IDE from a docker image.

You do not have to pollute your original operating system, with installing the several libs and the app itself.
Instead you only need docker to be installed.

At the same time you can keep your projects on your disk, that the arduino docker container will reach through volumes.

This solution was made based on the [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
blog post written by Fábio Rehm.


## Use the container

Run this if you want the container to be removed after the session:

```bash
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
```

or just simply run the `./arduino.sh` shell script, which contains the command listed above.

In case you want to make changes, then start the container without the `--rm` switch, 
and execute the `commit` and `push` docker commands.


## References

- [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
- [Ubuntu Package Search](http://packages.ubuntu.com/)
- [Install the Arduino Software (IDE) on on Linux](https://www.arduino.cc/en/Guide/Linux/)
