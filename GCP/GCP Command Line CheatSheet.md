# GCP command line

- gcloud cli

## Authentication
##### User identity login
```
gcloud init
```

```
gcloud auth login
```

##### Service account login
```
gcloud auth activate-service-account --key-file ./creds.json
```

#### List available accounts
```
gcloud auth list
```

#### Get current account configuration
```
gcloud config list
```

#### Change current account to another one (if already authenticated)
```
gcloud config set account jdoe@company.com
```

## Gcloud Recon
#### List organizations
```
gcloud organizations list
```

#### List projects
```
gcloud projects list
```

#### Get information about specific project
```
gcloud projects describe <PROJECT ID>
```

#### Set specific project
```
gcloud config set project <projectName>
```

#### List services account
```
gcloud iam service-accounts list
```

#### List of all users associated with specific project ID (Get the IAM policy for a project)
This will display the roles associated with each IAM member.  
```
gcloud projects get-iam-policy project-test-1234
```

## Gcloud network recon
This would allow attacker for example to enumerate Firewall rules, compute instance networking/interface or GCP services such as GCP Direct Peering. The goal of direct peering is to link the internal network of an organization to a GCP Direct Peering location.

#### List networks for Compute Engine
```
gcloud compute networks list
```

#### Describe specific compute network
```
gcloud compute networks describe <ComputeNetworkName>
```

#### List route used by compute instances
```
gcloud compute routes list
```

##### List network for Compute Engine peering
```
gcloud compute networks peerings list
```

#### Get the effective firewall of a Compute Engine network
```
gcloud compute networks get-effective-firewalls <ComputeNetworkName>
```

#### List Storage from a configured account
```
gcloud alpha storage ls
```

#### List storage publicly accessible
```
gcloud alpha storage ls gs://cdn_test/
```







```
```
