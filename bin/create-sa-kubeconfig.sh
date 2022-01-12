#!/usr/bin/env bash

# set -x

if [ -z "$1" ] ; then
    echo "Usage: $0 CLUSTER_NAME"
    exit 1
fi;

CLUSTER_NAME=$1

oc create sa -n default rbohne-admin
oc adm policy add-cluster-role-to-user cluster-admin -n default -z rbohne-admin

oc apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: rbohne-admin
  namespace: default
  annotations:
    kubernetes.io/service-account.name: rbohne-admin
type: kubernetes.io/service-account-token
EOF


TEMP=$( mktemp -d )
mkdir -p $TEMP

TOKEN=$( oc get  secrets rbohne-admin -o jsonpath="{.data.token}" | base64 --decode )

oc get  secrets rbohne-admin -o jsonpath="{.data.ca\.crt}" | base64 --decode > ${TEMP}/ca.crt

SERVER=$( oc whoami --show-server )

export KUBECONFIG=~/.kube/clusters/${CLUSTER_NAME}

oc config set-cluster $CLUSTER_NAME \
  --server=$SERVER \
  --certificate-authority=${TEMP}/ca.crt \
  --embed-certs=true

oc config set-credentials sa \
  --token=$TOKEN

oc config set-context $CLUSTER_NAME \
  --cluster=$CLUSTER_NAME \
  --user=sa \
  --namespace=default

oc config use-context $CLUSTER_NAME


rm ${TEMP}/*
rmdir ${TEMP}


