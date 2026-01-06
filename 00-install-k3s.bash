#/bin/bash

curl -sfL https://get.k3s.io | sh -s - --default-local-storage-path "/data" --disable traefik

# TODO : Copy k3s.yaml to home directory for kubectl usage
