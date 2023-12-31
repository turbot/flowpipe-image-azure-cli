#!/bin/bash
set -Eeo pipefail

# Check if the AZURE_TENANT_ID environment variable is set
if [ -z "$AZURE_TENANT_ID" ]; then
  echo "Error: AZURE_TENANT_ID environment variable is not set."
  exit 1
fi

# Check if the AZURE_CLIENT_ID environment variable is set
if [ -z "$AZURE_CLIENT_ID" ]; then
  echo "Error: AZURE_CLIENT_ID environment variable is not set."
  exit 1
fi

# Check if the AZURE_CLIENT_SECRET environment variable is set
if [ -z "$AZURE_CLIENT_SECRET" ]; then
  echo "Error: AZURE_CLIENT_SECRET environment variable is not set."
  exit 1
fi

# Check and set the AZURE_ENVIRONMENT if provided
if [ -n "$AZURE_ENVIRONMENT" ]; then
  az cloud set --name $AZURE_ENVIRONMENT --only-show-errors
fi

# Use the environment variables for "az login"
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID --output none

# Check if there are additional arguments (commands) passed to the script
if [ $# -eq 0 ]; then
  echo "Error: No command provided. Usage: ./docker-entrypoint.sh <command>"
  exit 1
fi

# Prepend "az" to the provided command and execute it
az "$@"
