FROM eclipse-temurin:21-jdk-jammy
ARG DEBIAN_FRONTEND=noninteractive
ARG KOTLIN_VERSION=2.4.0
RUN apt-get update && apt-get install -y --no-install-recommends git curl unzip sudo ca-certificates \
    && curl --fail --location --retry 3 "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" -o /tmp/kotlin.zip \
    && unzip -q /tmp/kotlin.zip -d /opt && rm /tmp/kotlin.zip \
    && groupadd --gid 1000 vscode && useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash vscode \
    && echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode && chmod 0440 /etc/sudoers.d/vscode \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/opt/kotlinc/bin:${PATH}"
