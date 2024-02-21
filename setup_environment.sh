#!/bin/bash

python3 -m venv meltano_venv
python3 -m venv airflow_venv


source airflow_venv/bin/activate
pip install -r airflow_requirements.txt
deactivate

source meltano_venv/bin/activate
pip install -r meltano_requirements.txt
deactivate
