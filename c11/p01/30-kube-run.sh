#!/bin/bash
: ${registry:="registry.cloud.um.edu.ar"}
set -x
kubectl run --image ${registry?}/myappmono-${USER}:latest myappmono-${USER}
# try 1.1 (run -> rc) , else 1.2+ (run -> deployment)
kubectl expose rc myappmono-${USER} --port=80 --type=LoadBalancer --name myappmono-svc-${USER} || \
  kubectl expose deployment myappmono-${USER} --port=80 --type=LoadBalancer --name myappmono-svc-${USER}
