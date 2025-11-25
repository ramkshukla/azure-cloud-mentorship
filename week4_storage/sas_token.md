# Generate a container-level SAS (for temporary access)
We’ll create a SAS token valid for 1 hour allowing read/list/upload/download (adjust permissions).

EXPIRY=$(date -u -d "1 hour" '+%Y-%m-%dT%H:%MZ')
SAS_TOKEN=$(az storage container generate-sas \
  --account-name $SA \
  --account-key $STORAGE_KEY \
  --name $CONTAINER \
  --permissions rwdl \
  --expiry $EXPIRY \
  -o tsv)

echo "SAS token: $SAS_TOKEN"


Static Website Link : 

https://week4storage36950.z13.web.core.windows.net/home/ram/week4_files/index.html