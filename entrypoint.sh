#!/bin/bash

# Construct the database URI using the environment variables DB_USERNAME, DB_PASSWORD, DB_HOST, DB_PORT, and DB_NAME
export DB_URI="mysql+pymysql://$DB_USERNAME:`echo -n $DB_PASSWORD`@$DB_HOST:$DB_PORT/$DB_NAME"

printf "The DB URI is: $DB_URI\n"

# Start the MLflow server
mlflow server --app-name=basic-auth --host=$HOSTNAME --port=$SERVICE_PORT --artifacts-destination=$ARTIFACTS_DESTINATION --backend-store-uri=$DB_URI &

# Start the MLFlow AI Gateway
mlflow gateway start --config-path mlflow_ai_gateway_config.yaml --port 7000 --host $HOSTNAME &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?