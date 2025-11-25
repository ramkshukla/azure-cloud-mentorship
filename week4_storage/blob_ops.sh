# Set variables

# change these as needed
RG=Week1-RG
LOCATION=eastus
SA=week4storage$(date +%s | tail -c 6)   # unique storage account name (lowercase, 3-24 chars)
SKU=Standard_LRS                           # change to Standard_ZRS / Standard_GRS if desired
KIND=StorageV2                             # use StorageV2 for blobs + static website support
CONTAINER=webcontent
LOCAL_DIR=./week4_files
INDEX=index.html
ERROR404=404.html
FILES_SHARE=myfileshare
QUEUE_NAME=myqueue

# Create storage account

az storage account create \
  --name $SA \
  --resource-group $RG \
  --location $LOCATION \
  --sku $SKU \
  --kind $KIND \
  --access-tier Hot

# Get account key (needed for az storage commands below)

STORAGE_KEY=$(az storage account keys list -g $RG -n $SA --query "[0].value" -o tsv)
echo "Using storage account: $SA"

# Create a Blob container

az storage container create \
  --account-name $SA \
  --account-key $STORAGE_KEY \
  --name $CONTAINER

# Prepare local files to upload (index + 404)

mkdir -p $LOCAL_DIR
cat > $LOCAL_DIR/$INDEX <<'EOF'
<!doctype html>
<html>
<head><title>Week4 Static Site</title></head>
<body><h1>Hello from Week4 Azure Storage Static Website</h1></body>
</html>
EOF

cat > $LOCAL_DIR/$ERROR404 <<'EOF'
<!doctype html>
<html><body><h1>404 - Not found</h1></body></html>
EOF

# Upload blobs

az storage blob upload \
  --account-name $SA \
  --account-key $STORAGE_KEY \
  --container-name $CONTAINER \
  --file $LOCAL_DIR/$INDEX \
  --name $INDEX

az storage blob upload \
  --account-name $SA \
  --account-key $STORAGE_KEY \
  --container-name $CONTAINER \
  --file $LOCAL_DIR/$ERROR404 \
  --name $ERROR404

# verify using below command:

az storage blob list --account-name $SA --account-key $STORAGE_KEY --container-name $CONTAINER -o table

PS /home/ram> az storage blob upload-batch `
>>   --account-name $SA `
>>   --account-key $STORAGE_KEY `
>>   --source $LOCAL_DIR `
>>   --destination '$web'


PS /home/ram> echo "Static website URL: ${WEB_ENDPOINT}${INDEX}"            
Static website URL: https://week4storage36950.z13.web.core.windows.net/index.html

PS /home/ram/week4> echo "Static website URL: ${WEB_ENDPOINT}404.html" 
Static website URL: https://week4storage36950.z13.web.core.windows.net/404.html


------------------------------- UPDATE WEBSITE CONTENT ---------------------------------
# You can list all storage accounts in your resource group:
az storage account list -g Week1-RG -o table

# How to get Storage Account Key ($STORAGE_KEY)
az storage account keys list \
  --resource-group Week1-RG \
  --account-name $SA \
  -o table

# GET STORAGE_KEY
STORAGE_KEY=$(az storage account keys list \
  --resource-group Week1-RG \
  --account-name $SA \
  --query "[0].value" -o tsv)

# Use the values to upload updated content
az storage blob upload \
  --account-name $SA \
  --account-key $STORAGE_KEY \
  --container-name '$web' \
  --file ./week4_files/index.html \
  --name index.html \
  --overwrite true


