#!/bin/bash
set -e
name=c06-${USER}-web
cloud_init_file="web.yaml"
grep -q EDITAR_USUARIO ${cloud_init_file} && { echo "ERROR: tenes que editar EDITAR_USUARIO con tu nombre en ${cloud_init_file}" ; exit 1; }
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
