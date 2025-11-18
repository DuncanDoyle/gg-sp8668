# Gloo Gateway - SP 8668 Reproducer

https://github.com/solo-io/solo-projects/issues/8668

## Installation

Add Gloo Gateway Helm repo:
```
helm repo add glooe https://storage.googleapis.com/gloo-ee-helm
```

Export your Gloo Gateway License Key to an environment variable:
```
export GLOO_GATEWAY_LICENSE_KEY={your license key}
```

Install Gloo Gateway:
```
cd install
./install-gloo-gateway-with-helm.sh
```

> NOTE
> The Gloo Gateway version that will be installed is set in a variable at the top of the `install/install-gloo-gateway-with-helm.sh` installation script.

## Setup the environment

Run the `install/setup.sh` script to setup the environment:

- Create the required namespaces
- Deploy the Gateway (Gloo Egde API)

```
./setup.sh
```

## Reproducer

First, in step 1, we deploy the NGINX application, Upstream and VirtualService:

```
./step1.sh
```

The NGINX application is now accessible on http://api.example.com

```
curl -v http://api.example.com
```

... which should give you a valid response.

Next we'll deploy an Upstream that points to a non-existing service. The Upstream will have a "warning" status:

```
./step2.sh
```

The NGINX application is still accessible: 

```
curl -v http://api.example.com
```

Next we deploy the missing Service that should fix the Upstream:

```
./step3.sh
```

And if we now rollout the NGINX deployment, 

```
kubectl -n gloo-system rollout restart deploy/nginx-deployment
```

... which basically spins up new pods with new ip-addresses ... and these ip-addresses will not be updated in Envoy (i.e. their `dynamic_endpoint_configs` are note updated), making the NGINX application unaccessible:

```
curl -v http://api.example.com
```

To fix this, just removing the Service and Upstream does not work. What seems to be necessary is to a (correct) update to an Upstream.
So what we can do is remove the Service and Upstream:

```
./reset-test.sh
```

And re-apply step2 and step3 in reversed order;

```
./step3.sh
./step2.sh
```

The endpoint updates should now be propagated to Envoy again, and NGINX should be accessible again:

```
curl -v http://api.example.com
```