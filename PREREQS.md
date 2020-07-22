# Preparing Accounts

## Source Account 
We will create a service ID on the source account. A service ID identifies a service or application similar to how a user ID identifies a user. We can assign specific access policies to the service ID that restrict permissions for using specific services: in this case it gets read-only access to an IBM Cloud Object Storage bucket. 

### Create Service ID
```shell
ibmcloud iam service-id-create <name-of-your-service-id> --description "Service ID for read-only access to bucket" --output json
```

![Service ID Creation](https://dsc.cloud/quickshare/source-service-id.png)

### Create Reader access policy for newly created service id
Now we will limit the scope of this service ID to have read only access to our source Object Storage bucket. 

```shell 
ibmcloud iam service-policy-create <Service ID> --roles Reader --service-name cloud-object-storage --service-instance <Service Instance GUID> --resource-type bucket --resource <bucket-name>
```

*Service Instance GUID*  - This is the GUID of the Cloud Object Storage instance. You can retrieve this with the command: `ibmcloud resource service-instance <name of icos instance>`

**Expected Output Example**
![Service ID Policy Creation](https://dsc.cloud/quickshare/create-source-service-policy.png)

### Generate HMAC credentials tied to our service ID 
In order for the Minio client to talk to each Object Storage instance it will need HMAC credentials (Access Key and Secret Key in S3 parlance). 

```shell
$ ibmcloud resource service-key-create source-icos-service-creds Reader --instance-id <Service Instance GUID> --service-id <Service ID> --parameters '{"HMAC":true}'
```
Save the **access_key_id** and **secret_access_key** as we will be using these in our Schematics environment. 

![Create HMAC Credentials](https://dsc.cloud/quickshare/source-hmac-credentials.png)

---------------------------------------------------------------

## Destination Account
We will create a service ID on the destination account. A service ID identifies a service or application similar to how a user ID identifies a user. We can assign specific access policies to the service ID that restrict permissions for using specific services: in this case it gets write access to an IBM Cloud Object Storage bucket.  

### Create Service ID
```shell
ibmcloud  iam service-id-create <name-of-your-service-id> --description "Service ID for write access to bucket" --output json
```

**Expected Output Example**
![Service ID Creation](https://dsc.cloud/quickshare/destination-service-id.png)

### Create Reader access policy for newly created service id
Now we will limit the scope of this service ID to have read only access to our source Object Storage bucket. 

```shell 
ibmcloud iam service-policy-create <Service ID> --roles Writer --service-name cloud-object-storage --service-instance <Service Instance GUID> --resource-type bucket --resource <bucket-name>
```

*Service Instance GUID*  - This is the GUID of the Cloud Object Storage instance. You can retrieve this with the command: `ibmcloud resource service-instance <name of icos instance>`

### Generate HMAC credentials tied to our service ID 
We'll follow the same procedure as last time to generate the HMAC credentials, but this time on the destination account.

```shell
$ ibmcloud resource service-key-create destination-icos-service-creds Writer --instance-id <Service Instance GUID> --service-id <Service ID> --parameters '{"HMAC":true}'
```
Save the **access_key_id** and **secret_access_key** as we will be using these in our Schematics environment. 
