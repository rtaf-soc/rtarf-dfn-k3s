#!/bin/bash

export $(xargs <.env)

cd 01-bootstrap

kubectl apply -f argocd-app.yaml
kubectl apply -f argocd-ing.yaml

YAML_FILE="argocd-local-repo.yaml"
sed -i "s|<<GITEA_USERNAME>>|${GIT_USER}|g" ${YAML_FILE}
sed -i "s|<<GITEA_PASSWORD>>|${GIT_PASSWORD}|g" ${YAML_FILE}
kubectl apply -f ${YAML_FILE}

cd ..
