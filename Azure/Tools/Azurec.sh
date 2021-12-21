# Azurec : Simple Azure tenant and valid user enumeration tool
# Lutzenfried

function help()
{
   # Display Help
   echo -e "\n+++ Unauthenticated recon tool for Azure +++"
   echo -e "--------------------------------------------"
   echo "Syntax: ./azurec.sh -h"
   echo "Example: ./azurec.sh company.com /tmp/emails.txt"
   echo -e "\nOptions :"
   echo "-h     Print this Help."
   echo -e "--> Output file for valid email is written within the current directory in $(tput bold)validEmails.txt"
   echo ""
}

# Get the help menu
while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

# Start
echo -e "\n\a+++++ Unauthenticated Recon tool for Azure infrastructure +++++\n"
echo -e "Looking for Azure information on target : $1\n"
input=$2
output=./validEmails.txt

# Getting Information if domain is managed, Federated or unknown and authentication URL (AuthURL)
function reconTenant () {
    echo -e "\n---------- Tenant Enumeration ----------"
    domainState=`curl -s https://login.microsoftonline.com/getuserrealm.srf/?login=$1 | jq .NameSpaceType` 
    AuthURL=`curl -s https://login.microsoftonline.com/getuserrealm.srf/?login=$1 | jq .AuthURL`

    if [ "$domainState" = "\"Unknown\"" ]; then
        echo -e ">>>>> Azure Domain is : Unknown"

    elif [ "$domainState" = "\"Managed\"" ]; then
        echo -e ">>>>> Azure Domain is : Managed"

    elif [ "$domainState" = "\"Federated\"" ]; then
        echo -e ">>>>> Azure Domain is : Federated"
        echo -e ">>>>> Authentication URL : " $AuthURL

    else
        echo -e "--- Please verify your submitted domain name ---"
    fi
}

# Enumerate valids emails address
function enumerateUsers () {
    echo -e "\n---------- User enumeration ----------"
    while IFS= read -r user
    do
        respCode=`curl -s -X POST https:///login.microsoftonline.com/common/GetCredentialType --data '{"Username":"'"$user"'"}' | jq .IfExistsResult`
        
        if [ "$respCode" = 1 ]; then
            echo "--- User : $user doesn't exist"
        elif [ "$respCode" = 0 ]; then
            echo ">>>>> User : $user is VALID"
            echo $user>>$output
        elif [ "$respCode" = 5 ]; then
            echo "--- User : $user : Account exists but uses different IdP other than Microsoft"
        elif [ "$respCode" = 6 ]; then
            echo "--- User : $user : Account exists and is setup to use the domain and an IdP other than Microsoft"
        fi
    
    done < "$input"
}

# Getting Tenant ID for targeted domain
tenantId=`curl -s https://login.microsoftonline.com/$1/v2.0/.well-known/openid-configuration | jq .token_endpoint | cut -d "/" -f 4`

if [ $tenantId = "null" ]; then
    echo -e "--- Please verify your submitted domain name ---"
else
    echo -e ">>>>> Tenant ID : $tenantId"
    reconTenant $1
    enumerateUsers
fi
