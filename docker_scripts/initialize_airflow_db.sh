cd ../

source airflow_venv/bin/activate

airflow db init

rm /root/airflow/airflow.cfg
cp ./airflow.cfg /root/airflow/airflow.cfg

airflow db init
airflow users create --username admin --firstname admin --lastname admin --role Admin --email admin --password admin

deactivate
