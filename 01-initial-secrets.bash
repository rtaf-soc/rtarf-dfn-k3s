#!/bin/bash

SRC_FILE=00-configs/initial-secret.yaml
kubectl apply -f ${SRC_FILE}

# รอให้ Job สร้าง Secret เสร็จ
sleep 10

### GIT ###
GIT_NS=gitea

# สร้าง secret ใน namespace gitea โดยนำค่ามาจาก initial-secret จาก default namespace
kubectl create namespace ${GIT_NS} --dry-run=client -o yaml | kubectl apply -f -

GIT_USER=$(kubectl get secret initial-secret -n default -o jsonpath='{.data.GIT_USER}' | base64 -d)
GIT_PASSWORD=$(kubectl get secret initial-secret -n default -o jsonpath='{.data.GIT_PASSWORD}' | base64 -d)

kubectl create secret generic gitea-admin-secret \
  -n ${GIT_NS} \
  --from-literal=username=${GIT_USER} \
  --from-literal=password=${GIT_PASSWORD} \
  --from-literal=email=admin@example.com \
  --dry-run=client -o yaml | kubectl apply -f -
