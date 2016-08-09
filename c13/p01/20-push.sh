#!/bin/bash
: ${registry:="gcr.io/noble-office-138223"}
set -x
docker tag myapp:latest ${registry}/myapp:latest
gcloud docker push ${registry}/myapp:latest
