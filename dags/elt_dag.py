import os
import pandas as pd
from airflow.decorators import dag, task
from datetime import datetime
from google.auth.credentials import Credentials
from airflow.providers.google.cloud.hooks.bigquery import BigQueryHook
from pathlib import Path
from airflow.operators.trigger_dagrun import TriggerDagRunOperator


def download_file(url: str, filename: str):
    """Download file from web source and save as ZIP."""
    
    print(f'Downloading {filename} ...')
    os.system(f'wget -q -L {url} -O {filename}.zip')
    print(f'Zip file downloaded successfully.')
        
        
def unzip_file(filename: str):
    """Unzip downloaded file."""
    
    print(f'Unzipping {filename}.zip ...')
    os.system(f'unzip -o {filename}.zip')
    print(f'Zip file extracted successfully.')
    
    
def read_csv(url: str, filename: str, csv_name: str) -> pd.DataFrame:
    """Read CSV to be Pandas DataFrame."""
    
    try:
        download_file(url, filename)
        unzip_file(filename)

        csv_file = f'{csv_name}.csv'
        print(f'Reading {csv_file} ...')
        df = pd.read_csv(csv_file)
        return df
    except Exception as e:
        print(f'Error occurred: {e}')


def load_to_gbq(df: pd.DataFrame, project_id: str, credentials: Credentials):
    """Load data to BigQuery using to_gbq."""
    
    print('Loading data to BigQuery ...')
    df.to_gbq(
        destination_table='retail.raw',
        project_id=project_id,
        if_exists='replace',
        credentials=credentials
    )
    print('Data loaded successfully to BigQuery.')

# define DAG
@dag(
        start_date=datetime(2025, 1, 1),
        schedule_interval=None,
        catchup=False,
        tags=['retail_2']
)

def retail_dag():

    # task for extract file from web source and read csv file
    @task
    def extract():
        file_url = os.getenv('FILE_URL')
        df = read_csv(file_url, 'ecommerce', 'Dataset')
        return df

    # task for load data to gbq
    @task
    def load(df):
        # get credentials using hook
        hook = BigQueryHook(gcp_conn_id='gcp') # put the name of created connection
        credentials = hook.get_credentials()
        project_id = os.getenv('PROJECT_ID')
        load_to_gbq(df, project_id, credentials)

    
    trigger = TriggerDagRunOperator(
            task_id="trigger_dbt",
            trigger_dag_id="bigquery_transformation",   # dag id of dbt 
            wait_for_completion=True
    )

    # define the task
    extract_task = extract()
    load_task = load(extract_task)
    
    # set task depedencies
    extract_task >> load_task >> trigger

# id of DAG
retail_dag = retail_dag()
