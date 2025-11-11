
# Assign Reader Role to a User on RG Scope
az role assignment create --assignee Ram.Shukla@rsystems.com --role Reader --scope /Subscriptions/ac6e8c49-833e-427d-bcc4-87042af5ddaf/resourceGroups/Week1-RG


# List resource groups
az group list --output table

# Show details of specific RG
az group show --name Week1-RG


# Add/Update tags
az tag create --resource-id /subscriptions/ac6e8c49-833e-427d-bcc4-87042af5ddaf/resourceGroups/Week1-RG --tags Project=Cloud101
