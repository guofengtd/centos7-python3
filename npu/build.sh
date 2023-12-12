#!/bin/sh

docker build -t npu:latest .

docker tag npu:latest guofengjd/npu-$(uname -m):latest && docker push guofengjd/npu-$(uname -m):latest

docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
