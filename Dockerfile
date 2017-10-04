FROM ubuntu:14.04
FROM python:3.6

# Install Deps
RUN apt-get update &&\
    apt-get install -y \
    sudo \
    libxss1 \
    libasound2-dev \
    fonts-liberation \
    libnss3 \
    libappindicator1 \
    libindicator7 \
    unzip \
    wget \
    xvfb \
    xdg-utils \
    xserver-xephyr \
    build-essential \
    curl \
    supervisor \
    imagemagick \
    libgtk-3-0 \
    lsb-release \
    libexif \
    udev \
    libgconf-2-4; exit 0

# Install Chrome and driver
RUN wget -O chrome-amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-check-certificate && \
    dpkg -i chrome-amd64.deb; exit 0
RUN apt-get -f install -y
RUN wget -N http://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip && \
    unzip *.zip && \
    chmod +x chromedriver && \
    mv -f chromedriver /usr/local/share/chromedriver && \
    ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver && \
    ln -s /usr/local/share/chromedriver /usr/bin/chromedriver && \
    rm *.zip *.deb

# Install node, meteor and selenium deps
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
 && apt-get install -y \
    nodejs \
 && curl https://install.meteor.com/ | sh \
 && npm -g install forever \
 && pip3 install pyvirtualdisplay selenium