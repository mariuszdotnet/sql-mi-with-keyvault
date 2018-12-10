# Azure Sql Database Managed Instance (SQL MI) Creation inside Existing Virtual Network

This template allows you to create a [Azure SQL Database Managed Instances](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance) inside an existing virtual network.  The existing virtual network must meet the [following requirements](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-vnet-configuration#requirements) for deployment to be successful.

+ Create new SQL MI inside existing virtual network
+ Output the Server Object details including host name for the SQL MI
+ Template based on [this](https://github.com/Azure/azure-quickstart-templates/tree/master/101-sqlmi-new-vnet) reference
+ To see the complete ARM defenition for this resource go [here](https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2015-05-01-preview/managedinstances)
+ Added sample certifiacte for TDE and databasebackup for testing.  See the [sample-certificate-tde](/sample-certificate-tde) folder.