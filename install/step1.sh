#!/bin/sh

pushd ../

kubectl apply -f apis/nginx.yaml
kubectl apply -f upstreams/working-upstream.yaml
kubectl apply -f virtualservices/working-vs.yaml

popd