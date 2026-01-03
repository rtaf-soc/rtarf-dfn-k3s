#!/bin/bash

export $(xargs <.env)

DST_DIR=addons

# ต้องเพิ่ม volume map ตรง k3s volume ด้วย
SRC_FILE=00-configs/addons-argocd.yaml
echo "Copying file [${SRC_FILE}] to directory [${DST_DIR}]"
cp ${SRC_FILE} ${DST_DIR}

SRC_FILE=00-configs/addons-ingress.yaml
echo "Copying file [${SRC_FILE}] to directory [${DST_DIR}]"
cp ${SRC_FILE} ${DST_DIR}

SRC_FILE=00-configs/addons-external-secret.yaml
echo "Copying file [${SRC_FILE}] to directory [${DST_DIR}]"
cp ${SRC_FILE} ${DST_DIR}

SRC_FILE=00-configs/addons-cert-manager.yaml
echo "Copying file [${SRC_FILE}] to directory [${DST_DIR}]"
cp ${SRC_FILE} ${DST_DIR}

################ Gitea here ################
SRC_FILE=00-configs/addons-gitea.yaml

# Replace credential variables in the file
echo "Replacing credentials in [${SRC_FILE}]"
sed -i "s/<<GIT_USER>>/${GIT_USER}/g" ${SRC_FILE}
sed -i "s/<<GIT_PASSWORD>>/${GIT_PASSWORD}/g" ${SRC_FILE}
sed -i "s/<<GIT_EMAIL>>/${GIT_EMAIL}/g" ${SRC_FILE}

echo "Copying file [${SRC_FILE}] to directory [${DST_DIR}]"
cp ${SRC_FILE} ${DST_DIR}
