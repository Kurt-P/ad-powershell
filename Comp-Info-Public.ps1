########################################################################
#Name: Comp-Info.ps1                                                   #
#About: Use to get computer information from AD                        #
#       Displays Name, OperatingSystem,LastLoginDate                   #
#Author: Levi Webster                                                  #
#Date/Time: 924 06062013                                               #
########################################################################

#$searchBase is the OU OU information EX: OU=Computers,OU=Someplace,DC=ad,DC=something,DC=edu
#edit searchbase for your ad structure
$searchBase = '<YOUR OU HERE>'

#Gather the Name, OperatingSystem, LastLoginDate
$computerNames = Get-ADComputer -Filter {Name -like "umc-*"} -Properties Name,OperatingSystem -SearchBase "$searchBase" | Select-Object Name,OperatingSystem,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
#Export to CSV
$computerNames | Export-Csv 'C:\Users\Public\compName.csv'