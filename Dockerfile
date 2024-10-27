FROM --platform=linux/arm64 mcr.microsoft.com/openjdk/jdk:21-mariner AS build

RUN tdnf install -y curl \
    && tdnf clean all \
    && rm -rf /var/cache/tdnf

RUN mkdir -p /opt/mc && \
    curl -o /opt/mc/mc-server.jar https://piston-data.mojang.com/v1/objects/45810d238246d90e811d896f87b14695b7fb6839/server.jar

WORKDIR /data
VOLUME /data

EXPOSE 25565

ENTRYPOINT [ "java", "-jar", "-Xms6G", "-Xmx6G", "/opt/mc/mc-server.jar", "nogui" ]
