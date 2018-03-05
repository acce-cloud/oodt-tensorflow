#!/bin/bash
# Script to create a Docker Swarm of VMs provisioned on the local host with VirtualBox

num_nodes=4

# create all VMs
for i in `seq 1 $num_nodes`;
do
  docker-machine create --driver virtualbox --virtualbox-memory 2048 node$i
done
docker-machine ls

# start the swarm
# first node is always the manager
eval $(docker-machine env node1)
export MANAGER_IP=`docker-machine ip node1`
docker swarm init --advertise-addr $MANAGER_IP
token_worker=`docker swarm join-token --quiet worker`
token_manager=`docker swarm join-token --quiet manager`

# make the other nodes join the swarm
for i in `seq 2 $num_nodes`;
do
   eval $(docker-machine env node$i)
   docker swarm join --token $token_worker $MANAGER_IP:2377
done
eval $(docker-machine env node1)
docker node ls
