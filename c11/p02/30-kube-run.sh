#!/bin/bash
: ${registry:="registry.cloud.um.edu.ar"}
sed -e "s/@EDITAR_USUARIO@/${USER}/" -e "s/@EDITAR_REGISTRY@/${registry?}/" myappsql-rc.tmpl.yaml > /tmp/myappsql-rc-${USER}.yaml || exit 1
set -x
kubectl create -f /tmp/myappsql-rc-${USER}.yaml
