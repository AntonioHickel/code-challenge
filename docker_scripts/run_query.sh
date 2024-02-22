#!/bin/bash

cd ../

touch query_result.json

source airflow_venv/bin/activate

python3 ./query.py