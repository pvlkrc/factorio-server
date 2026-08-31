FROM debian:bookworm-slim

WORKDIR /factorio

ARG VER=2.0.77

RUN apt update \
    && apt install curl xz-utils ca-certificates -y --no-install-recommends \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN curl -L -o factorio.tar.gz https://factorio.com/get-download/$VER/headless/linux64

RUN tar -xf factorio.tar.gz \ 
    && rm factorio.tar.gz \
    && chmod +x ./factorio/bin/x64/factorio 

COPY entrypoint.sh ./

CMD ["sh", "entrypoint.sh"]