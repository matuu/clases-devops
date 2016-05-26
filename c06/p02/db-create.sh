#!/bin/bash
vol_id=${1:?missing volume_uuid (create with eg.: openstack volume create --description db-vol --size 10)}
shift
set -e
name=c06-${USER}-db
cloud_init_file="db.yaml"
grep -q EDITAR_USUARIO ${cloud_init_file} && { echo "ERROR: tenes que editar EDITAR_USUARIO con tu nombre en ${cloud_init_file}" ; exit 1; }
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
block_args="--block-device-mapping vdb=${vol_id}:::0"
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${block_args} ${name}
