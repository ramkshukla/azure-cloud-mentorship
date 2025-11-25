# Get the public IP
$RG = "Week1-RG"
$VM_NAME = "WebVM1"

az vm list-ip-addresses -g $RG -n $VM_NAME -o table

# Start a VM 
az vm start --name WebVM1 --resource-group Week1-RG 

# Generate public key and private key to access VM
ssh-keygen -t rsa -b 2048 -f ~/.ssh/newkey

# Give read permission for file
chmod 600 ~/.ssh/newkey  

# Update the VM with the new public key 
az vm user update --resource-group $RG --name WebVM1 --username azureuser --ssh-key-value ~/.ssh/newkey.pub

# Connect to VM
ssh -i ~/.ssh/newkey azureuser@172.203.133.173

# check nginx server status
sudo systemctl status nginx
sudo systemctl stop nginx

# Web VM (public IP) - will run nginx on port 80
az vm create -g $RG -n WebVM1 \
  --image UbuntuLTS --size Standard_B1s \
  --vnet-name $VNET --subnet WebSubnet \
  --public-ip-address WebVM1PublicIP \
  --admin-username azureuser --generate-ssh-keys \
  --custom-data web-cloud-init.txt

# Data VM (public IP) - runs a simple HTTP on 8080 but DataNSG blocks inbound from Internet
az vm create -g $RG -n DataVM1 \
  --image UbuntuLTS --size Standard_B1s \
  --vnet-name $VNET --subnet DataSubnet \
  --public-ip-address DataVM1PublicIP \
  --admin-username azureuser --generate-ssh-keys \
  --custom-data data-cloud-init.txt

WEB_PUB=$(az vm list-ip-addresses -g $RG -n WebVM1 --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
DATA_PUB=$(az vm list-ip-addresses -g $RG -n DataVM1 --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)

WEB_PRIV=$(az vm list-ip-addresses -g $RG -n WebVM1 --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)
DATA_PRIV=$(az vm list-ip-addresses -g $RG -n DataVM1 --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)

echo "Web public: $WEB_PUB   Web private: $WEB_PRIV"
echo "Data public: $DATA_PUB   Data private: $DATA_PRIV"

