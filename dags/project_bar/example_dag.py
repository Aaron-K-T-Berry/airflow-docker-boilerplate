from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator

from operators.hello_operator import HelloOperator

import datetime
import pendulum

with DAG(
    dag_id='project_bar_example_dag',
    schedule_interval='0 0 * * *',
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=60),
    tags=[
        'project-bar',
        'owner-bar'
    ],
    params={
        "example_key": "example_value",
    },
) as dag:
    run_this_last = EmptyOperator(
        task_id='run_this_last',
    )

    run_this = BashOperator(
        task_id='run_after_loop',
        bash_command='echo 1',
    )

    hello_task = HelloOperator(task_id="sample-task", name="foo_bar")

    run_this >> hello_task >> run_this_last

    for i in range(3):
        task = BashOperator(
            task_id='runme_' + str(i),
            bash_command='echo "{{ task_instance_key_str }}" && sleep 1',
        )

        task >> run_this

    also_run_this = BashOperator(
        task_id='also_run_this',
        bash_command='echo "run_id={{ run_id }} | dag_run={{ dag_run }}"',
    )

    also_run_this >> run_this_last

this_will_skip = BashOperator(
    task_id='this_will_skip',
    bash_command='echo "hello world"; exit 99;',
    dag=dag,
)

this_will_skip >> run_this_last

if __name__ == "__main__":
    dag.cli()
