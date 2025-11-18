#!/bin/sh

kubectl -n gloo-system delete upstream test
kubectl -n gloo-system delete service test