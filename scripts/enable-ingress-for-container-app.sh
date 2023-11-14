#!/bin/bash

set -Eeuo pipefail

az extension add -n containerapp

az containerapp ingress enable -n $APP_NAME -g $RESOURCE_GROUP --type external --allow-insecure false --target-port 8080 --transport auto
