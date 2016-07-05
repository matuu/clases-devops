IP=$(kubectl get svc myappsql-svc-${USER} -o json|jq -r .spec.clusterIP)
echo "curl http://${IP:?}/php-mysql/"
