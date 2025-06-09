#!/bin/bash

docker build -t jenkins-docker .
docker run \
  -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  -p 8080:8080 \
  --name jenkins-docker \
  jenkins-docker