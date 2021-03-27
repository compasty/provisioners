#!/usr/bin/env bash
sudo yum -y remove docker docker-common docker-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 get git
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
