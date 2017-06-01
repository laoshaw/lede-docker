#!/bin/bash
set -e
set -x

REPO="lede-17.01.1-x86-64"
TAG="170101"
HUBUSER="laoshaw"

docker import https://downloads.lede-project.org/releases/17.01.1/targets/x86/64/$REPO-generic-rootfs.tar.gz $REPO:$TAG
CTID=$(docker run -d -it $REPO:$TAG sh)
docker exec $CTID mkdir -pv /var/run
docker exec $CTID mkdir -pv /var/lock
docker exec $CTID opkg update
docker commit $CTID $HUBUSER/$REPO:$TAG
docker push $HUBUSER/$REPO:$TAG
