#!/bin/sh

docker build -t centos7-python3.9.6:latest .

docker tag centos7-python3.9.6:latest guofengjd/centos7-python3.9.6:latest && docker push guofengjd/centos7-python3.9.6:latest

docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

