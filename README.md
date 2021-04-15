# app1
This is a basic ruby application that pulls time series data from Alphavantage over a period of days, returns the closing costs and average closing price.

# Pre-Requisites
- a functional installation of Ruby (this was built and tested with 2.6)
- docker (only necessary for building your own version)
- bundler (a ruby gem)

# Usage
## Building the Docker Image
The Dockerfile is held here: [a relative link](contrib/docker/Dockerfile).  To build your own version of this, the following command can be run from the root of the repository. :
```docker build -t $REPO:$TAG . -f contrib/docker/Dockerfile```

## Deploying the application 
Included in this repository are kubernetes resource definitions for deploying this application to a kube cluster.  To deploy this to a kube cluster, run the following command.
```kubernetes create -k contrib/k8s/```

## Verifying the application
The above deployment creates the deployment, configmap, secret, and ingress resources needed for this application to run.  To verify it is working as intended, you can make a request to the ingress resource and expect a response similar to:
```curl http://$INGRESS_IP
{"2021-04-14":"255.5900","2021-04-13":"258.4900","2021-04-12":"255.9100","2021-04-09":"255.8500","average":256.46}```
