#####################################################
# This is a script that will clear out print queues #
# of documents older than a specified date or time. #
# The idea behind this script is to run it on a 	#
# Windows 2008 R2 server used for printer sharing 	#
# To help manage the printers and clear old docs out#
# when they get to old because they were left in 	#
# queue because of an error or something.           #
#                                                   #
# Written by Kurt Prudhomme                         #
# Date 07/31/2013                                   #
#####################################################

#$age should be such that -24 <= $age <= -1 (age is mesured in hours)
#Else the script may not do anything or it may delete print jobs that may not 
#need to be deleted.
[int]$age = -1
$old = (Get-Date).AddHours($age)

Get-WmiObject Win32_PrintJob | 
Where-Object { $_.ConvertToDateTime($_.TimeSubmitted) -lt $old } | 
Foreach-Object { $_.Delete() }
