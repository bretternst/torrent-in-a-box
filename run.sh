#!/bin/bash
docker run -d -h torrent --name torrent \
    -v /home/media:/home/media \
    -p 9091:9091 \
    --cap-add=NET_ADMIN --device /dev/net/tun \
    --dns=1.1.1.1 \
    --restart unless-stopped \
    torrent
