FROM anhdhbn/container-novnc-gui:ubuntu-base as ubuntu-xfce

RUN apt-get update -qqy \
    && apt-get -qqy install --no-install-recommends \
        dbus-x11 xfce4 \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV SCREEN_WIDTH=1600 \
    SCREEN_HEIGHT=900 \
    SCREEN_DEPTH=24 \
    SCREEN_DPI=96 \
    DISPLAY=:99 \
    DISPLAY_NUM=99

COPY gui/ubuntu-xfce.sh /opt/bin/start-ui.sh

COPY entry_point.sh /opt/bin/

RUN chmod +x /opt/bin/entry_point.sh /opt/bin/start-ui.sh

USER ubuntu

CMD ["/opt/bin/entry_point.sh"]