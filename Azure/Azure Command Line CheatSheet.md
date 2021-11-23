# Azure command line and PowerShell modules

- AzureAD
- Az Module
- MSOnline cmdlets
- AZ cli


## AzureAD Module
#### Connect using AzureAD
> PS C:> Connect-AzureAD  

#### Get the current session state
> PS C:>  Get-AzureADCurrentSessionInfo

#### Enumerate users
> PS C:>  Get-AzureADUser -All $true  
> PS C:>  Get-AzureADUser -ObjectId jdoe@company.com  
> PS C:>  Get-AzureADUser -All $true | ?{$_.Displayname -match "admin"}  
> PS C:>  AzureADUser -ObjectId test@company.com | fl *

#### All user who are synced from on premise
> PS C:> Get-AzureADUser -All $true |?{$_.OnPremisesSecurityIdentifier -ne $null}

#### All users who are from AzureAD
> PS C:> Get-AzureADUser -All $true |?{$_.OnPremisesSecurityIdentifier -eq $null}

#### Objects owned by a specific user
> PS C:> Get-AzureADUserOwnedObject -ObjectId admin@company.gom

#### Enumerate specific group
> PS C:> Get-AzureADGroup -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e

#### Groups which contain the word "admin" in their name
> PS C:> Get-AzureADGroup -All $true |?{$_.Displayname -match "admin"}

#### Get members of a group
> PS C:> Get-AzureADGroupMember -ObjectId 783a312d-0de2-4490-92e4-539b0e4ee03e

#### Get Groups and Roles where specific user is member
> PS C:> Get-AzureADUser -SearchString 'jdoe' | Get-AzureADUserMembership
> PS C:> Get-AzureADUserMembership -ObjectId jdoe@company.com

#### Get all roles
> PS C:> Get-AzureADDirectoryRole

#### Enumerate users to whom roles are assigned
> PS C:> Get-AzureADDirectoryRole -Filter "DisplayName eq 'Global Administrator'" | Get-AzureADDirectoryRoleMember

#### Get all Azure joined and registered devices
> PS C:> Get-AzureADDevice -All $true | fl *

#### List registered users for all devices
> PS C:> Get-AzureADDevice -All $true | Get-AzureADDeviceRegisteredUser






## Az Module
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

#### Get role assign to you
> PS C:> Get-AzRoleAssignment

#### Get all resources within your subscription
> PS C:> Get-AzResource

#### Get resource groups within your subscription
> PS C:> Get-AzResourceGroup




## MSOnline cmdlets
If the Azure portal is locked down it is still possible to access Azure AD user information via MSOnline cmdlets.  
> PS C:> Import-Module MSOnline
> PS C:> Connect-MsolService

#### Get all users
> PS C:> Get-MSolUser -All | fl

#### Get Company Level Information
> PS C:> Get-MsolCompanyInformation

#### Get all groups
> PS C:> Get-MSolGroup –All