# Define resource variables
RG=Week1-RG       
VM_NAME=Week3-VM
LOCATION=eastus
IMAGE=UbuntuLTS
VNET=Week2-VNet
SUBNET=WebSubnet
NSG=Week3-NSG
PUBLICIP=Week3-PIP

# Create NSG and open HTTP/SSH
az network nsg create -g $RG -n $NSG

# Allow SSH (22) and HTTP (80)
az network nsg rule create -g $RG --nsg-name $NSG \
  -n Allow-SSH-HTTP \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes '*' \
  --destination-port-ranges 22 80


# Create public IP
az network public-ip create -g $RG -n $PUBLICIP --sku Basic --allocation-method Dynamic

# Create NIC and attach NSG
az network nic create -g $RG -n ${VM_NAME}-NIC --vnet-name $VNET --subnet $SUBNET --network-security-group $NSG --public-ip-address $PUBLICIP

# Create Cloud-init file
cloud_init_nginx.yaml

# Create the VM (B1s + cloud-init)
az vm create \
  -g $RG \
  -n $VM_NAME \
  --size Standard_B1s \
  --image $IMAGE \
  --admin-username azureuser \
  --generate-ssh-keys \
  --custom-data cloud-init-nginx.yaml \
  --nics ${VM_NAME}-NIC


# Get the Public IP
az vm list-ip-addresses -g $RG -n $VM_NAME -o table

# Test Nginx
http://<your-public-ip>
curl http://<your-public-ip>


# Verify Nginx on the VM
ssh azureuser@<public-ip>


