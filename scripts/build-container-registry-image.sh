#!/bin/bash

set -Eeuo pipefail

az acr login --name $ACR_NAME  --expose-token

az acr build --registry $ACR_NAME --image $ACR_NAME:v1 ../ --file ../Dockerfile
