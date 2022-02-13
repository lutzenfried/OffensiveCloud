#!/usr/bin/env python3

#Multi-threading GCP bucket brute force file
#If the GCP bucket is configured correctly and file listing is not possible. It is possible that the owner of the bucket forgot to set the permissions on sensitive files uploaded to that bucket, this script intends to brute force potential unprotected files.
#Credits : Lutzenfried

#USAGE : python3 enumFilesStorage.py <GCPBucketName> <threads number>
#Example : python3 enumFilesStorage.py cdn_test 16

import requests
import sys
import concurrent.futures
from colorama import Fore, Style

endpoint = "https://storage.googleapis.com/"+sys.argv[1]+"/"
wordlist = open("./wordlist.txt")

def scanBucket(endpoint,wordlist):
    for name in wordlist:

        url = endpoint + str(name)
        r = requests.get(url.strip("\n"))

        if r.status_code == 404 and "NoSuchKey" in r.text:
            print ("Not Found : " + name.strip("\n"))

        elif r.status_code == 403 and "AccessDenied" in r.text:
            print ("Access Denied : " + name.strip("\n"))

        elif r.status_code == 200:
            print (Fore.GREEN + "============> Valid file found : " + name.strip("\n"))
            with open('./validFiles.txt', 'a+') as f:
                f.write(url)
            print (Style.RESET_ALL)

    wordlist.close()

if __name__ == '__main__':
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future1 = [executor.submit(scanBucket, endpoint, wordlist) for _ in range(int(sys.argv[2]))]