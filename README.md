ad-powershell
=============

AD Module Powershell Scripts

###############################
#ad-bulk-remove-comp-Public.ps1
###############################
Description:
Use this script to remove computers from an ad environment. Use with caution as negative side effects may occur.
Details on usage can be found in the scripts comments. Feel free to use/modify the scripts.

#####################
#Comp-Info-Public.ps1
#####################
Description:
Use this script to query AD and get a list of computer names, the operating system, and last login date. 
Currently there is a bug with the last login date but I hope to get that fixed soon.
Details on usage can be found in the scripts comments. Feel free to use/modify the scripts.

#######################
#Unique-Group-Count.ps1
#######################
Description:
This script groups items in an array and then will sum create a sum of an item in the group.
It is currently used for counting pages printed per user. It groups by user than totals the pages.
Feel free to use/modify the scripts.

##################
#dbmigration.ps1                                                          
##################
Description: 
Use this script to backup and restore databases. It uses the new server 2012 SQLPS module for doing this.
The SQLPS module makes life much easier that SMO. Feel free to use/modify the scripts.
