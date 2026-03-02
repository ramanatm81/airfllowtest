FROM apache/airflow:3.1.7-python3.11

USER root

# Optional system deps (for quant libs, pandas, numpy, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && apt-get clean

USER airflow

# Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# Copy DAGs into image
COPY dags/ /opt/airflow/dags/

# Copy shared libs (pricing clients, utils, etc.)
COPY common_libs/ /opt/airflow/common_libs/

ENV PYTHONPATH="/opt/airflow/common_libs:${PYTHONPATH}"