Function Add-AzADAppSecret
{

<#
    .SYNOPSIS
        Add client secret to the applications.

    .PARAMETER GraphToken
        Pass the Graph API Token 

    .EXAMPLE
        PS C:\> Add-AzADAppSecret -GraphToken 'eyJ0eX..'

    .LINK
        https://docs.microsoft.com/en-us/graph/api/application-list?view=graph-rest-1.0&tabs=http
        https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
#>

    [CmdletBinding()]
    param(
    [Parameter(Mandatory=$True)]
    [String]
    $GraphToken = $null
    )

    $AppList = $null
    $AppPassword = $null

    # List All the Applications


    $Params = @{
     "URI"     = "https://graph.microsoft.com/v1.0/applications"
     "Method"  = "GET"
     "Headers" = @{
     "Content-Type"  = "application/json"
     "Authorization" = "Bearer $GraphToken"
     }
    }

    try
    { 
        $AppList = Invoke-RestMethod @Params -UseBasicParsing
    }
    catch
    {
    }

    # Add Password in the Application

    if($AppList -ne $null)
    {
        [System.Collections.ArrayList]$Details = @()

        foreach($App in $AppList.value)
        {
            $ID = $App.ID
            $psobj = New-Object PSObject

            $Params = @{
             "URI"     = "https://graph.microsoft.com/v1.0/applications/$ID/addPassword"
             "Method"  = "POST"
             "Headers" = @{
             "Content-Type"  = "application/json"
             "Authorization" = "Bearer $GraphToken"
             }
            }

            $Body = @{
              "passwordCredential"= @{
                "displayName" = "Password"
              }
            }
 
            try
            {
                $AppPassword = Invoke-RestMethod @Params -UseBasicParsing -Body ($Body | ConvertTo-Json)
                Add-Member -InputObject $psobj -NotePropertyName "Object ID" -NotePropertyValue $ID
                Add-Member -InputObject $psobj -NotePropertyName "App ID" -NotePropertyValue $App.appId
                Add-Member -InputObject $psobj -NotePropertyName "App Name" -NotePropertyValue $App.displayName
                Add-Member -InputObject $psobj -NotePropertyName "Key ID" -NotePropertyValue $AppPassword.keyId
                Add-Member -InputObject $psobj -NotePropertyName "Secret" -NotePropertyValue $AppPassword.secretText
                $Details.Add($psobj) | Out-Null
            }
            catch
            {
                Write-Output "Failed to add new client secret to '$($App.displayName)' Application." 
            }
        }
        if($Details -ne $null)
        {
            Write-Output ""
            Write-Output "Client secret added to : " 
            Write-Output $Details | fl *
        }
    }
    else
    {
       Write-Output "Failed to Enumerate the Applications."
    }
}
