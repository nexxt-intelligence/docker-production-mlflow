FROM condaforge/mambaforge:4.14.0-0

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[extras]==2.7.1

ENTRYPOINT ["mlflow", "server"]
