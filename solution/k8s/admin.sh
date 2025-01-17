#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin
export CONTROL_PANEL_IP=$1
echo "CONTROL PANEL IP: $CONTROL_PANEL_IP"

MIRROR="aliyun" # <empty>/aliyun
KUBE_VERSION="1.28"

sh -c "/vagrant/service/k8s/install.sh $KUBE_VERSION $MIRROR"
sh -c "/vagrant/service/k8s/setup-control-panel.sh $CONTROL_PANEL_IP $MIRROR"