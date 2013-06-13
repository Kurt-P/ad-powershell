#####################################################
# This script reads the logs off of server 2012 R2  #
# The output is a csv file off print jobs           #
# This script is based on an earlier version by     #
# Levi Webster                                      #
#                                                   #
# Written by Levi Webster & Kurt Prudhomme          #
# Date 06/12/2013                                   #
#####################################################

#Time
$date = date -Format MM.dd.yyyy
$today = (date).DayOfYear

#This is the server name to get logs from
$server = ''

#File name creaton
#SimpleName is used for the output file name
$simpleName = 'PLACEHOLDER'
$fileName = $date + $simpleName

#Log is the log to read
$log = 'Microsoft-Windows-PrintService/Operational'
#The event ID may have to be changed.
$printLog = Get-WinEvent -LogName $log -ComputerName $server -FilterXPath "*[System[(EventID=307)]]"

#The magic number of pages/print job
[int]$magicNumber = 

##Get all of the print logs from the print server
Function getAllPrintLogs {
    $functionName = '-All_logs'
    $printLogs = @()    #The print log is stroed as an array
    
    foreach ($logLine in $printLog) {
        #Lets create are array of awesome objects. Value on the left = column. Right value = what we are getting
        $cleanLog = New-Object -TypeName PSObject -Property @{
            dateTime = $logLine.TimeCreated
            userId = $logLine.Properties[2].Value
            documentName = $logLine.Properties[1].Value
            printer = $logLine.Properties[4].Value
            pages = $logLine.Properties[7].Value
        }
        $printLogs += $cleanLog
    }

    $gdata = $printLogs | Group-Object -Property userId

    $test = @()

    $test += foreach($item in $gdata) {
        $item.Group | Select -Unique userId,
        @{Name = 'PageTotal';Expression = {(($item.Group) | measure -Property pages -Sum).Sum}}
    }

    ##TODO: CAN THIS BE DONE WITH A GLOBAL VAR?
    $test | epcsv -Path "$HOME\$fileName$functionName.csv" -NoTypeInformation

}

##Get only the print logs that are over the $magicNumber
Function getAbusivePrinters {
    $functionName = '-Abuse_Report'
    $printLogs = @()

    foreach ($logLine in $printLog) {
        if ($logLine.TimeCreated.DayOfYear -eq $today -AND [int]$logLine.Properties[7].Value -ge $magicNumber) {
            $cleanLog = New-Object -TypeName PSobject -Property @{
                dateTime = $logLine.TimeCreated
                userId = $logLine.Properties[2].Value
                documentName = $logLine.Properties[1].Value
                printer = $logLine.Properties[4].Value
                pages = $logLine.Properties[7].Value
            }
            $printLogs += $cleanLog
        }
    }
    
    $gdata = $printLogs | Group-Object -Property userId

    $test = @()

    $test += foreach($item in $gdata) {
        $item.Group | Select -Unique userId,
        @{Name = 'PageTotal';Expression = {(($item.Group) | measure -Property pages -Sum).Sum}}
    }

    $test | epcsv -Path "$HOME\$fileName$functionName.csv" -NoTypeInformation
}

#UNCOMMENT FOR TESTING
#getAllPrintLogs
#getAbusivePrinters
