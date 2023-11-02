FROM condaforge/mambaforge:4.14.0-0

# Install gcc
RUN apt-get update && \
    apt-get install -y gcc

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[extras]==2.8.0

ENTRYPOINT ["mlflow", "server"]
