FROM --platform=linux/arm64 mcr.microsoft.com/openjdk/jdk:21-mariner AS build

RUN tdnf install -y curl \
    && tdnf clean all \
    && rm -rf /var/cache/tdnf

RUN mkdir -p /opt/mc && \
    curl -o /opt/mc/mc-server.jar https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar

WORKDIR /data
VOLUME /data

EXPOSE 25565

ENTRYPOINT [ "java", "-jar", "-Xms7G", "-Xmx7G", "/opt/mc/mc-server.jar", "nogui" ]
