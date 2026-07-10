FROM apache/airflow:3.3.0

USER root

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

USER airflow

# Install project dependencies into the image
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Bake DAGs/plugins into the image for non-compose usage; compose mounts override these.
COPY ./plugins /opt/airflow/plugins
COPY ./dags /data/airflow/dags
COPY ./config /opt/airflow/config
