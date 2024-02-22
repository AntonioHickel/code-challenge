#!/bin/bash

python3.10 -m venv meltano_venv
python3.11 -m venv airflow_venv

source airflow_venv/bin/activate
pip install -r airflow_requirements.txt
pip install kubernetes
deactivate

source meltano_venv/bin/activate
pip install -r meltano_requirements.txt
cd projects/step_one
meltano add extractor tap-postgres
meltano add extractor tap-csv
meltano add loader target-csv
cd ../step_two
meltano add extractor tap-csv
meltano add loader target-postgres
cd ../../
deactivate
