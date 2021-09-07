#!/bin/bash

# This is to demo

node_app=`docker ps -a | grep nodejs-with-docker-k8s | awk '{print $NF}'`
if [ $node_app=='nodejs-with-docker-k8s' ]; then
    echo "nodejs-with-docker-k8s is running, lets delete"
        docker rm -f nodejs-with-docker-k8s
fi

images=`docker images | grep kammana/nodejenkins | awk '{print $3}'`
docker rmi $images
docker run -d -p 8080:8080 --name nodejs-with-docker-k8s $1