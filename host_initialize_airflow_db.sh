#!/bin/bash

COMMAND_TO_RUN="cd docker_scripts && ./initialize_airflow_db.sh"

sudo docker exec -it code-challenge-pipeline-service-1 bash -c "$COMMAND_TO_RUN"
