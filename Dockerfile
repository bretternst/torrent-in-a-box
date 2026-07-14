FROM debian:trixie

ARG UID=1000
ARG GID=1000
ARG S6_OVERLAY_VERSION=3.2.1.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openvpn transmission-daemon iproute2 xz-utils nftables curl ca-certificates jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists \
    && groupadd -g $GID media \
    && useradd -u $UID -g media media

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ADD https://raw.githubusercontent.com/pia-foss/manual-connections/master/ca.rsa.4096.crt /etc/openvpn/client/ca.rsa.4096.crt

COPY vpn/ /etc/openvpn/client/
COPY jobs/ /etc/s6-overlay/s6-rc.d/
COPY nftables.rules /etc/
RUN chmod 600 /etc/openvpn/client/*.txt || true \
    && chmod +x /etc/s6-overlay/s6-rc.d/portforward/run

VOLUME /home/media
EXPOSE 9091

ENTRYPOINT ["/init"]
