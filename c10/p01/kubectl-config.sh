KUBERNETES_MASTER=10.201.9.111
kubectl config set-cluster calico-cluster --server=https://$KUBERNETES_MASTER --certificate-authority=ca.pem
kubectl config set-credentials calico-admin --certificate-authority=ca.pem --client-key=admin-key.pem --client-certificate=admin.pem
kubectl config set-context calico --cluster=calico-cluster --user=calico-admin
kubectl config use-context calico
