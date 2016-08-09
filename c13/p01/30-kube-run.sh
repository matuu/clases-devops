#!/bin/bash
set -x
gcloud compute disks create --size=200GB  $USER-mysql-disk
sed -i "s/ mysql-disk/ $USER-mysql-disk/g" db-deployment.yaml
kubectl create -f .
