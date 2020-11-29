FROM debian:buster-slim

ENV DRAWIO_VERSION 13.9.9

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y --no-install-recommends install wget xvfb libgbm1 libasound2 xauth ca-certificates

RUN wget -nv --show-progress --progress=bar:force \
      https://github.com/jgraph/drawio-desktop/releases/download/v${DRAWIO_VERSION}/draw.io-amd64-${DRAWIO_VERSION}.deb

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y --no-install-recommends install ./draw.io-amd64-${DRAWIO_VERSION}.deb && \
    chmod +4755 /opt/draw.io/chrome-sandbox

RUN apt autoremove -y && \
    rm -rf /var/lib/apt/lists/ && \
    rm -f ./draw.io-amd64-${DRAWIO_VERSION}.deb

ENTRYPOINT ["sh", "-c", "xvfb-run -a /usr/bin/drawio -f ${INPUT_FORMAT} -x -o ${INPUT_DESTINATION} ${INPUT_SOURCE} --no-sandbox"]
