#!/bin/bash

mkdir -p addons

sudo mkdir -p /data

SRC_FILE=.env
DST_FILE=addons/initial-secrets.yaml
SECRET=initial-secret
TMP_FILE=/tmp/${SECRET}.tmp

cat <<END > "${TMP_FILE}"
apiVersion: v1
kind: Secret
metadata:
  name: ${SECRET}
type: Opaque
data:
END

cat ${SRC_FILE} | while read line
do
  regex="^(.+?)=(.+)$"
  if [[ $line =~ $regex ]]; then

    KEY=$(echo -e "$line" | perl -0777 -ne 'print $1 if /^(.+?)=(.+)$/')
    VALUE=$(echo -e "$line" | perl -0777 -ne 'print $2 if /^(.+?)=(.+)$/')

    echo "  ${KEY}: $(echo -n "${VALUE}" | base64 -w0)" >> ${TMP_FILE}
  fi
done

export $(xargs <.env)

cp ${TMP_FILE} ${DST_FILE}

kubectl apply -f ${DST_FILE}

### GIT ###
GIT_NS=gitea

kubectl create namespace ${GIT_NS} --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic gitea-admin-secret \
  -n ${GIT_NS} \
  --from-literal=username=${GIT_USER} \
  --from-literal=password=${GIT_PASSWORD} \
  --from-literal=email=admin@example.com \
  --dry-run=client -o yaml | kubectl apply -f -

#kubectl create secret generic gcs-credentials --from-file=gcs.client.default.credentials_file=$HOME/secrets/es-snapshot-gcs.json -n elasticsearch