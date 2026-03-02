FROM apache/airflow:3.1.7-python3.11

USER root

# optional system deps
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && apt-get clean

USER airflow

# install your python deps
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# copy DAGs into Airflow folder
COPY dags/ /opt/airflow/dags/

# optional shared libraries
COPY common_libs/ /opt/airflow/common_libs/

ENV PYTHONPATH="/opt/airflow/common_libs:${PYTHONPATH}"