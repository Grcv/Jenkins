#!/bin/bash

JENKINS_CONTAINER_NAME="jenkins-docker"

# Obtener todos los contenedores en ejecución
ALL_CONTAINERS=$(docker ps -q)

for container in $ALL_CONTAINERS; do
    NAME=$(docker inspect --format='{{.Name}}' "$container" | sed 's|/||')
    if [ "$NAME" != "$JENKINS_CONTAINER_NAME" ]; then
        echo "Deteniendo y eliminando contenedor: $NAME"
        docker stop "$container"
        docker rm "$container"
    else
        echo "Saltando Jenkins: $NAME"
    fi
done

# Obtener imagen de Jenkins (puede ser usada por más de un contenedor)
JENKINS_IMAGE=$(docker inspect --format='{{.Image}}' $(docker ps -q --filter "name=${JENKINS_CONTAINER_NAME}"))

# Obtener todas las imágenes (únicas)
ALL_IMAGES=$(docker images -q | sort | uniq)

for image in $ALL_IMAGES; do
    if [ "$image" != "$JENKINS_IMAGE" ]; then
        echo "Eliminando imagen: $image"
        docker rmi -f "$image"
    else
        echo "Saltando imagen de Jenkins: $image"
    fi
done

echo "Limpieza completada."
