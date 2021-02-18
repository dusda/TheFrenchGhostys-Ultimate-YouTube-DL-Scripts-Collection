FROM python as build

ENV source https://github.com/pukkandan/yt-dlp
ENV repo https://dl-cdn.alpinelinux.org/alpine/edge
WORKDIR /app

RUN apt update && apt install git
RUN git clone ${source} .

RUN apt install make pandoc python-nose zip -y
RUN make

FROM python as runtime

COPY --from=build /app/youtube-dlc /usr/local/bin/youtube-dlc
RUN chmod +x /usr/local/bin/youtube-dlc

ENTRYPOINT [ "youtube-dlc" ]
