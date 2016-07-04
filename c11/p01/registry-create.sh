#!/bin/bash
set -e
name=registry
floating_ip=192.168.3.132
cloud_init_file="registry.yaml"
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
while [ "$IP_REG" == "" ]; do
        IP_REG=`nova list|grep $name|awk -F "|" '{print $7;}'|awk -F '=' '{print $2}'|tr -d " "`
        echo "Aun sin IP de $name"
        sleep 3
done
echo "IP REGISTRY: "$IP_REG

while [ "$BOOT" != "IMAGE" ];do
        BOOT=`ssh -y  ubuntu@$IP_REG -x docker ps|awk '{print $3}'`
        echo "Esperando docker"
        sleep 5
done
echo $BOOT

nova add-floating-ip $name $floating_ip

#Creamos el registry
ssh ubuntu@$IP_REG mkdir -p /home/ubuntu/certs
scp domain.* ubuntu@$IP_REG:/home/ubuntu/certs
ssh ubuntu@$IP_REG 'docker run -d -p 443:5000 --restart=always --name registry.cloud.um.edu.ar -v /home/ubuntu/certs:/certs -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key registry:2'
