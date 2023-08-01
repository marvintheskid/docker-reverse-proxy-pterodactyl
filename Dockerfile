FROM alpine:latest

LABEL author="notmarvin"

ARG VERSION="0.1.0"
ARG RUSTTARGET

# Install curl
RUN apk add --no-cache curl

# Install tar since Busybox' tar doesn't support all tar features
RUN apk add --no-cache tar

# Download ngrok
RUN curl -Lo /proxy.tar.gz https://github.com/vaperion/reverse-proxy/releases/download/$VERSION/$VERSION-$RUSTTARGET.tar.gz \
    && tar -xzf /proxy.tar.gz -C /bin \
    && rm -f /proxy.tar.gz

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY --chmod=0555 ./entrypoint.sh /entrypoint.sh
CMD "/entrypoint.sh"