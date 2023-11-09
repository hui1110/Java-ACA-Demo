#!/bin/bash

echo "build image started"

acrLoginToken=$(az acr login --name $ACR_NAME --expose-token)

docker login $ACR_NAME -u 00000000-0000-0000-0000-000000000000 -p $acrLoginToken

az acr build --registry $ACR_NAME --image $ACR_NAME.azurecr.io/helloacrtasks:v1 .

echo "build image completed !"