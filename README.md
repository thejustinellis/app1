# app1
This is a basic ruby application that pulls time series data from Alphavantage over a period of days, returns the closing costs and average closing price.

# Things left to do
- [] add rspec tests
- [] split out ruby environments to allow for customization between them
- [x] add autobuild to dockerhub to build latest tag on merge into 'main' branch 

# Pre-Requisites
- a functional installation of Ruby (this was built and tested with 2.6)
- docker (only necessary for building your own version)
- bundler (a ruby gem)

# Usage
## Building the Docker Image
The Dockerfile is held here: [Dockerfile](contrib/docker/Dockerfile).  To build your own version of this, the following command can be run from the root of the repository. Existing images can be found [here](https://hub.docker.com/repository/docker/thejustinellis/demoapp-fr).  Autobuild uses the latest tag (not ideal for versioning, but it will work for this scenario):
* ```docker build -t $REPO:$TAG . -f contrib/docker/Dockerfile```
* ```docker push $REPO:$TAG```

## Running the application locally
These instructions assume you have a functional version of ruby installed.  The following commands will run the application locally in development mode.  
* ```gem install bundler```
* ```bundle install```
* ```bundle exec puma```

## Deploying the application 
Included in this repository are kubernetes resource definitions for deploying this application to a kube cluster.  To deploy this to a kube cluster, run the following command.
```kubernetes create -f contrib/k8s/```
There are variables set by default in the deployment, they're all set via a configmap located here [configmap](contrib/k8s/configmap.yaml).  Here's a brief description of what each variable does:
* NDAYS (number of days to pull data for)
* TICKER (stock ticker to pull data for)
* ALPHAVANTAGE_URL (url to consume for data)

## Verifying the application
The above deployment creates the deployment, configmap, secret, and ingress resources needed for this application to run.  To verify it is working as intended, you can make a request to the ingress resource and expect a response similar to:
```curl http://$INGRESS_IP```
```{"2021-04-14":"255.5900","2021-04-13":"258.4900","2021-04-12":"255.9100","2021-04-09":"255.8500","average":256.46}```
