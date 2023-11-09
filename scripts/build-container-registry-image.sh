#!/bin/bash

set -Eeuo pipefail

echo "build image started"

accessToken=$(az acr login --name $ACR_NAME  --expose-token --output tsv --query accessToken)

az acr build --resource-group $RESOURCE_GROUP --registry $ACR_NAME --image $ACR_NAME.azurecr.io/helloacrtasks:v1 .

echo "build image completed !"