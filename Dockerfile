FROM alpine:3.23.5


WORKDIR /factorio

RUN curl -L -o factorio.tar.gz https://factorio.com/get-download/stable/headless/linux64
RUN tar -xf factorio.tar.gz
RUN rm factorio.tar.gz
COPY entrypoint.sh ./

CMD ["sh", "entrypoint.sh"]