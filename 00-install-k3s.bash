#/bin/bash

curl -sfL https://get.k3s.io | sh -s - --default-local-storage-path "/data" --disable traefik

# TODO : Copy k3s.yaml to home directory for kubectl usage
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/k3s.yaml
sudo chown $(id -u):$(id -g) $HOME/k3s.yaml

