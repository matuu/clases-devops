#!/bin/bash
test -d $HOME/bin || { echo "$HOME/bin doesn't exist. aborting." ; exit 1 ;}
K8S_VERSION=$(curl -sS https://storage.googleapis.com/kubernetes-release/release/stable.txt)
set -x
(cd $HOME/bin || exit 1
test -x kubectl-${K8S_VERSION} && exit 0
wget -O kubectl.tmp http://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/linux/amd64/kubectl && mv kubectl.tmp kubectl-${K8S_VERSION}
chmod +x kubectl-${K8S_VERSION}
ln -sf kubectl-${K8S_VERSION} kubectl
)
