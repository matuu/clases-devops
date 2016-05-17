#!/bin/bash
set -e
name=sapito
cloud_init_file="sapito.yaml"
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.medium
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} --availability-zone "nova:um-stack-01" "$@" ${name}
