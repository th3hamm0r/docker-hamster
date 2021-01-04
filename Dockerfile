FROM ubuntu:18.04

RUN apt-get update && apt-get install -y tzdata locales
RUN echo "Europe/Vienna" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_AT.UTF-8 UTF-8/de_AT.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="de_AT.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=de_AT.UTF-8

ENV LANG de_AT.UTF-8
ENV LANGUAGE de_AT.UTF-8
ENV LC_ALL de_AT.UTF-8

RUN apt-get -y install libwnck22 libwnck-common  python-gtk2 python-gconf python-gnome2 libbonoboui2-0 libgnomecanvas2-0 libgnomeui-0 python-pyorbit libglade2-0 libbonoboui2-common libgnomecanvas2-common libgnome-keyring0 libgnomeui-common liborbit2 libgnome-keyring-common libidl-2-0 python-dbus python-xdg python-notify python-appindicator python-gobject libcanberra-gtk-module sudo ca-certificates notify-osd

COPY python-wnck_2.32.0+dfsg-3_amd64.deb /tmp/
RUN dpkg -i /tmp/python-wnck_2.32.0+dfsg-3_amd64.deb
COPY hamster-applet_2.91.3+git20120514.b9fec3e1-1ubuntu2_all.deb /tmp/
RUN dpkg -i /tmp/hamster-applet_2.91.3+git20120514.b9fec3e1-1ubuntu2_all.deb
COPY hamster-indicator_0.1+037dd2e-0ubuntu2_all.deb /tmp/
RUN dpkg -i /tmp/hamster-indicator_0.1+037dd2e-0ubuntu2_all.deb

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
USER developer
ENV HOME /home/developer
RUN mkdir -p /home/developer/.local/share/hamster-applet
RUN mkdir -p /home/developer/.gconf/apps/hamster-applet
RUN touch /home/developer/.gconf/apps/%gconf.xml

#CMD /usr/bin/hamster-indicator
COPY run_hamster.sh /tmp/
CMD /tmp/run_hamster.sh
#CMD /bin/bash

