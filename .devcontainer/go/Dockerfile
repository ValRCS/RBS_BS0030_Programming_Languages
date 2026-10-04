FROM golang:1.27.1-bookworm
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends git sudo build-essential ca-certificates \
    && groupadd --gid 1000 vscode && useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash vscode \
    && echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode && chmod 0440 /etc/sudoers.d/vscode \
    && mkdir -p /go/pkg /go/bin && chown -R vscode:vscode /go \
    && rm -rf /var/lib/apt/lists/*
