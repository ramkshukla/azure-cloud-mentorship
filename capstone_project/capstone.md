# Initialize Terraform:
cd capstone_project/infra
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve tfplan

# Upload static site after apply:

SA_NAME=$(terraform output -raw azurerm_storage_account_sa_name 2>/dev/null || echo "<your-storage-name>")
# Get key
KEY=$(az storage account keys list -g <rg> -n $SA_NAME --query "[0].value" -o tsv)
az storage blob upload-batch --account-name $SA_NAME --account-key $KEY --source ../app --destination '$web'
