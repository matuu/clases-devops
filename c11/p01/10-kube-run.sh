kubectl run --image registry.cloud.um.edu.ar:443/myappmono-${USER}:latest myappmono-${USER}
kubectl expose rc myappmono-${USER} --port=80 --type=LoadBalancer --name myappmono-svc-${USER}
