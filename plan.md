| Component                            | CPU Request | CPU Limit | Memory Request | Memory Limit | Notes                                                               |
| ------------------------------------ | ----------- | --------- | -------------- | ------------ | ------------------------------------------------------------------- |
| **Airflow Scheduler**                | 1 CPU       | 2 CPU     | 2 Gi           | 4 Gi         | Critical component that schedules tasks; should not be underpowered |
| **Airflow DAG Processor**            | 1 CPU       | 2 CPU     | 1 Gi           | 2 Gi         | Parses DAG files repeatedly; CPU-intensive when many DAGs           |
| **Airflow API Server (UI)**          | 300m        | 1 CPU     | 512 Mi         | 1 Gi         | UI + REST API; generally light workload                             |
| **Airflow Triggerer**                | 200m        | 500m      | 512 Mi         | 1 Gi         | Handles async triggers for deferrable tasks                         |
| **Airflow Celery Worker**            | 2 CPU       | 4 CPU     | 2 Gi           | 4 Gi         | Executes tasks; scale replicas instead of making single worker huge |
| **Redis (Celery Broker)**            | 200m        | 500m      | 256 Mi         | 512 Mi       | Lightweight; mostly network + memory                                |
| **PostgreSQL (Airflow Metadata DB)** | 2 CPU       | 4 CPU     | 2 Gi           | 4 Gi         | Handles scheduler writes and task state tracking                    |
