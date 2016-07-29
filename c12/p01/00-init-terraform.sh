#|/bin/bash

# seteamos la variables para terraform

PATH=/usr/local/terraform/bin:/home/$USER/terraform:$PATH
export TF_VAR_USER=$USER;
export TF_VAR_PASS=$OS_PASSWORD;

cd conf/tmpconsul/
wget http://192.168.3.251/consul/0.6.4/consul_0.6.4_linux_amd64.zip

