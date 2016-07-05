#!/bin/bash
: ${registry:="registry.cloud.um.edu.ar"}
set -x
kubectl run --image ${registry?}/myappmono-${USER}:latest myappmono-${USER}
kubectl expose rc myappmono-${USER} --port=80 --type=LoadBalancer --name myappmono-svc-${USER}
