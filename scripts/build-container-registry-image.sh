#!/bin/bash

set -Eeuo pipefail

rm -rf Java-ACA-Demo

git clone https://github.com/hui1110/Java-ACA-Demo.git

az acr login --name $ACR_NAME  --expose-token

az acr build --registry $ACR_NAME --image $ACR_NAME:v2 ./Java-ACA-Demo
