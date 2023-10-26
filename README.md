# extract-terraform-outputs
Extract Terraform Output into Environment Variables

## Usage
From within a folder containing a terraform.tfstate file:

PS > ./extract-terraform-outputs.ps1
PS > ConvertTFOutputsTo-EnvVariables

[HELLO] Extract Terraform Output into Environment Variables
[OK] Terraform .state found
[ADDED] AZ_TF_DNS_AZURE_DNS_SERVERS 
[ADDED] AZ_TF_DNS_BASE_DOMAIN_NAME
[ADDED] AZ_TF_LOGSTORE_CONTAINER_NAME
[ADDED] AZ_TF_PROJECT_NAME
[ADDED] AZ_TF_RESOURCE_GROUP_NAME
[ADDED] AZ_TF_TAGS_APPLIED
[ADDED] AZ_TF_TFSTATE_CONTAINER_NAME
[ADDED] AZ_TF_TFSTATE_CONTAINER_SAS WARNING: SENSITIVE
[ADDED] AZ_TF_TFSTATE_STRGACCT_NAME
[ADDED] AZ_TF_USERDATA_CONTAINER_NAME 
[GOODBYE]

To check whether these variables have been set correctly, you can use:

gci env:* | sort-object name
