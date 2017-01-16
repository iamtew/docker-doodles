FROM fedora:25

RUN set -xe \
    && echo "deltarpm=0" >> /etc/dnf/dnf.conf \
    && dnf --assumeyes update \
    && dnf clean all

RUN set -xe \
    && dnf update --assumeyes \
    && dnf group install --assumeyes \
    development-tools \
    && dnf install --assumeyes \
           curl \
           git \
           iputils \
           screen \
           vim-common \
           wget \
    && dnf clean all

RUN set -xe \
    && setcap cap_net_raw,cap_net_admin+p /usr/bin/ping

ADD doodles.sh /etc/profile.d/doodles.sh
