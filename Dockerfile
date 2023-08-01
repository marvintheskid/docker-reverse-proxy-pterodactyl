FROM alpine:latest

LABEL author="notmarvin"

ARG VERSION="0.1.0"
ARG RUSTTARGET

# Install curl
RUN apk add --no-cache curl

# Download ngrok
RUN curl -Lo /proxy.tar.gz https://github.com/vaperion/reverse-proxy/releases/download/${VERSION}/${VERSION}-${RUSTTARGET}.tar.gz \
    && tar -xzf -o /proxy.tar.gz /bin \
    && rm -f /proxy.tar.gz

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY --chmod=0555 ./entrypoint.sh /entrypoint.sh
CMD "/entrypoint.sh"