#!/bin/bash

set -Eeuo pipefail

az extension add -n containerapp

az containerapp ingress enable -n $CONTAINER_APP_NAME -g $RESOURCE_GROUP --type external --target-port 8080 --transport auto
