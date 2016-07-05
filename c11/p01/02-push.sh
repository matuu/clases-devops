#!/bin/bash
docker tag myappmono-${USER}:latest registry.cloud.um.edu.ar:443/myappmono-${USER}:latest
docker push registry.cloud.um.edu.ar:443/myappmono-${USER}:latest
