<template>
  <div class="q-pa-xs row items-start q-gutter-none">
    <q-list padding class="rounded-borders">
      <q-expansion-item
        v-for="query in queries"
        :key="`${query.title}`"
        dense
        dense-toggle
        expand-separator
        :label="query.title"
      >
        <q-card dark>
          <q-card-section>
            {{ query.cypher }}
          </q-card-section>
        </q-card>
      </q-expansion-item>
    </q-list>
  </div>
</template>

<script>
export default {
  name: "QueryView",
  data() {
    return {
      queries: [
        {
          title: "Show All Global Administrators",
          cypher:
            "MATCH (a:AADRole)<-[r:MemberOf]-(t) WHERE a.name = 'Company Administrator' RETURN *",
        },
        {
          title: "Show All AAD Roles",
          cypher: "MATCH (a:AADRole) RETURN *",
        },
        {
          title: "Show All RBAC Relationships",
          cypher: "MATCH (a)-[r]-(t) WHERE EXISTS(r.roleName) RETURN *",
        },
        {
          title: "Show All Owner Relationships",
          cypher: "MATCH (a)-[r]-(t) WHERE r.roleName = 'Owner' RETURN *",
        },
        {
          title: "Show All Contributor Relationships",
          cypher: "MATCH (a)-[r]-(t) WHERE r.roleName = 'Contributor' RETURN *",
        },
        {
          title: "Show All Relationships for Key Vaults",
          cypher: "MATCH (a)-[r]-(t) WHERE a.type = 'KeyVault' RETURN *",
        },
        {
          title: "Show All Service Principals with Cert or Password Counts",
          cypher:
            "MATCH (a:ServicePrincipal) WHERE a.keyCredentialCount > 0 or a.passwordCredentialCount > 0 RETURN *",
        },
        //https://github.com/lutzenfried/OffensiveCloud/blob/main/Azure/Azure%20cipher%20queries%20collection.md
        {
          title: "Show all Azure AD users",
          cypher: "MATCH (a:AADUser) RETURN *",
        },
        {
          title: "Show all Azure AD users which name attribute contains 'admin'",
          cypher: "MATCH (a:AADUser) WHERE a.name CONTAINS 'admin' RETURN *",
        },
        {
          title: "Show all Azure AD Groups",
          cypher: "MATCH (a:AADGroup) RETURN *",
        },
        {
          title: "Show user within group 'Marketing'",
          cypher: "MATCH (a:AADUser)-[r]-(b:AADGroup) WHERE b.name = 'Marketing' RETURN *",
        },
        {
          title: "Show all resources accessibles for specific user",
          cypher: "MATCH (b:AADUser)-[r]-(c:AzureResource) WHERE b.name = 'testuser' RETURN *",
        },
        {
          title: "Group membership for specific user",
          cypher: "MATCH (a:AADUser)-[r]-(b:AADGroup) WHERE a.userPrincipalName = 'jdoe@company.com' RETURN *",
        },
        {
          title: "Show all KeyVault",
          cypher: "MATCH (a:KeyVault) RETURN *",
        },
        {
          title: "Show all Azure AD Applications",
          cypher: "MATCH (a:AADApplication) RETURN *",
        },
        {
          title: "Show all Tenant",
          cypher: "MATCH (a:Tenant) RETURN *",
        },
        {
          title: "Show all AzureAD role assignements",
          cypher: "MATCH (t:AADRole)-[r]-(a) return *",
        },
        {
          title: "Check role for specific user",
          cypher: "MATCH (a:AADRole)-[r]-(b:AADUser) WHERE b.userPrincipalName = 'admin@defcorphq.onmicrosoft.com' RETURN *",
        },
        {
          title: "Show all Resources within all Resource Groups",
          cypher: "MATCH (t:ResourceGroup)-[r]-(a) return *",
        },
        {
          title: "Show all storage accounts",
          cypher: "MATCH (a:StorageAccount) RETURN *",
        },
        {
          title: "Show all Azure AD roles",
          cypher: "MATCH (a:AADRole) RETURN *",
        },
        {
          title: "Get user role inheritance from group",
          cypher: "MATCH (a:AADUser)-[r1]->(b:AADGroup)-[r2]->(c:AADRole) WHERE a.name = 'jdoe' RETURN *",
        },
        {
          title: "Show the Azure AD role Application Developer",
          cypher: "MATCH (a:AADRole) WHERE a.name = 'Application Developer' RETURN *",
        },
        {
          title: "Show all the Azure AD user with Application Developer Azure AD Role",
          cypher: "MATCH (a:AADRole)-[r]-(t:AADUser) WHERE (a.name = 'Application Developer') RETURN *",
        },
        {
          title: "Show all user with Application or Cloud Application administrator role assigned",
          cypher: "MATCH (a:AADRole)-[r]-(t:AADUser) WHERE (a.name = 'Application Administrator' OR a.name =
'Cloud Application Administrator') RETURN *",
        },
        {
          title: "Show all relationships for Virtual Machines",
          cypher: "MATCH (a)-[r]-(t) WHERE a.type = 'KeyVault' RETURN *",
        },
        {
          title: "Show all Windows Server Virtual Machines",
          cypher: "MATCH (a) WHERE a.type = 'VirtualMachine' AND a.licenseType = 'Windows_Server' RETURN *",
        },
        {
          title: "Show all user with a role assign to a Virtual Machine (ex: Reader)",
          cypher: "MATCH (a:AADUser)-[r]-(b:VirtualMachine) RETURN *",
        },
        {
          title: "Show all object with contributor role assign to a Virtual Machine",
          cypher: "MATCH (a)-[r]-(t:VirtualMachine) WHERE r.roleName = 'Contributor' RETURN *",
        },
        {
          title: "Show all RBAC relationships for specific user",
          cypher: "MATCH (a:AADUser)-[r]-(t) WHERE EXISTS(r.roleName) AND a.userPrincipalName CONTAINS 'admin' RETURN *",
        },
        {
          title: "Show any object with Contributor OR Owner role over a ServicePrincipal OR Application",
          cypher: "MATCH (a)-[r]-(t) WHERE (r.roleName = 'Contributor' OR r.roleName = 'Owner') AND (a.objectType = 'ServicePrincipal' OR a.objectType = 'Application') RETURN *",
        },
        {
          title: "Show all Running Websites",
          cypher: "MATCH (a:WebSite)-[r]-(b) WHERE a.state = 'Running' RETURN *",
        },
        {
          title: "Show all Running WebSite and relation with specific user",
          cypher: "MATCH (a:WebSite)-[r]-(b:AADUser) WHERE a.state = 'Running' AND b.userPrincipalName CONTAINS 'test' RETURN *",
        },
        {
          title: "Show all roles assigned to all Service Principals",
          cypher: "MATCH (a:AADRole)-[r]-(b:AADServicePrincipal) RETURN *",
        },
        {
          title: "Find user with path to Service Principal",
          cypher: "MATCH (a:AADUser)-[r]->(b:AADApplication)-[r1]->(c:AADServicePrincipal)-[r2]->(d:AADRole) RETURN *",
        },
      ],
    };
  },
};
</script>
