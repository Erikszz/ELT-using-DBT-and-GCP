FROM quay.io/astronomer/astro-runtime:12.7.0

USER root

# update apt-get and install dependencies globally
RUN apt-get update && \
    apt-get install -y wget unzip python3-venv && \
    apt-get clean

# install dependencies from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# dbt will work in virtual environment
RUN python3 -m venv dbt_venv && \
    source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-bigquery && deactivate
