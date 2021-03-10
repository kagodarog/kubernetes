#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull 

echo "[TASK 2] Initialize Kubernetes Cluster"
#kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 
kubeadm init --apiserver-advertise-address=192.168.5.200 --pod-network-cidr=172.16.0.0/16 >> /root/kubeinit.log 


echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.16/manifests/calico.yaml 

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 
