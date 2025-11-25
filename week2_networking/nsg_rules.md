# Virtual Network (VNet)
Logical network in Azure where resources communicate securely.
Provides IP addressing, subnets, routing, and security isolation.

Key concepts:
    Address space (e.g., 10.0.0.0/16) → define network range.
    VNets are regional (cannot span regions).
    Analogy: VNet = Company office network.

# Subnet
Subnet = smaller segment of a VNet for grouping resources.
Helps organize resources and apply security rules.

Example:
    WebSubnet → contains web servers
    DataSubnet → contains databases
    Subnet CIDR must be part of VNet address space.

# Network Security Group (NSG)
Firewall at subnet or NIC level.
Defines allow/deny rules for inbound/outbound traffic.

Rule example:
    Allow TCP 80/443 inbound to web servers
    Deny all other inbound traffic
    Analogy: Security guard checking every request going in/out.

# Public vs Private IP
Private IP: Used for internal communication inside VNet.
Public IP: Used to expose resource to the internet.
Web servers → public IP (internet facing)
Databases → private IP (internal only)

# Load Balancer / Public IP Use Case
Public IP allows resources like web servers to be accessed externally.
Azure Load Balancer distributes traffic across multiple VMs in a subnet.
Example: 3 web servers behind LB → users get high availability.

