#!/bin/bash

export $(xargs <.env)

cd 01-bootstrap

kubectl apply -f argocd-app.yaml
kubectl apply -f argocd-ing.yaml

kubectl apply -f argocd-bootstrap-data-plane.yaml

YAML_FILE="argocd-local-repo.yaml"
cp ${YAML_FILE} ${YAML_FILE}.tmp
sed -i "s|<<GITEA_USERNAME>>|${GIT_USER}|g" ${YAML_FILE}.tmp
sed -i "s|<<GITEA_PASSWORD>>|${GIT_PASSWORD}|g" ${YAML_FILE}.tmp
kubectl apply -f ${YAML_FILE}.tmp

cd ..
