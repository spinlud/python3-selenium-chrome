FROM python:3.9-slim-bullseye

ARG CHROME_VERSION=116.0.5845.96-1
ARG CHROME_DRIVER_VERSION=116.0.5845.96

RUN apt-get update && apt-get install -y \
	wget \
    unzip

RUN mkdir -p /usr/local/tmp \
	&& cd /usr/local/tmp \
	&& wget http://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
    && apt-get install -y ./google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
 	&& wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/"$CHROME_DRIVER_VERSION"/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64 \
    && mv chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver

COPY requirements.txt /usr/local/tmp/

RUN pip install -r /usr/local/tmp/requirements.txt \
	&& rm -fr /usr/local/tmp
