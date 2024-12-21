BASE="album-containerapps"
RESOURCE_GROUP="rg-"$BASE
IDENTITY="mi-"$BASE
LOCATION="westeurope"
ENVIRONMENT="env-"$BASE
API_NAME="album-api"
FRONTEND_NAME="album-ui"
GITHUB_USERNAME="modestotech"
ACR_NAME="acaalbums"$GITHUB_USERNAME



az group create --name $RESOURCE_GROUP --location "$LOCATION"

az acr create --resource-group $RESOURCE_GROUP --location $LOCATION --name $ACR_NAME --sku Basic

az acr config authentication-as-arm show --registry "$ACR_NAME"

az identity create --name $IDENTITY --resource-group $RESOURCE_GROUP

IDENTITY_ID=$(az identity show --name $IDENTITY --resource-group $RESOURCE_GROUP --query id --output tsv)

docker build --tag $ACR_NAME.azurecr.io/$API_NAME ./src

# az group delete --name $RESOURCE_GROUP
