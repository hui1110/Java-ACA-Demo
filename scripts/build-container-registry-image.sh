echo "build-image.sh started"
az acr login --name $ACR_NAME

az acr build --registry $ACR_NAME --image $ACR_NAME.azurecr.io/helloacrtasks:v1 .

echo "build-image.sh completed successfully!"