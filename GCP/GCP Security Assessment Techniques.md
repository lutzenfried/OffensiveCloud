# GCP Cloud Penetration Testing starting position
## Full black box penetration testing  
	Attacking exposed cloud perimeter, from the external.
	--> Require important recon and OSINT to find potential cloud endpoint or credential leak.
	--> Unauthenticated
	--> Attacking public resources
	--> This could lead to no result if the cloud component are correctly configured in secure manner.
	--> Should be associated with AssumeBreach approach

## AssumeBreach scenario (Grey Box)
	Attacking Cloud environment assuming GCP user credentials or service account have been leaked (Github repo, source code disclo, phishing, Google Compute Instance (VM) compromise ...)
	--> Require an account with classic cloud user, for example development user, audit user, user role used one day to day operation.
	--> The main goal is to assess the capabilities for a unpriviliged user or service account  within the cloud environment to take full control over the GCP Organization/Project, to escalate its privileges or to access sensitive data.
	--> Testing internal cloud resources from another resource such as a Google Compute instance (VM)
	--> Internal API access : authenticated, identify vulnerabilities via API calls and configuration analysis

## GCP Cloud Security Audit (White Box)
	--> Require at least **roles/editor** primitive role on the project level or organization level  
	--> The main goal is to assess the whole security misconfiguration which can occur within GCP environments and GCP components 
	--> Some technical exploitation could be realized depending on the misconfiguration or vulnerabilities found