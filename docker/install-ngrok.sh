#!/bin/bash
set -e

# 1. Descargar ngrok
wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip

# 2. Descomprimir
unzip -o ngrok-stable-linux-amd64.zip

# 3. Mover binario a /usr/local/bin
sudo mv ngrok /usr/local/bin/
sudo chmod +x /usr/local/bin/ngrok

# 4. Limpiar archivos temporales
rm ngrok-stable-linux-amd64.zip

# 5. Pedir el token al usuario
read -p "Ingresa tu ngrok authtoken: " NGROK_TOKEN

# 6. Configurar token
ngrok authtoken $NGROK_TOKEN

# 7. Iniciar túnel en background y guardar logs
nohup ngrok http 8080 > ngrok.log 2>&1 &

echo "✅ ngrok instalado y túnel abierto en puerto 8080"
echo "Revisa el archivo ngrok.log para ver la URL pública."
