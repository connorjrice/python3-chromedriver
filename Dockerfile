FROM python:3.6
# shamelessly ripped from https://medium.com/@joyzoursky/recent-updates-6264d1e5d42f

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable
RUN apt-get install apt-transport-https

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

# Get freetds 
RUN ACCEPT_EULA=Y apt-get install -y freetds-dev freetds-bin unixodbc-dev tdsodbc

# Create odbc 
RUN echo "[FreeTDS]">> /etc/odbcinst.ini
RUN echo "Description=FreeTDS Driver">> /etc/odbcinst.ini
RUN echo "Driver=/usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so">> /etc/odbcinst.ini
RUN echo "Setup=/usr/lib/x86_64-linux-gnu/odbc/libtdsS.so">> /etc/odbcinst.ini
RUN echo "">> /etc/odbcinst.ini
