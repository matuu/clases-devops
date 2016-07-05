#!/bin/bash
: ${registry:="registry.cloud.um.edu.ar"}
set -x
docker tag myappmono-${USER}:latest ${registry?}/myappmono-${USER}:latest
docker push ${registry?}/myappmono-${USER}:latest
