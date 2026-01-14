#!/bin/sh

pushd ../

kubectl apply -f upstreams/test-upstream.yaml

popd