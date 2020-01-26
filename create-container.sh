#! /usr/bin/env bash
# https://neo4j.com/developer/docker-run-neo4j/
docker volume create --name as-neo4j-data
docker volume create --name as-neo4j-logs
docker run \
    --name as-neo4j \
    -p7474:7474 -p7687:7687 \
    -d \
    -v as-neo4j-data:/var/lib/neo4j/data \
    -v as-neo4j-logs:/var/lib/neo4j/logs \
    --env NEO4J_AUTH=neo4j/password \
    neo4j:3.5.5
