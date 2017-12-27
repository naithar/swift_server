FROM naithar/swift_imagemagick:0.1.0

ENV CURL_VERSION=7.47.0
ENV CURL_UBUNTU_VERSION=1ubuntu2.2

RUN apt-get -y update \
    && apt-get -y install apt-utils \
    && apt-get -y install software-properties-common \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial main restricted \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial universe \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial-updates universe \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial multiverse \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial-updates multiverse \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse \
     >> /etc/apt/sources.list \
    && echo deb-src http://archive.canonical.com/ubuntu xenial partner \
     >> /etc/apt/sources.list \
    && apt-get -y update \
    && apt-get -y build-dep curl

RUN apt-get -y install git \
    && git clone https://github.com/tatsuhiro-t/nghttp2.git \
    && cd nghttp2 \
    && autoreconf -i \
    && automake \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && ldconfig /usr/local/lib

RUN apt-get -y install wget \
    && apt-get build-dep curl \
    && wget http://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2 \
    && tar -xvjf curl-$CURL_VERSION.tar.bz2 \
    && cd curl-$CURL_VERSION \
    && ./configure --with-nghttp2=/usr/local --with-ssl \
    && make \
    && make install \
    && ldconfig /usr/local/lib

RUN apt-get -y purge \
      build-essential \
      autoconf \
      automake \
      autotools-dev \
      cpp-5 \
      debhelper \
      g++-5 \
      libstdc++-5-dev \
      gcc-5 \
      libgcc-5-dev \
      intltool-debian \
      make \
      m4 \
      patch \
      python2.7 \
      libpython2.7-minimal \
      perl \
      perl-modules-5.22 \
      libp11-kit-dev \
      libtasn1-6-dev \
      nettle-dev \
    && apt-get -y autoremove \
    && rm -rf /tmp/*

RUN curl --version
RUN curl --http2 -I nghttp2.org

RUN apt-get -y update && \
	apt-get install -y --no-install-recommends apt-utils && \
	apt-get -y install libpq-dev

RUN echo "PG"

