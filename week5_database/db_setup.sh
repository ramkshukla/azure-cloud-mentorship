# Set up variables (edit values)

# Resource & location
RG=Week1-RG
LOCATION=eastus

# Azure SQL
SQL_SRV=week5sql$(date +%s | tail -c6)
SQL_ADMIN=sqladminuser
SQL_PWD='P@ssw0rd12345!'    # pick strong password meeting Azure rules
SQL_DB=appdb

# PostgreSQL Flexible Server
PG_SRV=week5pg$(date +%s | tail -c6)
PG_ADMIN=pgadminuser
PG_PWD='P@ssw0rd12345!'
PG_DB=appdb_pg
PG_VERSION=13               # 11/12/13/14 etc

# Firewall: allow your current IP (Cloud Shell IP) and optionally VM private IP later
MY_IP=$(curl -s ifconfig.me) || echo ""   # may fail in some environments; if empty, set manually
ALLOWED_START=$MY_IP
ALLOWED_END=$MY_IP

# Create logical server

az sql server create \
  --name $SQL_SRV \
  --resource-group $RG \
  --location $LOCATION \
  --admin-user $SQL_ADMIN \
  --admin-password $SQL_PWD

# Create a single database (DTU or vCore). Basic example uses General purpose / Basic via --service-objective.

# Basic / S0 etc. Use S0 for small prod, Basic for dev (DTU model).
az sql db create \
  --resource-group $RG \
  --server $SQL_SRV \
  --name $SQL_DB \
  --service-objective Basic

# Open firewall to your IP (server-level firewall)

az sql server firewall-rule create \
  --resource-group $RG \
  --server $SQL_SRV \
  --name AllowMyIP \
  --start-ip-address $ALLOWED_START \
  --end-ip-address $ALLOWED_END

# To open to Azure services (allow Azure resources to connect):

az sql server firewall-rule create \
  --resource-group $RG \
  --server $SQL_SRV \
  --name AllowAzureIPs \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0

# Test connectivity (from Cloud Shell or VM)

Install mssql-tools (if using custom Linux VM) — example for Ubuntu:

# for Ubuntu on VM (run on your VM, not Cloud Shell)
sudo apt-get update
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list \
  | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc


# Connect using sqlcmd:
sqlcmd -S ${SQL_SRV}.database.windows.net -U $SQL_ADMIN -P $SQL_PWD -d master -Q "SELECT name, state_desc FROM sys.databases;"


# Connect to demoDB SQL server
PS /home/ram> sqlcmd -S week5sqleastus2.database.windows.net -U sqladminuser@week5sqleastus2 -P 'PasswOrd12345!' -d demoDB