# airflow-docker-boilerplate

Simple repo showing a boilerplate setup for running an Airflow stack using Docker Compose and an extended Airflow container.

**Tested with Apache Airflow 3.3.0**

## Running the stack

Create a local `.env` (Compose requires it), then build and start:

```bash
# Create .env from the example (set AIRFLOW_UID to your user id on Linux)
cp .env.example .env
# Optional on Linux:
# sed -i '' "s/AIRFLOW_UID=.*/AIRFLOW_UID=$(id -u)/" .env

# Build the local extended Airflow container using the local Dockerfile
docker compose build

# Run all of the containers used in the stack
docker compose up
```

Once running the stack can be accessed on [`localhost:8080`](http://localhost:8080).

Default login (FAB auth manager):

- Username: `airflow`
- Password: `airflow`

If you want to tear down the stack you can use the following command to perform a graceful shutdown.

```bash
# Take down the airflow stack gracefully
docker compose down
```

To also remove the Postgres volume (fresh metadata DB on next start):

```bash
docker compose down -v
```

## Development

DAG code can be found in the `./dags` folder. You can nest as many folders deep as you want. Any plugins you want to use in the DAG code can be added to the `./plugins` folder. This folder is mounted and added to Airflow's Python path so all of the modules located in the plugins folder are available for import in the DAGs.

For local code completion using a Python venv is recommended.

```bash
# Create a venv
python -m venv venv
# Add the venv to your path
source venv/bin/activate
# Install all of the python modules that are using in the Docker container
pip install -r requirements.txt
```

You should then configure your code editor to use this venv for sourcing modules for code completion.

## Airflow 3 notes

This stack follows the Airflow 3 Docker Compose layout:

- `airflow-apiserver` replaces the Airflow 2 webserver
- `airflow-dag-processor` runs as a standalone service
- Example DAGs/operators use `airflow.sdk` and `airflow.providers.standard`

## Contact

If you have any questions or comments about this feel free to reach out through an issue on the repo or the contact options below.

- [Twitter](https://twitter.com/Aaron_KT_Berry)

- [Linkedin](https://www.linkedin.com/in/aaron-kt-berry/)
