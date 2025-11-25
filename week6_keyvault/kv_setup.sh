0 — Variables (edit as needed)

RG=Week1-RG
LOCATION=eastus
KV=week6-kv-$(date +%s | tail -c6)
SECRET_NAME=myAppSecret
SECRET_VALUE='S3cr3tValue!@#'
VM_NAME=Week3-VM           # or the VM you created in Week 3

# Create Key Vault

az keyvault create \
  --name $KV \
  --resource-group $RG \
  --location $LOCATION \
  --sku standard

# Confirm:
az keyvault show -n $KV -g $RG -o table

# Store a secret

az keyvault secret set --vault-name $KV --name $SECRET_NAME --value "$SECRET_VALUE"
# verify
az keyvault secret show --vault-name $KV --name $SECRET_NAME --query "value" -o tsv

# Access models: Access policies vs Azure RBAC

Access Policies (classic vault-level model): you grant a principal explicit secret/key/certificate permissions on the vault.
RBAC model: Key Vault operations are authorized through Azure RBAC roles (e.g., Key Vault Secrets User) and is preferable for large orgs.
You can use either. Below shows both options so you can try each.

# Grant access using Access Policy (vault permission)

# example: grant current user
CURRENT_USER_OBJECT_ID=$(az ad signed-in-user show --query objectId -o tsv)
az keyvault set-policy --name $KV --object-id $CURRENT_USER_OBJECT_ID --secret-permissions get list

4 — Retrieve secret from Cloud Shell (as a user with access)
az keyvault secret show --vault-name $KV --name $SECRET_NAME --query value -o tsv
