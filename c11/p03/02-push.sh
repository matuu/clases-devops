#!/bin/bash
docker tag myapp-${USER}:latest registry.cloud.um.edu.ar:443/myapp-${USER}:latest
docker push registry.cloud.um.edu.ar:443/myapp-${USER}:latest
