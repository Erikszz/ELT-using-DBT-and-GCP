from datetime import datetime
from pathlib import Path
from cosmos import DbtDag, ExecutionConfig, ExecutionMode, ProfileConfig, ProjectConfig, RenderConfig, TestBehavior
from cosmos.profiles import GoogleCloudServiceAccountFileProfileMapping
import os

DBT_CONFIG = ProfileConfig(
            profile_name='online_retail',   # same name like profiles' name
            target_name='dev',  # in profiles file
            profile_mapping=GoogleCloudServiceAccountFileProfileMapping(
            conn_id='gcp',  # created connection in apache airflow
            profile_args={
                'project': os.getenv('PROJECT_ID'),
                'dataset': 'retail'
            }
    ),
)
    
DBT_PROJECT_CONFIG = ProjectConfig(
        dbt_project_path=Path('/usr/local/airflow/dbt/online_retail')   # path to dbt project
)

cosmos_dbt_dag = DbtDag(
    project_config=DBT_PROJECT_CONFIG,
    profile_config=DBT_CONFIG,
    operator_args={
        "install_deps": True,  # install any necessary dependencies before running any dbt command
        "full_refresh": True,  # used only in dbt commands that support this flag
    },
    execution_config=ExecutionConfig(
        dbt_executable_path='/usr/local/airflow/dbt_venv/bin/dbt'   # path to dbt through venv
    ),
    # normal dag parameters
    schedule_interval=None,
    start_date=datetime(2023, 1, 1),
    catchup=False,
    dag_id="bigquery_transformation",
    default_args={"retries": 1},
)

