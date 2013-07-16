ad-powershell
=============

AD Module PowerShell Scripts

###############################
#ad-bulk-remove-comp-Public.ps1
###############################
Description:
Use this script to remove computers from an ad environment. Use with caution as 
negative side effects may occur. 
*Details on usage can be found in the scripts comments*

#####################
#Comp-Info-Public.ps1
#####################
Description:
Use this script to query AD and get a list of computer names, the operating system, 
and last login date. Currently there is a bug with the last login date but I 
hope to get that fixed soon.

*Details on usage can be found in the scripts comments. Feel free to use/modify the scripts.*

#######################
#Unique-Group-Count.ps1
#######################
Description:
This script groups items in an array and then will sum create a sum of an item in the group.
It is currently used for counting pages printed per user. It groups by user than totals the pages.
Details on usage can be found in the scripts comments.

#############################################
#printparserwin2008-R2-GetPrintLogsAndSum.ps1
#############################################
Description:
The purpose of printparserwin2008-R2-GetPrintLogsAndSum.ps1 is to connect to a
remote print server running Windows Server 2008 R2, and get the print logs.
After acquiring those logs, it takes all print jobs by a user and sums the total
amount of pages they have printed.

##################
#dbmigration-public.ps1
##################

Description: 
Use this script to backup and restore databases. It uses the new server 2012 
SQLPS module for doing this.The SQLPS module makes life much easier that SMO.

######################
#AccountManagement.ps1
######################
Description: This is an interactive script for easily and quickly disabling, 
enabling, and unlocking AD account.

__*NOTE: Not all of the methods in this script have been tested*__


**Feel free to use/modify the scripts**
