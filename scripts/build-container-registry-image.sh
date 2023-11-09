#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME  --expose-token

az acr build -r $ACR_NAME --image $ACR_NAME:v1 $pwd

echo "build image completed !"