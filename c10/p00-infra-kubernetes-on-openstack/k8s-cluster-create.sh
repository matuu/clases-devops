#!/bin/bash
SSH_KEY=`cat ~/.ssh/id_rsa.pub`
image=$(nova image-list | awk '/CoreOS/{ print $4 }')
#MASTER
name=${USER}-k8s-master
cp master-config-template.yaml $name.yaml
sed -i 's/hostname: kubernetes-master/hostname: '$name'/g' $name.yaml
sed -i "s/<SSH_PUBLIC_KEY>/$(echo $SSH_KEY | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/g" $name.yaml

cloud_init_file=$name.yaml
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
echo nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}

IP_MASTER=""
while [ "$IP_MASTER" == "" ]; do
	IP_MASTER=`nova list|grep $name|awk -F "|" '{print $7;}'|awk -F '=' '{print $2}'|tr -d " "`
	echo "Aun sin IP de $name"
	sleep 3
done
echo "IP Master: "$IP_MASTER

#TLS
cp openssl-template.cnf openssl.cnf
sed -i "s/\${K8S_SERVICE_IP}/10.3.0.1/g" openssl.cnf
sed -i "s/\${MASTER_HOST}/$IP_MASTER/g" openssl.cnf
./k8s-cluster-tls-create.sh
BOOT=""
sleep 20
while [ "$BOOT" != "CoreOS" ];do
	BOOT=`ssh -y  core@$IP_MASTER -x cat /etc/lsb-release|grep DISTRIB_ID|awk -F = '{print $2;}'`
	echo "Esperando boot master"
	sleep 5
done
echo $BOOT
	
ssh -y core@$IP_MASTER -x "sudo mkdir -p /etc/kubernetes/ssl"
scp ca.pem apiserver.pem apiserver-key.pem core@$IP_MASTER:/tmp
ssh -y core@$IP_MASTER -x "sudo mv /tmp/ca.pem /tmp/apiserver.pem /tmp/apiserver-key.pem /etc/kubernetes/ssl;sudo chmod 600 /etc/kubernetes/ssl/apiserver-key.pem;sudo chown root:root /etc/kubernetes/ssl/apiserver-key.pem; sudo systemctl restart kubelet"

j2_render() {
  local template_file=${1:?falta archivo template}
  local dst=${2:?falta archivo salida}
  test -f "$dst" && { echo "ERROR: $dst ya existe"; exit 1; }
  (
    export TEMPLATE=$(cat "$template_file")
    python -c "import jinja2, os;t=jinja2.Environment().from_string(os.environ['TEMPLATE']);print t.render(env=os.environ)" > "$dst"
  )
}

#NODEs
for i in 1 2 3 4 5;do
	CA_CERT=`cat ca.pem`
	CA_KEY_CERT=`cat ca-key.pem`
	name=${USER}-k8s-node-$i
	cp node-config-template.yaml $name.yaml
	( # <- subproceso, para no contaminar el env 
	# exporto las env.VARs que use el template
	export NODENAME="$name"
	export SSH_PUBLIC_KEY="$SSH_KEY"
	export KUBERNETES_MASTER="$IP_MASTER"
	export CA_CERT=$(cat ca.pem)
	export CA_KEY_CERT=$(cat ca-key.pem)
	j2_render $name.yaml $name.yaml.tmp
	mv $name.yaml.tmp $name.yaml
	)
	cloud_init_file=$name.yaml
	flavor=m1.small
	net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
	echo nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
	nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
done
