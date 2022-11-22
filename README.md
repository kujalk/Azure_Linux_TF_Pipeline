# Azure_Linux_TF_Pipeline
Terraform script to create Azure Linux VM and run custom script and destroy via Pipeline


#  Architecture

![alt text](https://github.com/kujalk/Azure_Linux_TF_Pipeline/blob/main/Architecture.png?raw=true)

# Pre-Requisites

A Resource group and Storage Blob with Puppetter.zip must exist already. Because from this Blob only the Linux VM will download the zip file and execute the command. Also, this blob is used to upload the log reports from the Linux VM. Linux VM will be granted necessary permission to this blob for these action using Terraform. Note that, VM also will be created in the same resource group


# Method to run from local environment

1. To create the Resource Group and Storage Blob with Puppeteer.zip

- Switch to Terraform-1-Create-Blob directory
- Fill in the terraform.tfvars
- az login
- terraform init
- terraform plan
- terraform apply -auto-approve

2. To create Linux VM (Note that "node wikiTest.js" is not enabled at the moment, but it is simple to integrate into exiting script)

- Switch to Terraform-2-Create-VM directory
- Fill in the terraform.tfvars
- az login
- terraform init
- terraform plan
- terraform apply -auto-approve

# Developer

Janarthanan Kugathasan
