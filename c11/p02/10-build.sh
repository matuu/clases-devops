#!/bin/bash
[ -z "${http_proxy}"  ] && http_proxy=http://172.16.16.1:8000/
[ -z "${https_proxy}" ] && https_proxy=http://172.16.16.1:8000/

[ "${http_proxy}" = "-" ] && http_proxy=""
[ "${https_proxy}" = "-" ] && https_proxy=""


APP_TAGS=myapp-${USER}:latest
(set -x; 
docker build --build-arg=http_proxy=${http_proxy?} --build-arg=https_proxy=${https_proxy?} -t ${APP_TAGS} .
)
echo "Listo: ${APP_TAGS}"
