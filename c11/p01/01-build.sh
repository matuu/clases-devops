#!/bin/bash
APP_TAGS=myappmono-${USER}:latest
(set -x; 
docker build --build-arg=http_proxy=http://172.16.16.1:8000/ --build-arg=https_proxy=http://172.16.16.1:8000/ -t ${APP_TAGS} .
)
echo "Listo: ${APP_TAGS}"
