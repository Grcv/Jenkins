FROM jenkins/jenkins:lts

USER root

# Instala Docker CLI y dependencias básicas
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        curl \
        ca-certificates \
        gnupg \
        lsb-release && \
    usermod -aG docker jenkins && \
    apt-get clean

# Instala Docker Compose V2 (como plugin de Docker CLI)
RUN mkdir -p /usr/local/lib/docker/cli-plugins && \
    curl -SL https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64 \
    -o /usr/local/lib/docker/cli-plugins/docker-compose && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Verificación (opcional)
RUN docker --version && docker compose version

USER jenkins
