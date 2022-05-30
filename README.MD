# airflow-docker-boilerplate

Simple repo showing a boilerplate setup for running an airflow stack using docker compose and an extended airflow container.

## Running the stack

You can run the stack by using the following docker-compose commands.

```bash
# Build the local extended Airflow container using the local Dockerfile
docker-compose build

# Run all of the containers used in the stack
docker-compose up
```

Onc running the stack can be access on [`localhost:8080`](localhost:8080).

If you want to tear down the stack you can use the following command to perform a graceful shutdown.

```bash
# Take down the airflow stack gracefully
docker-compose down
```

## Development

DAG code can be found in the `./dags` folder. You can nest as many folders deep as you want. Any plugins you want to use in the DAG code can be added to the `./plugins` folder. This folder is mounted and added to airflows python path so all of the modules located in the plugins folder are available for import in the dags.

For local code completion using a python venv is recommended.

```bash
# Create a venv
python -m venv venv
# Add the venv to your path
source venv/bin/activate
# Install all of the python modules that are using in the Docker container
pip install -r requirements.txt
```

You should then configure your code editor to use this venv for sourcing modules for code completion.

## Contact

If you have any questions or comments about this feel free to reach out throw an issue on the repo or the contact options below.

- [Twitter](https://twitter.com/Aaron_KT_Berry)

- [Linkedin](https://www.linkedin.com/in/aaron-kt-berry/)
