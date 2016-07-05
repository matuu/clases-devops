sed "s/@EDITAR_USUARIO@/${USER}/" myappsql-rc.tmpl.yaml > /tmp/myappsql-rc-${USER}.yaml
kubectl create -f /tmp/myappsql-rc-${USER}.yaml
