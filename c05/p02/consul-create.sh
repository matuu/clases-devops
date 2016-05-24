#!/bin/bash
set -e
name=consul
cloud_init_file="consul.yaml"
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" --availability-zone "nova:um-stack-01" ${name}

neutron floatingip-create --floating-ip-address 192.168.3.130 ext_net
nova floating-ip-associate consul 192.168.3.130
nova add-secgroup  consul sg-consul
