# Budget Deployment failed as 

BUDGET_NAME="monthlyCostLimit"

az consumption budget create \
  --amount 100 \
  --timeframe Monthly \
  --name $BUDGET_NAME \
  --category cost \
  --resource-group $RG \
  --notification-alert-percentage 80 \
  --notification-email someone@example.com

az deployment group create
--resource-group Week1-RG 
--template-file "C:\Users\Ram\Desktop\azure-cloud-mentorship\week8_observability_cost\budget.json"
