#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME  --expose-token

az acr build -g $RESOURCE_GROUP -r $ACR_NAME --file Dockerfile --image $ACR_NAME:v1

echo "build image completed !"