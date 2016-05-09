#!/bin/bash
uvt-kvm create web release=xenial arch=amd64 --user-data=web.yaml --cpu 2 --disk=5 --memory=512 --bridge=virbr0
