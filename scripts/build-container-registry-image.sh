#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME  --expose-token

az acr build -g $RESOURCE_GROUP -r $ACR_NAME . -t $ACR_NAME:v1

echo "build image completed !"