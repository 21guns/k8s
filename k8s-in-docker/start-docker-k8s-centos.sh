#!/bin/bash

docker run --privileged -v  /var/lib/docker --name k8s-master -h k8s-master -d 21guns.com/centos7-system
docker run --privileged -v  /var/lib/docker --name k8s-node1 -h k8s-node1 -d 21guns.com/centos7-system
docker run --privileged -v  /var/lib/docker --name k8s-node2 -h k8s-node2 -d 21guns.com/centos7-system
