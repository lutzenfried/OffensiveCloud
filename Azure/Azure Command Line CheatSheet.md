# Azure command line and PowerShell modules

- AzureAD
- Az Module
- MSOnline cmdlets
- AZ cli


## AzureAD Module
- https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0    

```Azure Active Directory PowerShell module version for Graph for Azure AD administrative tasks such as user management, domain management and for configuring single sign-on. The cmdlets listed here are different from the MSOnline cmdlets which are part of Azure Active Directory PowerShell version 1.0.```  

#### Connect using AzureAD
> PS C:> Connect-AzureAD  

#### Get the current session state
> PS C:>  Get-AzureADCurrentSessionInfo

#### Get details of the current tenant
> PS C:> Get-AzureADTenantDetail

#### Enumerate users
> PS C:>  Get-AzureADUser -All $true  
> PS C:>  Get-AzureADUser -ObjectId jdoe@company.com  

#### Search for user based on string in first char of DisplayName or UserPrincipalName
> PS C:>  Get-AzureADUser -SearchString "admin"

#### Search for users who contain the word "admin" in their Display name:
> PS C:>  Get-AzureADUser -All $true |?{$_.Displayname -match "admin"}

#### Search attributes for all users that contain specific string
> PS C:>  Get-AzureADUser -All $true |%{$Properties = $_;$Properties.PSObject.Properties.Name | % {if ($Properties.$_ -match 'password'){"$($Properties.UserPrincipalName) - $_ - $($Properties.$_)"}}}

#### List attributes for a user
> PS C:> Get-AzureADUser -ObjectId jdoe@company.com | fl *

#### All user who are synced from on premise
> PS C:> Get-AzureADUser -All $true |?{$_.OnPremisesSecurityIdentifier -ne $null}

#### All users who are from AzureAD
> PS C:> Get-AzureADUser -All $true |?{$_.OnPremisesSecurityIdentifier -eq $null}

#### All Objects created by all user
> PS C:> Get-AzureADUser | Get-AzureADUserCreatedObject

#### Objects created by a specific user
> PS C:> Get-AzureADUserCreatedObject -objectid 03b6e9ae-b389-4c04-8269-623cbe4b0d25

#### Objects owned by a specific user
> PS C:> Get-AzureADUserOwnedObject -ObjectId admin@company.gom

#### List all groups
> PS C:> Get-AzureADGroup -all $true^

#### Enumerate specific group
> PS C:> Get-AzureADGroup -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e

#### Groups which contain the word "admin" in their name
> PS C:> Get-AzureADGroup -All $true |?{$_.Displayname -match "admin"}

#### Get Groups that allow dynamic membership
[Dynamic Group Membership documentation](https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-dynamic-membership)  
> PS C:> Get-AzureADMSGroup | ?{$_.GroupTypes -eq 'DynamicMembership'}

#### Get members of a group
> PS C:> Get-AzureADGroupMember -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e  
> PS C:> Get-AzureADGroup -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e | Get-AzureADGroupMember

#### Get Groups and Roles where specific user is member
> PS C:> Get-AzureADUser -SearchString 'jdoe' | Get-AzureADUserMembership  
> PS C:> Get-AzureADUserMembership -ObjectId jdoe@company.com

#### All Groups that are synced from on-prem
> PS C:> Get-AzureADGroup -All $true | ?{$_.OnPremisesSecurityIdentifier -ne $null}

#### All Groups that are from AzureAD
> PS C:> Get-AzureADGroup -All $true | ?{$_.OnPremisesSecurityIdentifier -eq $null}  

> PS C:> Get-AzureADUser -SearchString 'test' | Get-AzureADUserMembership Get-AzureADUserMembership -ObjectId jdoe@company.com

#### Get all roles
> PS C:> Get-AzureADDirectoryRole

#### Get role definition
> PS C:> Get-AzureADMSRoleDefinition -Filter "displayName eq 'Global Administrator'"

#### List role assign to specific group
--> PrincipalId = ObjectId of the group  
> PS C:> Get-AzureADMSRoleAssignment -Filter "PrincipalId eq '57ada729-a581-4d6f-9f16-3fe0961ada82'"  

RoleDefinitionId  
```-----------------```  
d6c631b5-76af-4147-8b79-eab0b187861d  
05e8fe6f-05cb-4cac-bc26-a97175381949

> PS C:> Get-AzureADMSRoleDefinition -Filter "id eq '05e8fe6f-05cb-4cac-bc26-a97175381949'"

#### Get members of a directory role
> PS C:> Get-AzureADDirectoryRoleMember -ObjectId a3dko37k-f433-4jg  
> PS C:> Get-AzureADDirectoryRole -Filter "DisplayName eq 'Global Administrator'" | Get-AzureADDirectoryRoleMember

#### Enumerate users to whom roles are assigned
> PS C:> Get-AzureADDirectoryRole -Filter "DisplayName eq 'Global Administrator'" | Get-AzureADDirectoryRoleMember

#### Get all Azure joined and registered devices
> PS C:> Get-AzureADDevice -All $true | fl *

#### List registered users for all devices
> PS C:> Get-AzureADDevice -All $true | Get-AzureADDeviceRegisteredUser

#### List registered owners of all the devices
> PS C:> Get-AzureADDevice -All $true | Get-AzureADDeviceRegisteredOwner

#### List devices owned by a user
> PS C:> Get-AzureADUserOwnedDevice -ObjectId jdoe@company.com

#### List devices registered by a user
> PS C:> Get-AzureADUserRegisteredDevice -ObjectId jdoe@company.com

#### Get details information regarding a device
> PS C:> Get-AzureADDevice -objectid ff9f3fdb-1500-4b89-9ccd-1703f8ff9c91 | fl *

#### List devices managed using Intune
> PS C:> Get-AzureADDevice -All $true | ?{$_.IsCompliant -eq "True"}

#### Get all the application objects registered within current Tenant
> PS C:> Get-AzureADApplication -All $true

#### Get detail about an application
> PS C:> Get-AzureADApplication -ObjectId a1333e88-1278-41bf-8145-155a069ebed0 | fl *

#### Get owner of an application
> PS C:> Get-AzureADApplication -ObjectId a1333e88-1278-41bf-8145-155a069ebed0 | Get-AzureADApplicationOwner |fl *

#### Get Apps where a user has a role
> PS C:> Get-AzureADUser -ObjectId jdoe@company.com | Get-AzureADUserAppRoleAssignment | fl *

#### Get Apps where a Group has a role
> PS C:> Get-AzureADGroup -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e | Get-AzureADGroupAppRoleAssignment | fl *

#### Get all services principals
> PS C:> Get-AzureADServicePrincipal -All $true

#### Get detail about service principal
> PS C:> Get-AzureADServicePrincipal -ObjectId fe4650ea-5ad8-45ad-a318-25cda5aa02f4 | fl *

#### Get objects created by a specific service principal
> PS C:> Get-AzureADServicePrincipal -ObjectId cdddd16e-2611-4442-8f45-053e7c37a264 | Get-AzureADServicePrincipalCreatedObject

#### Gets a service principal application role assignment
> PS C:> Get-AzureADServicePrincipal -Filter "DisplayName eq 'IntuneApp'" | Get-AzureADServiceAppRoleAssignment | fl *

#### Get a service principal membership
> PS C:> Get-AzureADServicePrincipal -Filter "DisplayName eq 'IntuneApp'" | Get-AzureADServicePrincipalMembership | fl *


<br/>


## Az Module (old: AzureRM)
-https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.6.0    

```The Az PowerShell module is a set of cmdlets for managing Azure resources directly from PowerShell.```  
 
#### Connect using Az module
> PS C:> Connect-AzAccount   
===================================  

> PS C:> $creds = Get-Credential  

> PS C:> Connect-AzAccount -Credential $creds  
===================================  

> PS C:> $passwd = ConvertTo-SecureString
"Password123" -AsPlainText -Force  

> PS C:> $creds = New-Object System.Management.Automation.PSCredential
("jdoe@company.com", $passwd)  

> PS C:> Connect-AzureAD -Credential $creds  

#### Get current context
> PS C:> Get-AzContext

#### List available context
> PS C:> Get-AzContext -ListAvailable

#### Enumerate subscription accessible by the current user
> PS C:> Get-AzSubscription | fl *

#### Get role assign to you
> PS C:> Get-AzRoleAssignment

#### Get role assign to specific user
> PS C:> Get-AzRoleAssignment -ObjectId 0ccd6182-b034-4e13-a155-1021e7d22d22  
> PS C:> Get-AzRoleAssignment -UserPrincipalName jdoe@compay.com

#### Get all resources within your subscription visible to current user
> PS C:> Get-AzResource

#### Enumerate all users and specific user
> PS C:> Get-AzADUser  
> PS C:> Get-AzADUser -UserPrincipalName jdoe@company.com^

#### List all groups
> PS C:> Get-AzADGroup

#### List group membership
> PS C:> Get-AzADGroupMember -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e

#### Get resource groups within your subscription
> PS C:> Get-AzResourceGroup

#### Get all the application objects registered with the current tenant (visible in App registration in Azure portal)
> PS C:> GetAzADApplication | fl *

#### List virtual machines
> PS C:> Get-AZVM | fl *

#### List custom roles
> PS C:> Get-AzRoleDefinition | FT Name, IsCustom

#### Request for an access token (if already connected)
> PS C:> Get-AzAccessToken

#### Use access token
> PS C:> Connect-AzAccount -AccountId jdoe@company.com -AccessToken eyJ0eXAFegerfiojEF423dez21dzfsFZa443

#### Request for specific access token
> PS C:> (Get-AzAccessToken -Resource "https://graph.microsoft.com").Token

#### Use specific access token 
> PS C:> Connect-AzAccount -AccountId jdoe@company.com -AccessToken eyJ0eXAFegerfiojEF423dez21dzfsFZa443 -GraphAccessToken eyJ0eXAiOiJKV1QiLCJhbGciO

<br/>

## MSOnline cmdlets
- https://docs.microsoft.com/en-us/powershell/module/msonline/?view=azureadps-1.0  

```Older MSOnline V1 PowerShell module for Azure Active Directory. Customers are encouraged to use the newer [Azure](https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0) Active Directory V2 PowerShell module instead of this module.```  

If the Azure portal is locked down it is still possible to access Azure AD user information via MSOnline cmdlets.  
> PS C:> Import-Module MSOnline  
> PS C:> Connect-MsolService

#### Get all users
> PS C:> Get-MSolUser -All | fl

#### Get Company Level Information
> PS C:> Get-MsolCompanyInformation

#### Get all groups
> PS C:> Get-MSolGroup –All




<br/>

## AZ Cli
- https://docs.microsoft.com/en-us/cli/azure/install-azure-cli  
- https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest  

The AZ CLI can be installed on multiple platforms, it is also available directly within Cloud Shell.  

#### Connect using Az CLI
> az login

#### You can configure az cli to set some default behaviour (location, resource group ...)
> az configure

#### Find popular commands
> az find "vm"  

#### Find popular subcommands and parameters within "az vm list"
> az find "az vm list"  

#### List all the users in Azure AD and format output in table
> az ad user list --output table

#### Get details of the current tenant (require extension *account*)
> az account tenant list

#### Get details of the current subscription
> az account subscription list

#### Get current signed-in user
> az ad signed-in-user show

#### Get members of a group
> az ad group member list -g "VM Admins" --query "[].[displayName]" -o table

#### Check if a specific user is member of a specific group
> az ad group member check --group "VM Admins" --member-id b71d21f6-8e09-4a9d-932a-cb73df519787

