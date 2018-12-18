# Configure a VNet for Azure SQL Database Managed Instance

This template allows you to create all the required resources to prepare a Vnet for a SQL Database Managed Instance deployment. Requirements are based on the following [link](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-vnet-configuration#modify-an-existing-virtual-network-for-managed-instances).

## Important

You won’t be able to deploy a new Managed Instance if the destination subnet is not compatible with all of these requirements. When a Managed Instance is created, a Network Intent Policy is applied on the subnet to prevent non-compliant changes to networking configuration. After the last instance is removed from the subnet, the Network Intent Policy is removed as well.

+ Requires existing VNet and Subnet
+ Creates Route Table
+ Creates NSG and NSG Rules