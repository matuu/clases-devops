#!/bin/bash
uvt-kvm create tercervm release=xenial arch=amd64 --bridge virbr0 --memory 512 --disk 10 --user-data tercervm.yaml
