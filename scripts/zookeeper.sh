#!/bin/bash
DATA_DIR=/opt/data/zookeeper
docker run -d --restart unless-stopped --network host \
         -e ZOO_SERVER_ID=1 \
         -e ZOO_SERVERS=0.0.0.0:2888:3888 \
         -e ZOO_ENABLE_AUTH=yes \
         -e ZOO_SERVER_USERS=user \
         -e ZOO_SERVER_PASSWORDS=password\
         -p 2181:2181 \
         -p 2888:2888 \
         -p 3888:3888 \
         -v $DATA_DIR:/bitnami/zookeeper \
         --name zookeeper_`date '+%d.%m.%Y'` \
         bitnami/zookeeper:3.5.6-debian-9-r59