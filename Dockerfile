FROM frolvlad/alpine-python3
MAINTAINER Alexandre Andrade <kaniabi@gmail.com>

ENV WORKDIR="/srv" APPDIR="/app" ERR_USER="err"
WORKDIR $WORKDIR

#ENV ERR_USER err
#ENV DEBIAN_FRONTEND noninteractive
#ENV PATH /app/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Set default locale for the environment
#ENV LC_ALL C.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US.UTF-8

## Add err user and group
#RUN groupadd -r $ERR_USER \
#    && useradd -r \
#       -g $ERR_USER \
#       -d /srv \
#       $ERR_USER

# Install packages and perform cleanup
RUN apk add --no-cache git py-cffi
#    locales \
#    dnsutils \
#    python3-dnspython \
#    python3-openssl \
#    python3-cffi \
#    python3-pyasn1
RUN pip3 install --upgrade pip
RUN pip3 install virtualenv

RUN mkdir $WORKDIR/data $WORKDIR/plugins $WORKDIR/errbackends $APPDIR
#    && chown -R $ERR_USER: /srv /app

#USER $ERR_USER

COPY requirements.txt $APPDIR/requirements.txt
COPY config.py $APPDIR/config.py
COPY run.sh $APPDIR/venv/bin/run.sh

RUN virtualenv --system-site-packages -p python3 $APPDIR/venv  && \
    $APPDIR/venv/bin/pip3 install --no-cache-dir -r $APPDIR/requirements.txt

EXPOSE 3141 3142
VOLUME ["/srv"]

CMD ["/app/venv/bin/run.sh"]
