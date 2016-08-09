#!/bin/bash
set -x
gcloud compute disks create --size=200GB  mysql-disk
kubectl create -f .
