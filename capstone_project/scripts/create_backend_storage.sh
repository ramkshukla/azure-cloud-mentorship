# Run this locally once (requires az CLI) to create the storage account/container used by backend.tf if it doesn't already exist.

#!/usr/bin/env bash
set -euo pipefail

RG="Week1-RG"
SA="tfstatermk"
LOCATION="eastus"
CONTAINER="tfstate"

echo "Creating resource group (if not exists)..."
az group create -n "$RG" -l "$LOCATION" >/dev/null

echo "Creating storage account (If not exists)..."
az storage account create -n "$SA" -g "$RG" -l "$LOCATION" --sku Standard_LRS --kind StorageV2

echo "Getting Storage key..."
KEY=$(az storage account keys list -g "$RG" -n "$SA" --query "[0].value" -o tsv)

echo "Creating container $Container ..."
az storage container create --name "$CONTAINER" --account-name "$SA" --account-key "$KEY"

echo "Done. Backend Ready"