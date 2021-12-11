# Azure Cypher Queries

Azure Active Directory cypher queries for Neo4j database. These queries could help as red teamer or blue teamer identify exploitation path, permissions issues or misconfiguration to protect your Azure Cloud environment.  

Only **1** syntax are available for [Stormspotter](https://github.com/Azure/Stormspotter) tool.

## StormSpotter syntax

#### Show all Azure AD users
```
MATCH (a:AADUser) RETURN *
```

#### Show all Azure AD users which name attribute contains 'admin'
```
MATCH (a:AADUser) WHERE a.name CONTAINS 'admin' RETURN *
```

#### Show all Azure AD Groups
```
MATCH (a:AADGroup) RETURN *
```

#### Show user within group 'Marketing'
```
MATCH (a:AADUser)-[r]-(b:AADGroup) WHERE b.name = 'Marketing' RETURN *
```

#### Show all resources accessibles for specific user
```
MATCH (b:AADUser)-[r]-(c:AzureResource) WHERE b.name = 'testuser' RETURN *
```

#### Group membership for specific user
```
MATCH (a:AADUser)-[r]-(b:AADGroup) WHERE a.userPrincipalName = 'jdoe@company.com' RETURN *
```

#### Show all KeyVault
```
MATCH (a:KeyVault) RETURN *
```

#### Show all Azure AD Applications
```
MATCH (a:AADApplication) RETURN *
```

#### Show all Tenant
```
MATCH (a:Tenant) RETURN *
```

#### Show all AzureAD role assignements
```
MATCH (t:AADRole)-[r]-(a) return *
```

#### Check role for specific user
```
MATCH (a:AADRole)-[r]-(b:AADUser) WHERE b.userPrincipalName = 'admin@defcorphq.onmicrosoft.com' RETURN *
```

#### Show all Resources within all Resource Groups
```
MATCH (t:ResourceGroup)-[r]-(a) return *
```

#### Show all storage accounts
```
MATCH (a:StorageAccount) RETURN *
```

### Show all Global Administrators
```
MATCH (a:AADRole)<-[r:MemberOf]-(t) WHERE a.name = 'Global Administrator' RETURN *
```

#### Show all RBAC relationships
```
MATCH (a)-[r]-(t) WHERE EXISTS(r.roleName) RETURN *
```

#### Show all Azure AD roles
```
MATCH (a:AADRole) RETURN *

```

#### Get user role inheritance from group
```
MATCH (a:AADUser)-[r1]->(b:AADGroup)-[r2]->(c:AADRole) WHERE a.name = 'jdoe' RETURN *
```

#### Show the Azure AD role Application Developer
``` 
MATCH (a:AADRole) WHERE a.name = 'Application Developer' RETURN *
```

#### Show all the Azure AD user with Application Developer Azure AD Role
```
MATCH (a:AADRole)-[r]-(t:AADUser) WHERE (a.name = 'Application Developer') RETURN *
```

#### Show all user with Application or Cloud Application administrator role assigned
```
MATCH (a:AADRole)-[r]-(t:AADUser) WHERE (a.name = 'Application Administrator' OR a.name =
'Cloud Application Administrator') RETURN *
```

#### Show all relationships for Virtual Machines
```
MATCH (a)-[r]-(t) WHERE a.type = 'KeyVault' RETURN *
```

#### Show all Windows Server Virtual Machines
```
MATCH (a) WHERE a.type = 'VirtualMachine' AND a.licenseType = 'Windows_Server' RETURN *
```

#### Show all user with a role assign to a Virtual Machine (ex: Reader)
```
MATCH (a:AADUser)-[r]-(b:VirtualMachine) RETURN *
```

#### Show all object with contributor role assign to a Virtual Machine
```
MATCH (a)-[r]-(t:VirtualMachine) WHERE r.roleName = 'Contributor' RETURN *
```

#### Show all user with role assign to Applications
```
MATCH (a:AADUser)-[r]-(b:AADApplication) RETURN *
```

#### Show all RBAC relationships for specific user containing 'admin' within *userPrincipalName* attribute
```
MATCH (a:AADUser)-[r]-(t) WHERE EXISTS(r.roleName) AND a.userPrincipalName CONTAINS 'admin' RETURN *
```

#### Show any object with Contributor OR Owner role over a ServicePrincipal OR Application
```
MATCH (a)-[r]-(t) WHERE (r.roleName = 'Contributor' OR r.roleName = 'Owner') AND (a.objectType = 'ServicePrincipal' OR a.objectType = 'Application') RETURN *
```

#### Show all Running Websites
```
MATCH (a:WebSite)-[r]-(b) WHERE a.state = 'Running' RETURN *
```

#### Show all Running WebSite and relation with specific user based on string contained within *userPrincipalName* attribute
```
MATCH (a:WebSite)-[r]-(b:AADUser) WHERE a.state = 'Running' AND b.userPrincipalName CONTAINS 'test' RETURN *
```

#### Show all roles assigned to all Service Principals
```
MATCH (a:AADRole)-[r]-(b:AADServicePrincipal) RETURN *
```

#### Find user with path to Service Principal 
```
MATCH (a:AADUser)-[r]->(b:AADApplication)-[r1]->(c:AADServicePrincipal)-[r2]->(d:AADRole) RETURN *
```


