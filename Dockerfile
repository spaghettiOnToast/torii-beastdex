FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

ARG TORII_VERSION=v1.8.16
ARG TARGETARCH=amd64

RUN curl -fL \
    "https://github.com/dojoengine/torii/releases/download/${TORII_VERSION}/torii_${TORII_VERSION}_linux_${TARGETARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/torii

RUN mkdir -p /data /app

COPY torii.toml.template /app/torii.toml.template
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["/app/entrypoint.sh"]
