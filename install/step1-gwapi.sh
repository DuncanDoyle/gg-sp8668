#!/bin/sh

pushd ../

kubectl apply -f apis/nginx.yaml
kubectl apply -f upstreams/working-upstream.yaml
kubectl apply -f referencegrants/gloo-system-ns/httproute-default-upstream-rg.yaml
kubectl apply -f routes/working-httproute.yaml

popd