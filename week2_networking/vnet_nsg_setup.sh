# Create a Virtual Network with Subnets 

# Create VNet
az network vnet create --name Week2-VNet --resource-group Week1-RG --address-prefix 10.0.0.0/16 --subnet-name WebSubnet --subnet-prefix 10.0.1.0/24

# Add DataSubnet
az network vnet subnet create --name DataSubnet --resource-group Week1-RG -vnet-name Week2-Vnet --address-prefix 10.0.2.0/24

# List VNets in a Resource Group
az network vnet list --resource-group Week1-RG -o table

# List all subnets in a specific VNet
az network vnet subnet list --resource-group Week1-RG --vnet-name Week1-VNet -o table


--------------------------------------------------------------------------------
# Create an NSG and Attach to Subnet
az network nsg create --resource-group  Week1-RG --name Week2-NSG

# Add inbound rule to allow HTTP/HTTPS
az network nsg rule create --nsg-name Week2-NSG --resource-group Week1-RG  --name Allow-HTTP-HTTPS --protocol Tcp --direction Inbound --priority 100 --source-address-prefixes '*' --source-port-ranges '*' --destination-port-ranges 80 443 --access Allow

# Associate NSG to WebSubnet 
az network vnet subnet update --vnet-name Week2-VNet --name WebSubnet --resource-group Week1-RG --network-security-group Week2-NSG

# List NSGs attached to each subnet
az network vnet subnet list --resource-group Week1-RG --vnet-name Week2-Vnet --query "[].{Subnet:name,NSG:networkSecurityGroup.id}" -o table


