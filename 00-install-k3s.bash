#/bin/bash

curl -sfL https://get.k3s.io | sh -s - --disable local-storage --disable traefik
