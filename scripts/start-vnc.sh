#!/usr/bin/env bash

if [ -z $VNC_NO_PASSWORD ] && [ ! -z $VNC_PASSWD ]; then
    mkdir $HOME/.vnc
    x11vnc -storepasswd $VNC_PASSWD $HOME/.vnc/passwd
    X11VNC_OPTS=-usepw
else
    echo "Starting VNC server without password authentication"
    X11VNC_OPTS=
fi

for i in $(seq 1 10)
do
    sleep 1
    xdpyinfo -display ${DISPLAY} >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        break
    fi
    echo "Waiting for Xvfb..."
done

x11vnc ${X11VNC_OPTS} -forever -shared -rfbport ${VNC_PORT:-5900} -rfbportv6 ${VNC_PORT:-5900} -display ${DISPLAY}