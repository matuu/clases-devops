#!/bin/bash
: ${registry:="registry.cloud.um.edu.ar"}
set -x
docker tag myapp-${USER}:latest ${registry?}/myapp-${USER}:latest
docker push ${registry?}/myapp-${USER}:latest
