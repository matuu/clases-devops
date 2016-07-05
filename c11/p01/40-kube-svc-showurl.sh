IP=$(kubectl get svc myappmono-svc-${USER} -o json|jq -r .spec.clusterIP)
echo "curl http://${IP:?}/php-mysql/"
