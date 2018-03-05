#!/bin/bash
# Script to clean up a Docker Swarm composed of 4 VMs provisioned on the local host with VirtualBox

# nuber of nodes
num_nodes=4

# remove the stack
docker stack rm oodt-stack

# make the worker nodes leave the swarm
for i in `seq 2 $num_nodes`;
do
   eval $(docker-machine env node$i)
   docker swarm leave
   docker-machine rm -f node$i
done

# destroy the manager node
docker-machine env node1
docker swarm leave --force
docker-machine rm -f node1
