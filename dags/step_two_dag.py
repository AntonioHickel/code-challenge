from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

import os
from datetime import datetime, timedelta

YEAR = int(os.getenv('YEAR2'))
MONTH = int(os.getenv('MONTH2'))
DAY = int(os.getenv('DAY2'))

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(YEAR, MONTH, DAY),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(days=1),
}

dag = DAG(
    'fetch_path_step2',
    default_args=default_args,
    description='A simple Meltano ELT DAG',
    schedule=timedelta(days=1),
    catchup= False,
    is_paused_upon_creation=True,
)

elt_task = BashOperator(
    task_id='fetch_path_step2',
    bash_command='cd $PIPELINE_HOME && source meltano_venv/bin/activate && cd $PIPELINE_HOME/projects/step_two && ./fetch_path_step2.sh ',
    dag=dag,
)
