ARG BASE_VERSION=16.04
ARG BUILD_VERSION=hnd_arm
FROM i386/ubuntu:${BASE_VERSION} AS base
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && \
    apt-get update && \
    apt-get install -y \
    autoconf \
    autogen \
    automake \
    autopoint \
    bash \
    bc \
    binutils-dev \
    bison \
    build-essential \
    bzip2 \
    cmake \
    cvs \
    device-tree-compiler \
    diffutils \
    docbook-xsl-* \
    dos2unix \
    file \
    flex \
    g++ \
    g++-multilib \
    gawk \
    gcc-multilib \
    gengetopt \
    gettext \
    git \
    gperf \
    groff-base \
    gtk-doc-tools \
    intltool \
    libelf-dev \
    libelf1:i386 \
    libexpat1-dev \
    libglib2.0-dev \
    libicu-dev \
    liblzma-dev \
    liblzo2-dev \
    libncurses-dev \
    libncurses5 \
    libncurses5-dev \
    libnss-wrapper \
    libproxy-dev \
    libslang2 \
    libssl-dev \
    libstdc++5 \
    libtool \
    libtool-bin \
    libvorbis-dev \
    libxml-parser-perl \
    libxml2-dev \
    lzma \
    lzma-dev \
    m4 \
    make \
    mtd-utils \
    patch \
    perl \
    pkg-config \
    python \
    python\
    qemu-system-arm \
    qemu-system-aarch64 \
    qemu-user-static \
    sed \
    sharutils \
    shtool \
    tar \
    texinfo \
    u-boot-tools \
    unzip \
    uuid-dev \
    vim-common \
    wget \
    xsltproc \
    xutils-dev \
    zlib1g \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY nss_wrapper /usr/local/bin/

# Setup the different toolchains
FROM base AS am-toolchains
RUN git clone https://github.com/RMerl/am-toolchains.git /opt/am-toolchains

FROM base as brcm_arm_hnd
COPY --from=am-toolchains /opt/am-toolchains/brcm-arm-hnd /opt/toolchains

FROM base as brcm_arm_sdk
COPY --from=am-toolchains /opt/am-toolchains/brcm-arm-sdk /opt/toolchains
# For compability with merlin git see this symlink
# https://github.com/RMerl/asuswrt-merlin.ng/blob/master/release/src-rt-6.x.4708/toolchains
RUN mkdir -p /home/merlin/am-toolchains/ && \
    ln -s /home/merlin/am-toolchains/brcm-arm-sdk \
    /opt/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3
ENV PATH ${PATH}:/opt/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin

FROM brcm_arm_hnd as hnd_arm
ENV LD_LIBRARY_PATH=${LD_LIBRARY}:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib
ENV TOOLCHAIN_BASE=/opt/toolchains
ENV PATH ${PATH}:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin
ENV PATH ${PATH}:/opt/toolchains/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin
RUN ln -sf /bin/bash /bin/sh

FROM brcm_arm_hnd as hnd_ax_arm
ENV LD_LIBRARY_PATH=${LD_LIBRARY}:/opt/toolchains/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/lib
ENV TOOLCHAIN_BASE=/opt/toolchains
ENV PATH ${PATH}:/opt/toolchains/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/bin
ENV PATH ${PATH}:/opt/toolchains/crosstools-aarch64-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/bin

FROM ${BUILD_VERSION} AS start
FROM start
# Map user and dont run as root
USER 1000
ENTRYPOINT ["nss_wrapper"]
CMD ["bash"]
