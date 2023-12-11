FROM condaforge/mambaforge:4.14.0-0

# Install gcc
RUN apt-get update && \
    apt-get install -y gcc

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[extras]==2.9.1

EXPOSE 80

ARG SERVICE_PORT
ENV SERVICE_PORT=$SERVICE_PORT

ARG HOSTNAME
ENV HOSTNAME=$HOSTNAME

ARG ARTIFACTS_DESTINATION
ENV ARTIFACTS_DESTINATION=$ARTIFACTS_DESTINATION

ARG DB_USERNAME
ENV DB_USERNAME=$DB_USERNAME

ARG DB_HOST
ENV DB_HOST=$DB_HOST

ARG DB_PORT
ENV DB_PORT=$DB_PORT

ARG DB_NAME
ENV DB_NAME=$DB_NAME

ARG DB_PASSWORD
ENV DB_PASSWORD=$DB_PASSWORD

ENV MLFLOW_DEPLOYMENTS_TARGET="http://127.0.0.1:7000"

CMD ["mlflow", "server", "--host", "$HOSTNAME", "--port", "$SERVICE_PORT"]
# , "--backend-store-uri", "mysql+pymysql://$DB_USERNAME:`echo -n $DB_PASSWORD`@$DB_HOST:$DB_PORT/$DB_NAME", "--default-artifact-root", "$ARTIFACTS_DESTINATION"]