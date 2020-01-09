#!/bin/bash
DATA_DIR=/opt/data/kafka
docker run -d --restart unless-stopped --network host \
         -e ALLOW_PLAINTEXT_LISTENER=no \
         -e KAFKA_CERTIFICATE_PASSWORD=storepassword \
         -e KAFKA_INTER_BROKER_USER=admin \
         -e KAFKA_ZOOKEEPER_USER=user \
         -e KAFKA_ZOOKEEPER_PASSWORD=password \
         -e KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE=false \
         -e KAFKA_CFG_ADVERTISED_LISTENERS=SASL_SSL://:9092 \
         -e KAFKA_CFG_DELETE_TOPIC_ENABLE=true \
         -e KAFKA_CFG_DEFAULT_REPLICATION_FACTOR=1 \
         -e KAFKA_CFG_INTER_BROKER_PROTOCOL_VERSION=2.2.2 \
         -e KAFKA_CFG_LISTENERS=SASL_SSL://:9092 \
         -e KAFKA_CFG_ZOOKEEPER_CONNECT=kafka.lab.local:2181 \
         -e JMX_PORT=9696 \
         -p 9092:9092 \
         -p 9696:9696 \
         -v $DATA_DIR:/bitnami/kafka \
         -v '/opt/certificates/keystore/kafka.keystore.jks:/opt/bitnami/kafka/conf/certs/kafka.keystore.jks:ro' \
         -v '/opt/certificates/truststore/kafka.truststore.jks:/opt/bitnami/kafka/conf/certs/kafka.truststore.jks:ro' \
         --name kafka_`date +%d.%m.%Y'` \
         bitnami/kafka:2.4.0-debian-9-r16