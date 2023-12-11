FROM condaforge/mambaforge:4.14.0-0

# Install gcc
RUN apt-get update && \
    apt-get install -y gcc

RUN pip install PyMySQL==1.1.0 && \   
    pip install psycopg2-binary==2.9.9 && \
    pip install mlflow[genai]==2.9.1

COPY ../mlflow_ai_gateway_config.yaml /mlflow_ai_gateway_config.yaml
RUN chmod +x /mlflow_ai_gateway_config.yaml

ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY

EXPOSE 7000

ENTRYPOINT ["mlflow", "gateway", "start", "--config-path", "mlflow_ai_gateway_config.yaml", "--host", "0.0.0.0", "--port", "7000"]