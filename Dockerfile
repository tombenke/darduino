FROM ubuntu:24.04

ENV HOME /home/developer
WORKDIR /home/developer

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    apt-get update \
	&& apt-get install -y \
	        software-properties-common \
		libgtk-3-0t64 \
		libsecret-1-0 \
		wget \
		unzip \
		openjdk-11-jre \
		xvfb \
        xz-utils \
	sudo \
    && add-apt-repository ppa:ubuntuhandbook1/apps \
    && apt-get update \
    && apt-get install -y avrdude avrdude-doc \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Add developer user to the dialout group to be able to write the serial USB device
RUN sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i

ENV ARDUINO_IDE_VERSION 2.3.4
RUN wget https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip
RUN (mkdir /usr/local/share/arduino-${ARDUINO_IDE_VERSION} && \
     unzip -d /usr/local/share/arduino-${ARDUINO_IDE_VERSION} arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip && \
     ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino && \
     ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino-ide /usr/local/bin/arduino-ide && \
     chmod 04755 /usr/local/share/arduino-2.3.4/chrome-sandbox)

ENV DISPLAY :1.0

USER developer
