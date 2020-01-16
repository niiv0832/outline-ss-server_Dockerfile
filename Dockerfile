###############################################################################
# BUILD STAGE
FROM rust:alpine

RUN set -x && \
    apk --no-cache --update add \
    bash \
    ca-certificates \
    curl 
    musl-dev \
    git \
    make \
    upx && \
    
    mkdir -p /src && \
    cd /src/ && \
    git clone https://github.com/shadowsocks/shadowsocks-rust.git && \
    cd /src/shadowsocks-rust/ && \ 
    make -j 4 && \
    upx --ultra-brute -qq /usr/local/bin/ssserver

###############################################################################
# PACKAGE STAGE

FROM scratch

COPY --from=0 /usr/local/bin/ssserver /ssserver

VOLUME ["/cfg"]

EXPOSE 55555

ENTRYPOINT ["/ssserver"]

#CMD ["-config", "/cfg/shadowsocks_o.yml", "--replay_history", "1000"]
