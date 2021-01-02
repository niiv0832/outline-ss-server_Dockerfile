#ver-2021.01.02.16.25
###############################################################################
# BUILD STAGE
FROM golang:1.13-alpine

RUN set -x && \
    apk --no-cache --update add \
    bash \
    ca-certificates \
    curl \
    git \
    make \
    upx
    
COPY . /go/src/github.com/niiv0832/outline-ss-server_Dockerfile/

RUN set -x && \
    mkdir -p /go/src/github.com/Jigsaw-Code && \
    cd /go/src/github.com/Jigsaw-Code/ && \
    git clone https://github.com/Jigsaw-Code/outline-ss-server.git && \
    cp /go/src/github.com/niiv0832/outline-ss-server_Dockerfile/Makefile /go/src/github.com/Jigsaw-Code/outline-ss-server/Makefile && \ 
    cd /go/src/github.com/Jigsaw-Code/outline-ss-server/ && \ 
    make -j 4 static && \
    upx --ultra-brute -qq ./outline-ss-server

###############################################################################
# PACKAGE STAGE

FROM scratch

COPY --from=0 /go/src/github.com/Jigsaw-Code/outline-ss-server/outline-ss-server /outline-ss-server

VOLUME ["/cfg"]

EXPOSE 55555

ENTRYPOINT ["/outline-ss-server"]

CMD ["-config", "/cfg/shadowsocks_o.yml", "--replay_history", "1000"]
