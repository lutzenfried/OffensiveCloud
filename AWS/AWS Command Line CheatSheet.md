# AWS Command Line

# Env
#### Exporting AWS Key to env variables
```$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE```  
```$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY```  
```$ export AWS_SESSION_TOKEN=FwoGZXIvYXdzEDcaDFV2Oa7kg/==```  
```$ export AWS_DEFAULT_REGION=us-west-2```  
<br/>
```C:\> setx AWS_ACCESS_KEY_ID AKIAIOSFODNN7EXAMPLE```  
```C:\> setx AWS_SECRET_ACCESS_KEY wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY```  
```C:\> setx AWS_DEFAULT_REGION us-west-2```  
<br/>

## STS : Simple Token Service
#### Returns details about the IAM user or role whose credentials are used to call the operation.
> aws sts get-caller-identity
<br/>

## IAM
#### IAM resource-listing operations return a subset of the available roles for the current resource/profile
> aws iam list-roles

#### Lists all managed policies that are attached to the specified IAM user
> aws iam list-attached-user-policies --user-name student

#### Lists the names of the inline policies embedded in the specified IAM user
> aws iam list-user-policies --user-name student

#### Retrieves the specified inline policy document that is embedded in the specified IAM user.
> aws iam get-user-policy --user-name student --policy-name terraform-xxxx

#### Lists the names of the inline policies that are embedded in the specified IAM role
> aws iam list-role-policies --role-name Adder

#### Retrieves the specified inline policy document that is embedded in the specified IAM role
> aws iam get-role-policy --role-name Adder --policy-name AddUser

#### Assume a role and returns a set of temporary security credentials 
> aws sts assume-role --role-arn arn:aws:iam::5XXXXXXXXXXX:role/Adder --role-session-name hacker

#### Attaches the specified managed policy to the specified IAM group
> aws iam attach-group-policy --group-name Printers --policy-arn arn:aws:iam:aws:policy/AdministratorAccess

#### Retrieve information about the specified managed policy
> aws iam get-policy --policy-arn arn:aws:iam::5XXXXXXXXXXX:policy/Print

#### Retrieves information about the specified version of the specified managed policy.
> aws iam get-policy-version --policy-arn arn:aws:iam::5XXXXXXXXXXX:policy/Print --version-id v1

#### Add user to group
> aws iam add-user-to-group --group-name Printers --user-name student

#### Get policy version
> aws iam get-policy-version --policy-arn arn:aws:iam::5XXXXXXXXXXX:policy/Print --version-id v1

```
{
    "PolicyVersion": {
        "CreateDate": "2021-09-27T13:19:28Z", 
        "VersionId": "v1", 
        "Document": {
            "Version": "2012-10-17", 
            "Statement": [
                {
                    "Action": "s3:ListAllMyBuckets", 
                    "Resource": "*", 
                    "Effect": "Allow"
                }
            ]
        }, 
        "IsDefaultVersion": true
    }
}
```

#### Creates a new version of the specified managed policy. 
--> To update a managed policy, you create a new policy version  
> aws iam create-policy-version --policy-arn arn:aws:iam::424116221589:policy/Print --policy-document file://strategie.json --set-as-default


#### Policy syntaxe exemple

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:ListAllMyBuckets",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
```
<br/>

## S3
#### Listing S3 buckets availables
> aws s3 ls

#### Listing S3 bucket objects
> aws s3 ls s3://secret-bucket

#### Listing S3 bucket objects from specific endpoint
> aws s3 ls --endpoint http://192.99.121.3:9000 s3://hello-world

#### Unauthenticated S3 listing
> aws s3 ls s3://lab-webapp-static-resources --no-sign-request

#### Get S3 bucket policy
> aws s3api get-bucket-policy --bucket bucketname123

#### Get S3 bucket policy and beautify json
> aws s3api get-bucket-policy --bucket bucketname123 --output text | jq

#### Apply new bucket policy to S3 bucket
> aws s3api put-bucket-policy --bucket s3-writable-policy-3XXXXXXX --policy file://policy.json

#### Get bucket ACL
--> To use GET to return the ACL of the bucket, you must have *READ_ACP* access to the bucket.  

--> If *READ_ACP* permission is granted to the anonymous user, you can return the ACL of the bucket without using an authorization header.  

> aws s3api get-bucket-acl --bucket s3-secret-782781142412

#### Put bucket ACL (Require *WRITE_ACP* permission)
Sets the permissions on an existing bucket using access control lists (ACL)  
> aws s3api put-bucket-acl --bucket s3-secret-7XXXXX --access-control-policy file://acl.json

#### Get Object ACL
--> Object : s3://8XXXXXXXXXXX/flag  

> aws s3api get-object-acl --bucket s3-secret-8XXXXXXXXXXX --key flag

#### Put Object ACL (Require *WRITE_ACP* permission)
> aws s3api put-object-acl --bucket s3-secret-8XXXXXXXXXXX --key flag --access-control-policy file://acl.json
<br/>

## Lambda
#### Listing AWS Lambda function within a specific region
This could be usefull to find exposed environment variables within the Lambda function.  
> aws lambda list-functions --region ca-central-1
<br/>

## DynamoDB
#### Listing tables
> aws dynamodb --endpoint http://192.168.2.12:4567 list-tables

#### Get item in specific table
> aws dynamodb --endpoint http://192.44.35.3:4567 scan --table-name users

#### Get id for specific user in users table
> aws dynamodb --endpoint http://192.44.35.3:4567 scan --table users --filter-expression "UserName = :value" --projection-expression "UserId" --expression-attribute-values file:///root/attribute_value.json

--> **attribute_value.json**
```
{
        ":value": {"S": "Amber Patrick"}
}
```

