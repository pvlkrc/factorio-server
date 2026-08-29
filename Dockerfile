FROM debian:bookworm-slim


WORKDIR /factorio

RUN apt update \
    && apt install curl xz-utils -y \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN curl -L -o factorio.tar.gz https://factorio.com/get-download/stable/headless/linux64

RUN tar -xf factorio.tar.gz \ 
    && rm factorio.tar.gz

RUN chmod +x ./factorio/bin/x64/factorio

COPY entrypoint.sh ./



CMD ["sh", "entrypoint.sh"]