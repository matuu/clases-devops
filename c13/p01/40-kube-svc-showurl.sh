IP=$(kubectl get svc myapp-svc -o json|jq -r .status.loadBalancer.ingress[0].ip)
echo "http://${IP:?}/"
