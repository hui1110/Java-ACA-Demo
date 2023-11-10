#!/bin/bash

set -Eeuo pipefail

az role assignment create --assignee "$SPID" --role acrpull --scope /subscriptions/"$SUBSCRIPTION_ID"/resourceGroups/"$RESOURCE_GROUP"/providers/Microsoft.ContainerRegistry/registries/"$ACR_NAME"
