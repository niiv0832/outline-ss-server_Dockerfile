###############################################################################
# BUILD STAGE
FROM alpine:latest
ARG SS_VER=1.0.7

RUN set -x && \
    apk --no-cache --update add wget && \
    mkdir /tmp/repo && \
    mkdir /ssserv && \
    cd /tmp/repo && \
    wget --no-check-certificate https://github.com/Jigsaw-Code/outline-ss-server/releases/download/v${SS_VER}/outline-ss-server_${SS_VER}_linux_x86_64.tar.gz -O /tmp/ssserv.tar.gz && \
    tar -xvf /tmp/ssserv.tar.gz -C /ssserv


###############################################################################
# PACKAGE STAGE

FROM scratch

ENTRYPOINT ["outline-ss-server"]
#ENV SS_IP=0.0.0.0 \
#    SS_PORT=3128 \
#    SS_STATS_IP=0.0.0.0 \
#    SS_STATS_PORT=3129
EXPOSE 55555 9091

COPY --from=0 /ssserv/outline-ss-server /outline-ss-server
