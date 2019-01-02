# Variables that need to be set to start working with ARM, lets make some changes.

# The subscriptionId
$subscriptionId = '5aec60e9-f535-4bd7-a951-2833f043e918'

# Root path to script, template and parameters.  All have to be in the same folder.
$rootPathToFiles = (Get-Item -Path ".\").FullName

# Name of the resource group you are targeting the deployment into
$resourceGroupName = 'sql-mi-rg'

# Resource Group Location 
$resourceGroupLocation = 'Canada Central' # Run <Get-AzureLocation> to find out azure locations; EXAMPLE: 'East US 2'

# Name of the deployment; User friendly name to reference the deployment.
$deploymentName = 'Deployment1'

# Authenticate Against you Azure Tenant
Login-AzureRmAccount

# List subscriptions that are available to you
Get-AzureRmSubscription

# Select the subscription you want to work on
Select-AzureRmSubscription -SubscriptionId $subscriptionId

# Run the below to test the ARM template
Test-AzureRmResourceGroupDeployment -Verbose -ResourceGroupName $resourceGroupName -TemplateFile "$rootPathToFiles\template.json" -TemplateParameterFile "$rootPathToFiles\parameters.json"

# Deploy the ARM template using the parameter file
New-AzureRmResourceGroupDeployment -Mode Incremental -verbose -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPathToFiles\template.json" -TemplateParameterFile "$rootPathToFiles\parameters.json"

#New-AzureRmDeployment 
#Test-AzureRmDeployment 
# Deploy the ARM templatet inputing parameters manually via CLI
#New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "$rootPath\azuredeploy.json"

# Create the new Azure Resource Group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation -Force

# Deleate Azure Resource Group
#Remove-AzureRmResourceGroup -Name $resourceGroupName -Force

# Set soft delete on KV for SQL MI TDE BYOK
($resource = Get-AzureRmResource -ResourceId (Get-AzureRmKeyVault -VaultName "sql-mi-kv").ResourceId).Properties | Add-Member -MemberType "NoteProperty" -Name "enableSoftDelete" -Value "true" 
Set-AzureRmResource -resourceid $resource.ResourceId -Properties $resource.Properties
# Generate RSA Key for BYOK for TDE
$key = Add-AzureKeyVaultKey -VaultName MyKeyVault -Name MyTDEKey -Destination Software -Size 2048

## Test TDE
$fileContentBytes = Get-Content 'C:\git\sql-mi-with-keyvault\sample-certificate-tde\TDE_CERT.pfx' -Encoding Byte
$base64EncodedCert = [System.Convert]::ToBase64String($fileContentBytes)
$securePrivateBlob = $base64EncodedCert  | ConvertTo-SecureString -AsPlainText -Force
$password = "11supersecret!!"
$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
Add-AzureRmSqlManagedInstanceTransparentDataEncryptionCertificate -ResourceGroupName "sql-mi-vnet-rg" -ManagedInstanceName "mksqlmipipeline" -PrivateBlob $securePrivateBlob -Password $securePassword

Get-AzureRmADServicePrincipal -ObjectId 71fb1ce9-41ba-4deb-9bf7-ffedaada87f0
Get-AzureRmADServicePrincipal -ServicePrincipalName "mksqlmipipeline"