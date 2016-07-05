kubectl run nginx-${USER} --image=nginx
kubectl get deployment
kubectl get rs
kubectl expose deployment nginx-${USER} --port=80 --type=LoadBalancer
kubectl get svc
echo "# scale with:"
echo "kubectl scale deployment nginx-${USER} --replicas=2"
echo "# delete with:"
echo "kubectl delete svc nginx-${USER}"
echo "kubectl delete deployment nginx-${USER}"
