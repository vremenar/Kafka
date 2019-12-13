#!/bin/bash

# Set Kafka tools path
KAFKA_FOLDER="/opt/kafka/kafka_2.12-2.3.0/"

# Set variables for output coloring
GREEN='\033[0;32m'
DEF='\033[0m'

# Default env to test and topic to all
ENVIRONMENT='cluster1'
TOPIC=''

# Get arguments
for i in "$@"
do
case $i in
    -e=*|--environment=*)
    ENVIRONMENT="${i#*=}"
    shift
    ;;
    -t=*|--topic=*)
    TOPIC="${i#*=}"
    shift
    ;;
    *)
    # Not parsed arguments
    ;;
esac
done

# Check if environment exists
if [ -f "/opt/kafka/config/$ENVIRONMENT/servers.list" ]; then
    # Set env
    export KAFKA_OPTS="-Djava.security.auth.login.config=/opt/kafka/config/$ENVIRONMENT/kafka_jaas.conf"
    source /opt/kafka/config/$ENVIRONMENT/servers.list
    BOOTSTRAP_SERVERS=$BROKERS
    PROPERTIES_CONFIG="/opt/kafka/config/$ENVIRONMENT/consumer.properties"

    echo -e "Running on environment: ${ENVIRONMENT} (${BOOTSTRAP_SERVERS})"

    if [ $TOPIC = "" ]
    then
        echo -e "Topic name must be specified"
    else
        $KAFKA_FOLDER/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVERS --command-config $PROPERTIES_CONFIG --create --topic $TOPIC --partitions 2 --replication-factor 3 --config min.insync.replicas=2 --config segment.bytes=1073741824 --config segment.ms=86400000 --config retention.ms=2678400000 --config retention.bytes=1073741824
    fi
else
    echo "Environment $ENVIRONMENT does not exist"
fi