FROM ubuntu:20.04

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    curl \
    git \
    python3-pip \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg8-dev \
    zlib1g-dev \
    gpg-agent \
    sqlite3 \
    autoconf \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ondrej/php -y > /dev/null 2> /dev/null || true

RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
	zip \
	unzip \
	nodejs \
	graphviz \
	ruby-full \
	php7.3-cli \
	php7.3-mbstring \
	php7.3-mysql \
	php7.3-zip \
	php7.3-curl \
	php7.3-gd \
	php7.3-imagick \
	php7.3-xml \
	php7.3-soap \
	php7.3-intl \
	php7.3-xmlrpc \
	php7.3-memcached \
	php7.3-xdebug \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN gem install deb-s3 bundler

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
	fakeroot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install setuptools --upgrade \
 && pip3 install awscli --upgrade

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN mkdir -p /www

WORKDIR /www
