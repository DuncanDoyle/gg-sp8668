#!/bin/sh

pushd ../

kubectl apply -f apis/test-service-nginx.yaml

popd