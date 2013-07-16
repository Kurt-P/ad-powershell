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
#The event ID may need to be changed.
$printLog = Get-WinEvent -LogName $log -ComputerName $server -FilterXPath "*[System[(EventID=307)]]"

#The magic number of pages/print job
[int]$magicNumber = 50

Function getAllPrintLogs {
    $printLogs = @()    #The print log is stroed as an array
    $abuseUsers = @()
    
    #We need to sort through the logs and sort out the data we want
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

    #We want a running total of the pages a user has printed
    $gdata = $printLogs | Group-Object -Property userId

    #Total for all users
    $allPrints = @()
    #Those user who printed over the $magicNumber
    $abusePrinters = @()

    #Sum all pages used/user
    $allPrints += foreach($item in $gdata) {
        $item.Group | Select -Unique userId,
        @{Name = 'PageTotal';Expression = {(($item.Group) | measure -Property pages -Sum).Sum}}
    }

    #Export the list to a CSV file
    ##TODO: CAN THE PATH BE VAR?
    $allPrints | epcsv -Path "$HOME\$fileName-AllPrints.csv" -NoTypeInformation
    
    #Sort out those users who are over the $magicNumber page limit
    foreach ($line in $allPrints) {
        if ($line.PageTotal -ge $magicNumber) {
            $abusePrinters += $line
        }
    }

    #Export that this to a CSV file
    ##TODO: CAN THE PATH BE VAR?
    $abusePrinters | epcsv -Path "$HOME\$fileName-Abuse.csv" -NoTypeInformation
}

##UNCOMMENT FOR TESTING
#getAllPrintLogs
