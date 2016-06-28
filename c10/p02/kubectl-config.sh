name=${USER}-k8s-master
KUBERNETES_MASTER=`nova list|grep $name|awk -F "|" '{print $7;}'|awk -F '=' '{print $2}'|tr -d " "`
kubectl config set-cluster calico-cluster --server=https://$KUBERNETES_MASTER --certificate-authority=ca.pem
kubectl config set-credentials calico-admin --certificate-authority=ca.pem --client-key=admin-key.pem --client-certificate=admin.pem
kubectl config set-context calico --cluster=calico-cluster --user=calico-admin
kubectl config use-context calico
