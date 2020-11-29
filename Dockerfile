FROM debian:buster-slim

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y --no-install-recommends install wget xvfb libgbm1 libasound2 xauth ca-certificates

RUN wget -nv --show-progress --progress=bar:force https://github.com/jgraph/drawio-desktop/releases/download/v13.9.9/draw.io-amd64-13.9.9.deb

RUN DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install ./draw.io-amd64-13.9.9.deb && \
    chmod +4755 /opt/draw.io/chrome-sandbox

RUN apt autoremove -y && \
    rm -rf /var/lib/apt/lists/ && \
    rm -f ./draw.io-amd64-13.9.9.deb

ENTRYPOINT ["sh", "-c", "xvfb-run -a /usr/bin/drawio --no-sandbox -f ${INPUT_FORMAT} -x -o ${INPUT_DESTINATION} ${INPUT_SOURCE}"]

