#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME

az acr build --resource-group $RESOURCE_GROUP --registry $ACR_NAME --image $ACR_NAME.azurecr.io/helloacrtasks:v1 .

echo "build image completed !"