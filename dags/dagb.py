from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.sensors.external_task import ExternalTaskSensor
from datetime import datetime

def job_B():
    print("Running Job B")

with DAG(
    dag_id="dag_B",
    start_date=datetime(2024, 1, 1),
    schedule="30 9 * * *",  # 09:30
    catchup=False,
) as dag:

    wait_for_A = ExternalTaskSensor(
        task_id="wait_for_A",
        external_dag_id="dag_A",
        external_task_id=None,        # wait for entire DAG A
        allowed_states=["success"],
        failed_states=["failed", "skipped"],
        mode="reschedule",
        timeout=60*60
    )

    run_B = PythonOperator(
        task_id="run_B",
        python_callable=job_B
    )

    wait_for_A >> run_B