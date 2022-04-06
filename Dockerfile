FROM apache/airflow:2.2.5

USER root

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential

USER airflow

# Install airflow related files onto the host
COPY ./src/config/airflow.cfg /opt/airflow/airflow.cfg
COPY ./src/plugins /opt/airflow/plugins
COPY ./src/dags /data/airflow/dags

COPY ./requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt
