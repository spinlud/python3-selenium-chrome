FROM python:3.6.12-slim-buster

ARG CHROME_VERSION=86.0.4240.75-1
ARG CHROME_DRIVER_VERSION=86.0.4240.22

RUN apt-get update && apt-get install -y \
	wget \
    unzip

RUN mkdir -p /usr/local/tmp \
	cd /usr/local/tmp \
	&& wget http://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
    && apt-get install -y ./google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
	&& wget https://chromedriver.storage.googleapis.com/"$CHROME_DRIVER_VERSION"/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver

COPY requirements.txt /usr/local/tmp/

RUN pip install -r /usr/local/tmp/requirements.txt \
	&& rm -fr /usr/local/tmp
