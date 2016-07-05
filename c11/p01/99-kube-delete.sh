#!/bin/bash
kubectl delete svc myappmono-svc-${USER}
# try 1.1 (run -> rc) , else 1.2+ (run -> deployment)
kubectl delete rc myappmono-${USER} || \
  kubectl delete deployment myappmono-${USER}
