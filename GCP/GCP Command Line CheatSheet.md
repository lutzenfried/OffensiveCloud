# GCP command line

- gcloud cli

## Authentication
### User identity login
```
gcloud init
```

```
gcloud auth login
```

### Show debug info / HTTP log
```
gcloud projects list --log-http
```

### Listing projects using access token
```
gcloud projects list --access-token-file=accesstoken.json
```

### Listing current config
```
gcloud config list
```

### Service account login
```
gcloud auth activate-service-account --key-file ./creds.json
gcloud auth activate-service-account --project=<projectid> --key-file=filename.json
```

### Service account impersonation
```
gcloud iam service-accounts list
gcloud compute instances list --impersonate-service-account storage@service-test-001-iam.gserviceaccount.com
```

### List available accounts
```
gcloud auth list
```

### Get current account configuration
```
gcloud config list
```

### Change current account to another one (if already authenticated)
```
gcloud config set account jdoe@company.com
```

## Gcloud Recon misc
### List organizations
```
gcloud organizations list
```

### List organization policy
```
gcloud organizations get-iam-policy <ORGA ID>
```

### List projects the current user have access
```
gcloud projects list
```

### Get information about specific project
```
gcloud projects describe <PROJECT ID>
```

### Set specific project
```
gcloud config set project <projectName>
```

### List services account
```
gcloud iam service-accounts list
```

### List keys for specific service account
```
gcloud iam service-accounts keys list --iam-account svc-acc@projectName.iam.gserviceaccount.com
```

### List permissions for specific service account
```
gcloud iam service-accounts get-iam-policy svc.acc@projectName.iam.gserviceaccount.com
```

### List permissions for current user at project level
```
gcloud projects get-iam-policy <project-id>
```
This is assuming, of course, that the IAM permissions are assigned to the users at the project level. You may also want to use get-ancestors-iam-policy, which includes project AND inherited roles from the folder and org levels:
```
gcloud projects get-ancestors-iam-policy <project-id>
```

### List permissions to specific user at project level
```
gcloud projects get-iam-policy <project-id> --flatten="bindings[].members" --filter="bindings.members=user:USERNAME@company.com" --format="value(bindings.role)"
```

### List permission on resource level (compute instance)
```
gcloud compute instances get-iam-policy instanceName --zone us-central1-b 
```

### Listing permissions for service account
```
gcloud beta asset search-all-iam-policies --scope=organizations/123 --query="policy:456@cloudservices.gserviceaccount.com" | egrep "role:|resource:|gserviceaccount"
```

### Describe role permissions
```
gcloud iam roles describe [ROLEName]
```

### Setting role permission to a user
```
gcloud projects add-iam-policy-binding [project-id] --member='user:[user-email]' --role='roles/owner'
```

### Setting role permission to a service account
```
gcloud projects add-iam-policy-binding [project-id] --member='serviceAccount:[sa-email]' --role='roles/editor'
```

### List permissions in custom role
```
gcloud iam roles describe [rolename] --project <projectID>
```

### Gives a list of all APIs that are enabled in project
```
gcloud services list
```

### Get source code repos available to user
```
gcloud source repos list
```

### Creating a cloud function with attached service account
```
gcloud functions deploy [my-fun] --timeout 539 --trigger-http --source [function-source] --runtime python37 --entry-point hello_world
--service-account [service-account-email]
```

### Updating cloud function code
```
gcloud functions deploy <FunctionName> --timeout 539 --source ./function-source --runtime python39
```

### Running previously created cloud function
```
gcloud functions call function-name --data '{}'
```

### List of all users associated with specific project ID (Get the IAM policy for a project)
This will display the roles associated with each IAM member.  
```
gcloud projects get-iam-policy project-test-1234
```

## GCloud Network Recon
This would allow attacker for example to enumerate Firewall rules, compute instance networking/interface or GCP services such as GCP Direct Peering. The goal of direct peering is to link the internal network of an organization to a GCP Direct Peering location.

### List networks for Compute Engine
```
gcloud compute networks list
```

### Describe specific compute network
```
gcloud compute networks describe <ComputeNetworkName>
```

### List route used by compute instances
```
gcloud compute routes list
```

#### List network for Compute Engine peering
```
gcloud compute networks peerings list
```

### List firewall rules
```
gcloud compute firewal-rules list
```

### Get the effective firewall of a Compute Engine network
```
gcloud compute networks get-effective-firewalls <ComputeNetworkName>
```

## GCloud Compute Recon
### List the compute instance
```
gcloud compute instances list
gcloud compute instances describe <InstanceName> --zone us-east1-d
```

### List disk used by compute instance
```
gcloud compute disks list
gcloud compute disks describe <DiskName> --zone us-east1-d
```

### List compute snapshots
```
gcloud compute snapshots list
gcloud compute snapshots describe <SnapshotName>
```

### List backed up AMI  image
```
gcloud compute images list
gcloud compute images describe <ImageName>
```

### Get Shell access on compute instance
```
gcloud beta compute ssh --zone "<Region>" "<InstanceName>" --project "<ProjectName>"
```

## GCloud Storage Recon
### List Storage from a configured account
```
gsutil ls
gcloud alpha storage ls
```

### List specific bucket recursively
```
gcloud alpha storage list --recursive gs://<BucketName>
gsutil ls -r gs://<BucketName>
```

### List project in specific project
```
gcloud storage ls --poject PROJECTNAME
```

### Copy object from bucket
```
gcloud alpha storage gs://bucketId/iteam ./
gsutil cp gs://bucketId/item ./
```

### List storage publicly accessible
```
gcloud alpha storage ls gs://cdn_test/
```

## GCloud Containers Recon
### List clusters
```
gcloud container clusters list
```

## Cloud Key Management service

### List the global keyrings available
```
gcloud kms keyrings list --location global
```

### List the keys inside a keyring
```
gcloud kms keys list --keyring [KEYRING NAME] --location global
```

### Decrypt a file using one of your keys
```
gcloud kms decrypt --ciphertext-file=[INFILE] \
    --plaintext-file=[OUTFILE] \
    --key [KEY] \
    --keyring [KEYRING] \
    --location global
```

## Resources
### GCloud large cheatsheet
- https://gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97

### Enumeration cheatsheet
- https://github.com/six2dez/pentest-book/blob/master/enumeration/cloud/gcp.md#enumeration
