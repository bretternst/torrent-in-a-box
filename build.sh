#!/bin/bash

MEDIA_UID=$(id -u media)
MEDIA_GID=$(id -g media)

docker build --build-arg UID=$MEDIA_UID --build-arg GID=$MEDIA_GID -t torrent .
