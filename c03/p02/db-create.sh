#!/bin/bash
uvt-kvm create db release=xenial arch=amd64 --user-data=db.yaml --cpu 2 --disk=5 --memory=512 --bridge=virbr0
