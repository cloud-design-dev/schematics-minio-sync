# Sync Cloud Object Storage objects between accounts.
This repo will deploy a VPC instance that is configured to copy the contents of an IBM Cloud Object Storage bucket from one account to another account. The following variables will be needed when using with Schemtatics:

## Use with Schematics
Here are the steps to using this example with Schematics
 - Create a new Worskpace by going to the [Workspace](https://cloud.ibm.com/schematics/workspaces) page and clicking *Create workspace*
 - On the subsequent page give your workspace a name and select the Resource Group where the workspace will be deployed. Then click *Create*. 
 ![Create workspace](https://dsc.cloud/quickshare/Shared-Image-2020-07-21-11-09-49.png)
 - With the workspace created should see the **Import your Terraform template** section. Put in `https://github.com/cloud-design-dev/schematics-minio-sync/tree/master/vpc` under the *GitHub or GitLab repository URL* and make sure to select `terraform_v0.12` for the *Terraform version*.
![Terraform template settings](https://dsc.cloud/quickshare/Shared-Image-2020-07-21-11-16-19.png){:width="250px"}
 - Click Save template information. 
 - On the Workspace overview page you will now fill out the variables (see below for all variables used). Make sure the check the *Sensitive* box next to the following variables `source_account_access_key`, `source_account_secret_key`, `destination_account_access_key`, and `destination_account_secret_key`. 
 - When you've filled out all the variables click *Save Changes*
 ![Fill in variables](https://dsc.cloud/quickshare/Shared-Image-2020-07-21-11-24-37.png)
 - Run a Schematics Plan
 - Run Schematics Apply

## VPC Variables 
**os_image** - VPC Instance OS Image: Default is currently Ubuntu 18.
**region** - VPC Region where resources will be deployed. 
**resource_group** - Resource group where resources will be deployed.
**subnet_id** - VPC Subnet ID where the instance will be deployed
**linux_ssh_key** - SSH key to add to instance. In case you need to trouble shoot the copy process.

## Source Account Variables (You are copying **from** this account):
**source_account_bucket** - Cloud Object Storage bucket name on the source account.  
**source_account_endpoint** - Cloud Object Storage endpoint on the source account. 
**source_account_access_key** - Cloud Object Storage Access Key on the source account. 
**source_account_secret_key** - Cloud Object Storage Secret Key on the source account.

## Destination Account Variables (You are copying **to** this account):
**destination_account_bucket** - Cloud Object Storage bucket name on the destination account. 
**destination_account_endpoint** - Cloud Object Storage endpoint on the destination account. 
**destination_account_access_key** - Cloud Object Storage Access Key on the destination account.
**destination_account_secret_key** - Cloud Object Storage Secret Key on the destination account



