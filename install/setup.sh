#!/bin/sh

pushd ..

# Deploy the Gateways

# Gloo Edge API
kubectl apply -f gateways/gateway-proxy.yaml

popd