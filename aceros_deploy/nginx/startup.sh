#!/bin/sh

CERT_PATH="/etc/letsencrypt/live/acerosaguilars.com/fullchain.pem"

# Esperar hasta que el archivo exista (máximo 60s)
echo "Esperando a que el certificado esté disponible en $CERT_PATH..."
for i in $(seq 1 60); do
  if [ -f "$CERT_PATH" ]; then
    echo "✅ Certificado encontrado. Arrancando nginx."
    break
  fi
  echo "⏳ Esperando..."
  sleep 2
done

# Si después de esperar no existe, abortamos con mensaje claro
if [ ! -f "$CERT_PATH" ]; then
  echo "❌ Certificado no encontrado después de 60s. Abortando."
  exit 1
fi

# Arrancar nginx normalmente
nginx -g 'daemon off;'
