FROM apache/airflow:2.3.1

USER root

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential

USER airflow

# Install airflow related files onto the host
COPY ./config/airflow.cfg /opt/airflow/airflow.cfg
COPY ./plugins /opt/airflow/plugins
COPY ./dags /data/airflow/dags

COPY ./requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt
