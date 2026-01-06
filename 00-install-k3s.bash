#/bin/bash

sudo mkdir -p /etc/rancher/k3s/server/manifests

# 2. สร้างไฟล์กำหนดค่า Storage Path
sudo tee /etc/rancher/k3s/server/manifests/local-path-config.yaml > /dev/null <<EOF
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: local-path-provisioner
  namespace: kube-system
spec:
  valuesContent: |-
    configData:
      paths:
        - /data
EOF

curl -sfL https://get.k3s.io | sh -s - --disable traefik

# TODO : Copy k3s.yaml to home directory for kubectl usage
