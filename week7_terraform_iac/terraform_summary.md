# 1. Create resource group and storage account for Terraform state
RG_NAME="rg-week7"
LOCATION="eastus"
STORAGE_NAME="tfstate$RANDOM"
CONTAINER_NAME="tfstate"

az group create --name $RG_NAME --location $LOCATION

az storage account create \
  --name $STORAGE_NAME \
  --resource-group $RG_NAME \
  --location $LOCATION \
  --sku Standard_LRS

az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_NAME \
  --auth-mode login

Step 1: Get storage account key
$key = az storage account keys list \
  --account-name tfstatermk \
  --resource-group Week1-RG \
  --query "[0].value" -o tsv

Step 2 - Enable HTTPS-only on the storage account
az storage account update \
  --name tfstatermk \
  --resource-group Week1-RG \
  --https-only true

az storage container create \
  --name tfstate \
  --account-name tfstatermk \
  --account-key $key


✅ You can verify the container exists using:
az storage container list --account-name tfstatermk --account-key $key -o table


STEP 4 — Initialize Terraform

az login
cd terraform
terraform init
terraform plan
terraform apply



-------------------------------------------------------------------------------
📌 Step 1 — Create a Resource Group using Terraform
providers.tf
main.tf

📌 Step 2 — Add Storage Account + Container
📌 Step 3 — Deploy an App Service with Terraform
Create:

✔ App Service Plan
✔ App Service

🚀 PHASE 3 — Run Terraform
Inside folder:
  terraform init
  terraform fmt
  terraform validate
  terraform plan
  terraform apply

This deploys:
✔ RG
✔ Storage Account
✔ Blob Container
✔ App Service Plan
✔ App Service


