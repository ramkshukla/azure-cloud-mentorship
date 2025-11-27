RG="rg-week8"
LOCATION="eastus"
LAW="logs-week8"

az group create --name $RG --location $LOCATION

az monitor log-analytics workspace create \
  --resource-group $RG \
  --workspace-name $LAW \
  --location $LOCATION

VM_NAME="DataVM1"

az monitor vm insights enable \
  --resource-group $RG \
  --vm-name $VM_NAME \
  --workspace $LAW

az monitor metrics alert create \
  --name "HighCPUAlert" \
  --resource-group $RG \
  --scopes $(az vm show -g $RG -n $VM_NAME --query id -o tsv) \
  --condition "avg Percentage CPU > 80" \
  --description "CPU usage exceeded 80%" \
  --evaluation-frequency 1m \
  --window-size 5m
