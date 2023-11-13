#!/bin/bash

set -Eeuo pipefail

echo "build image started"

az acr login --name $ACR_NAME  --expose-token

#az acr build -r $ACR_NAME https://github.com/hui1110/Java-ACA-Demo.git -f Windows.Dockerfile --platform windows -t $ACR_NAME:v1

az acr build --registry $ACR_NAME --image $ACR_NAME:v1 https://github.com/hui1110/Java-ACA-Demo.git


echo "build image completed !"