#!/usr/bin/env python3

import requests
import sys
from colorama import Fore, Style

endpoint = "https://storage.googleapis.com/"+sys.argv[1]+"/"
wordlist = open("./wordlist.txt")

for name in wordlist:

    url = endpoint + str(name)
    r = requests.get(url.strip("\n"))

    if r.status_code == 404 and "NoSuchKey" in r.text:
        print ("Not Found : " + name.strip("\n"))

    elif r.status_code == 403 and "AccessDenied" in r.text:
        print ("Access Denied : " + name.strip("\n"))

    elif r.status_code == 200:
        print (Fore.GREEN + "============> Valid file found : " + name.strip("\n"))
        with open('./validFiles.txt', 'a') as f:
            f.write(url)
        print (Style.RESET_ALL)

wordlist.close()
