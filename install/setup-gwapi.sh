#!/bin/sh

pushd ..

# Deploy the Gateways

# create the ingress-gw namespace
kubectl create namespace ingress-gw --dry-run=client -o yaml | kubectl apply -f -

printf "\nDeploy the Gateway (K8S Gateway API)...\n"
kubectl apply -f gateways/gw.yaml


popd