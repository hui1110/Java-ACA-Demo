#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME  --expose-token --output tsv --query accessToken

az acr build --resource-group $RESOURCE_GROUP --registry $ACR_NAME https://github.com/hui1110/Java-ACA-Demo.git --image $ACR_NAME:v1 -f Windows.Dockerfile --platform windows

echo "build image completed !"