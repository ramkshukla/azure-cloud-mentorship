
# Assign Reader Role to a User on RG Scope
az role assignment create --assignee Ram.Shukla@rsystems.com --role Reader --scope /Subscriptions/ac6e8c49-833e-427d-bcc4-87042af5ddaf/resourceGroups/Week1-RG

# Assign Reader Role to a USer on RG Level
az role assignment create --assignee Ram.Shukla@rsystems.com --role Reader --resource-group Week1-RG

#Contributor without write access can not modify IAM roles 
✔ Contributor → CAN create/update/delete resources
❌ Contributor → CANNOT assign Reader/Contributor/Owner to anyone
❌ Contributor → CANNOT remove or modify IAM roles
❌ Contributor → CANNOT update "Access Control (IAM)" page
✔ Contributor → CAN tag resource groups
❌ Contributor → CANNOT give permissions to others

This is exactly the security boundary:
Contributor can manage resources, not permissions.

# List resource groups
az group list --output table

# Show details of specific RG
az group show --name Week1-RG


# Add/Update tags on RG Level
az group update --name Week1-RG --set tags.Environment=Dev  tags.Owner=RamKumar

# Add/Update tags on Subscription Level
az tag create --resource-id /subscriptions/ac6e8c49-833e-427d-bcc4-87042af5ddaf/resourceGroups/Week1-RG --tags Project=Cloud101
