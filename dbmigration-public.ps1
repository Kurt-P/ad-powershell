
###########################################################################
#dbmigration.ps1                                                          #
#Backs up databases and moves them to a new server                        #
#Author: Levi Webster 1344 on 06242013                                    #
###########################################################################
#Use at your own risk. There are a couple issues with the script that you need 
#to look out for.
#Steps
#1. Set Variables
#2. Backup
#3. Copy to new server
#4. Restore to new server

Import-Module SQLPS -DisableNameChecking

#Change the drive to c
C:

#$fs needs to be on a local drive. It cannot find network drives :(----------> Lame
$fs = 'C:\db-backup\'
#Text file of databases to backup and restore
$dbList = 'list.txt'
#No changes here. Just gets and formats things correctly... Nothing to see, move along
$dbListCP = $fs + $dbList
$dbNames = Get-Content $dbListCP
#db server + instance. Change to reflect environment 
$server = 'UMC-DB1'


#Make some backups
foreach($db in $dbNames){
    
    Backup-SqlDatabase -ServerInstance $server -Database $db -BackupFile "$fs\$($db).bak" -Verbose

}


#Change the directory to c and copy backups to new server
Copy-Item '\\umc-db1\c$\db-backup\*' $destinationServer


#Lets over right the server with the new server to prevent accidents.
$server = 'umc-cs-levidt\Artemis'


#Restore to new server
foreach($db in $dbNames){

    Restore-SqlDatabase -ServerInstance $server -Database $db -BackupFile "$fs\$($db).bak" -ReplaceDatabase -Verbose
}