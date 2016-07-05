sed "s/@EDITAR_USUARIO@/${USER}/" myappsql-pod.tmpl.yaml > /tmp/myappsql-pod-${USER}.yaml
kubectl create -f /tmp/myappsql-pod-${USER}.yaml
