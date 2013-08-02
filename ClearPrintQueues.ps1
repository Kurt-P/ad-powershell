#####################################################
# This script will get all print jobs older than    #
# a set amount of hours, and delete them from the   #
# print queue(s).                                   #
#                                                   #
# Written by Kurt Prudhomme                         #
# Date 07/31/2013                                   #
#####################################################

#$age should be such that -24 <= $age <= -1 (age is mesured in hours)
[int]$age = -1
$old = (Get-Date).AddHours($age)

#Get the print jobs; sort out the job older than $age; delete them.
Get-WmiObject Win32_PrintJob | 
Where-Object { $_.ConvertToDateTime($_.TimeSubmitted) -lt $old } | 
Foreach-Object { $_.Delete() }
