#!/bin/bash
set -x
kubectl delete -f .
sleep 5
gcloud compute disks delete $USER-mysql-disk
