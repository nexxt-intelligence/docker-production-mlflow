FROM condaforge/mambaforge:4.14.0-0

# Install gcc
RUN apt-get update && \
    apt-get install -y gcc

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[extras]==2.8.1 && \
    pip install mlflow[gateway]==2.8.1

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./mlflow_ai_gateway_config.yaml /mlflow_ai_gateway_config.yaml
RUN chmod +x /mlflow_ai_gateway_config.yaml

ARG MLFLOW_GATEWAY_URI
ENV MLFLOW_GATEWAY_URI="http://0.0.0.0:7000"

ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY

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

EXPOSE 80
EXPOSE 7000

ENTRYPOINT ["mlflow", "server"]
# CMD ./entrypoint.sh