#!/bin/bash

ARGS="$*"

COMMAND_TO_RUN="cd docker_scripts && ./run_pipeline.sh $ARGS"

sudo docker exec -it code-challenge-pipeline-service-1 bash -c "$COMMAND_TO_RUN"
