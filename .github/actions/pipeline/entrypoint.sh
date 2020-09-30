#!/bin/bash

apt-get update

apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io

docker build . --tag $DOCKER_USER/yad2_${GITHUB_REF#refs/heads/}:${GITHUB_SHA::8}


echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

docker push $DOCKER_USER/yad2_${GITHUB_REF#refs/heads/}:${GITHUB_SHA::8}
