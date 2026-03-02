from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def job_A():
    print("Running Job A")

with DAG(
    dag_id="dag_A",
    start_date=datetime(2024, 1, 1),
    schedule="0 9 * * *",   # 09:00
    catchup=False,
    tags=["pipeline"]
) as dag:

    run_A = PythonOperator(
        task_id="run_A",
        python_callable=job_A
    )