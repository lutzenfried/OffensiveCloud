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
gcloud auth activate-service-account --key-file creds.json
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

#### Set specific project
```
gcloud config set project <projectName>
```










```
```
