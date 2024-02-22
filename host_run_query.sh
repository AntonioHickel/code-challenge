#!/bin/bash

COMMAND_TO_RUN="cd docker_scripts && ./run_query.sh"

sudo docker exec -it code-challenge-pipeline-service-1 bash -c "$COMMAND_TO_RUN"

CONTAINER_FILE_PATH="code-challenge-pipeline-service-1:/app/query_result.json"

HOST_FILE_PATH="$(pwd)/query_result.json"

sudo docker cp "$CONTAINER_FILE_PATH" "$HOST_FILE_PATH"

echo "File copied to: $HOST_FILE_PATH"