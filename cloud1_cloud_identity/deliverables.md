# 🔐 Access Model

The access model defines how Azure resources are organized and accessed using Azure Resource Manager (ARM). It includes:

- **Tenant**: The Azure Active Directory instance.
- **Subscription**: Billing boundary and container for resources.
- **Resource Group (RG)**: Logical grouping of resources.
- **Resources**: Individual services like VMs, Storage, etc.

### 📦 Hierarchy

Tenant → Subscription → Resource Group → Resources


### 🏷️ Tags Used

| Tag Name      | Value                   |
|---------------|--------------------------|
| `owner`       | ram.kumar@example.com    |
| `env`         | dev                      |
| `cost_center` | cloud-lab-01             |

---

# 📊 RBAC Matrix

| Role Name   | Scope           | Assigned To            | Permissions Summary                    |
|-------------|------------------|-------------------------|-----------------------------------------|
| Reader      | Resource Group   | peer@example.com        | View resources, no changes              |
| Contributor | Resource Group   | ram.kumar@example.com   | Full access except role assignment      |
| Owner       | Subscription     | admin@example.com       | Full access including role assignment   |