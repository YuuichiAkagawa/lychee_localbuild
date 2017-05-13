#GR-LYCHEE offline build

FROM ubuntu:xenial

WORKDIR /mbed

# install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
  python2.7-minimal \
  python-pip \
  curl \
  git \
  mercurial \
  libc6:i386 \
  libstdc++6:i386

# ARM GCC
ENV ARMTOOLCHAIN /opt/gcc-arm-none-eabi-4_9-2015q3
ENV PATH $PATH:$ARMTOOLCHAIN/bin
RUN curl -L https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2 | tar -xjC /opt

# mbed
RUN pip install mbed-cli && mbed import https://github.com/d-kato/blinky-for-lychee

#update mbed-os
RUN cd blinky-for-lychee/mbed-os && mbed sync && mbed update Feature_LYCHEE

RUN echo "umask 000" >> /root/.bashrc

VOLUME ["/mbed/projects"]

CMD ["/bin/bash"]
