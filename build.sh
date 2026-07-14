#!/bin/bash

MEDIA_UID=$(id -u media)
MEDIA_GID=$(id -g media)

sudo podman build --build-arg UID=$MEDIA_UID --build-arg GID=$MEDIA_GID -t torrent:latest .
