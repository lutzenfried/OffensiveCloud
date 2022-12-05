import requests 

token = "eyXXXXXXXX"
uri = 'https://graph.microsoft.com/v1.0/users?$top=999'
auth={'Authorization': token}

usersEmail=set()
urls=set()

#Microsoft Graph is limited to 999 users per request. In case of more than 999 users within the Azure AD Tenant this function provide iteratives web scraping for graph URL to retrieve all the users.
def iterateURL(urlNext):
    try:
        urls.add(urlNext)
        print("- 2. URL Graph API Scraping : ", urlNext,"\n")
        requrl = requests.get(urlNext, headers=auth)
        tempJsonResponse = requrl.json()
        iterateURL(tempJsonResponse["@odata.nextLink"])    
    
    except:
        print("--- URL scraping over, no more Graph URL to discover ---\n")
    
    return urls
    
#Retrieving user email within JSON response based on userPrincipalName value            
def getUsersEmails(jsonResponse):
    for id in range(0,999):
        upn = (jsonResponse["value"][id]["userPrincipalName"])
        if upn:
            usersEmail.add(upn)
        else:
            continue
    urlNext = jsonResponse["@odata.nextLink"]
    iterateURL(urlNext)
    
    print("- 3. Parsing URLs to retrieve additional user's email \n")
    for url in urls:
        r = requests.get(url, headers=auth)
        jsonResponse = r.json()
        try:
            for id in range(0,999):
                upn = (jsonResponse["value"][id]["userPrincipalName"])
                if upn:
                    usersEmail.add(upn)
                else:
                    continue
        except:
            print("- 4. End of user's dump\n")
        
    print("+++ All users retrieved : Total unique user : ", len(usersEmail),"+++\n")
    for user in usersEmail:
        f = open("userGraphAPI_Emails.txt", "a")
        f.write(user+"\n")
        f.close()
    print("+++ Dump File : userGraphAPI_Emails.txt file +++")

def initialRequest(uri,auth):
    print("++++ Graph API Parser ++++\n")
    r = requests.get(uri, headers=auth)
    jsonResponse = r.json()
    print("- 1. Retrieving first batch of user's email\n")
    getUsersEmails(jsonResponse)

if __name__ == "__main__":
    initialRequest(uri,auth)