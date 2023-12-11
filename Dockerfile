FROM condaforge/mambaforge:4.14.0-0

# Install gcc
RUN apt-get update && \
    apt-get install -y gcc

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[extras]==2.9.1 && \
    pip install mlflow[genai]==2.9.1

COPY ./mlflow_ai_gateway_config.yaml /mlflow_ai_gateway_config.yaml
RUN chmod +x /mlflow_ai_gateway_config.yaml

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV SERVICE_PORT=$SERVICE_PORT \
    HOSTNAME=$HOSTNAME \
    ARTIFACTS_DESTINATION=$ARTIFACTS_DESTINATION \
    DB_USERNAME=$DB_USERNAME \
    DB_HOST=$DB_HOST \
    DB_PORT=$DB_PORT \
    DB_NAME=$DB_NAME \
    DB_PASSWORD=$DB_PASSWORD \
    OPENAI_API_KEY=$OPENAI_API_KEY \
    MLFLOW_DEPLOYMENTS_TARGET="http://127.0.0.1:7000"

EXPOSE 80
EXPOSE 7000

CMD ["./entrypoint.sh"]