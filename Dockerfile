FROM python:3.9-slim-bullseye

ARG CHROME_VERSION=125.0.6422.141-1
ARG CHROME_DRIVER_VERSION=125.0.6422.141

RUN apt-get update && apt-get install -y \
	wget \
    unzip

RUN mkdir -p /usr/local/tmp \
	&& cd /usr/local/tmp \
	&& wget http://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
    && apt-get install -y ./google-chrome-stable_"$CHROME_VERSION"_amd64.deb \
 	&& wget https://storage.googleapis.com/chrome-for-testing-public/"$CHROME_DRIVER_VERSION"/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver

COPY requirements.txt /usr/local/tmp/

RUN pip install -r /usr/local/tmp/requirements.txt \
	&& rm -fr /usr/local/tmp