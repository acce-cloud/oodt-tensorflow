#!/bin/bash
# Script to clean up a Docker Swarm composed of 4 VMs provisioned on the local host with VirtualBox

# remove the stack
docker stack rm oodt-stack

# make the worker nodes leave the swarm
for i in `seq 2 4`;
do
   eval $(docker-machine env node$i)
   docker swarm leave
done

# destroy the master node
docker-machine env node1
docker swarm leave --force

# destroy the nodes
docker-machine rm -f node1 node2 node3 node4
