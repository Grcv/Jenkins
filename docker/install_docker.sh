#!/bin/bash
set -e

echo "🚀 Instalando Docker y Docker Compose en Ubuntu..."

# 1. Actualizar paquetes
sudo apt update && sudo apt upgrade -y

# 2. Instalar dependencias
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# 3. Agregar clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

# 4. Agregar repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Instalar Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y

# 6. Habilitar Docker para iniciar automáticamente
sudo systemctl enable docker
sudo systemctl start docker

# 7. Instalar Docker Compose (última versión)
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 8. Agregar usuario actual al grupo docker
sudo usermod -aG docker $USER

# 9. Verificar instalaciones
echo "✅ Docker instalado: $(docker --version)"
echo "✅ Docker Compose instalado: $(docker-compose --version)"
echo "🔄 Cierra sesión y vuelve a entrar para usar Docker sin sudo."
